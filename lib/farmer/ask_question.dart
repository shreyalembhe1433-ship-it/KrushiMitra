import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krushimitra/farmer/FarmerHome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'dart:typed_data';

class AskQuestionScreen extends StatefulWidget {
  const AskQuestionScreen({super.key});

  @override
  State<AskQuestionScreen> createState() => _AskQuestionScreenState();
}

class _AskQuestionScreenState extends State<AskQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  XFile? selectedImage;
  String? category;

  static const green = Color(0xFF087F5B);

  final categories = [
    'Crop Disease',
    'Fertilizer Problem',
    'Pest Control',
    'Soil Problem',
    'Irrigation',
    'Other',
  ];
  Future<void> pickImage() async {
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null || !mounted) return;

    setState(() {
      selectedImage = image;
    });
  }

Future<String?> addImage() async {
  if (selectedImage == null) return null;

  try {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('Please login first');
    }

    final imagePath =
        '${user.uid}/${DateTime.now().millisecondsSinceEpoch}_${selectedImage!.name}';

    debugPrint('Uploading image: $imagePath');

    // Upload image to Supabase Storage
    final uploadResult = await Supabase.instance.client.storage
        .from('question-images')
        .uploadBinary(
          imagePath,
          await selectedImage!.readAsBytes(),
        );

    debugPrint('Upload successful: $uploadResult');

    // Get public image URL
    final String imageUrl = Supabase.instance.client.storage
        .from('question-images')
        .getPublicUrl(imagePath);

    debugPrint('Image URL: $imageUrl');

    if (!mounted) return imageUrl;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Photo uploaded successfully!')),
    );

    return imageUrl;
  } catch (e, stackTrace) {
    debugPrint('IMAGE UPLOAD ERROR: $e');
    debugPrint('STACK TRACE: $stackTrace');

    if (!mounted) return null;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Upload failed: $e')),
    );

    return null;
  }
}

  Future<void> _submitQuestion() async {
    if (!_formKey.currentState!.validate()) return;

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please login first.')));
      return;
    }

    try {
      // Upload image only once, when submitting
      String? imageUrl;

      if (selectedImage != null) {
        imageUrl = await addImage();

        if (imageUrl == null) {
          return; // Stop if image upload fails
        }
      }

      await FirebaseFirestore.instance.collection('questions').add({
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'category': category,
        'farmerId': user.uid,
        'status': 'Pending',
        'answer': '',
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      _titleController.clear();
      _descriptionController.clear();

      setState(() {
        category = null;
        selectedImage = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Question submitted successfully!')),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Submission failed: $e')));
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F4),
      appBar: AppBar(
        title: const Text('Ask a Question'),
        backgroundColor: Colors.white,
        foregroundColor: green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Farmerhome()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Describe Your Problem',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ask your question and get guidance.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 25),

              const Text('Problem Title *'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                decoration: _decoration('Enter problem title'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Enter problem title'
                    : null,
              ),

              const SizedBox(height: 20),
              const Text('Description *'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: _decoration('Describe your problem in detail...'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Enter description'
                    : null,
              ),

              const SizedBox(height: 20),
              const Text('Select Category *'),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: category,
                isExpanded: true,
                decoration: _decoration('Choose category'),
                items: categories.map((item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                onChanged: (value) {
                  setState(() => category = value);
                },
                validator: (value) =>
                    value == null ? 'Select a category' : null,
              ),

              const SizedBox(height: 22),
              OutlinedButton.icon(
                onPressed: pickImage,
                icon: const Icon(Icons.add_a_photo),
                label: const Text('Add Photo'),
              ),
              if (selectedImage != null) ...[
                const SizedBox(height: 12),
                FutureBuilder<Uint8List>(
                  future: selectedImage!.readAsBytes(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(
                        snapshot.data!,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      selectedImage = null;
                    });
                  },
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Remove Photo'),
                ),
              ],
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _submitQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Submit Question',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _decoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: green, width: 1.5),
      ),
    );
  }
}
