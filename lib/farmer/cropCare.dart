import 'package:flutter/material.dart';

class CropCareScreen extends StatelessWidget {
  const CropCareScreen({super.key});

  static const green = Color(0xFF087F5B);

  final List<Map<String, dynamic>> tips = const [
    {
      'title': 'Soil Health',
      'description':
          'Use soil testing to understand nutrient requirements.',
      'icon': Icons.grass,
    },
    {
      'title': 'Water Management',
      'description':
          'Manage irrigation according to crop and soil needs.',
      'icon': Icons.water_drop_outlined,
    },
    {
      'title': 'Pest Monitoring',
      'description':
          'Monitor crops regularly for pests and disease symptoms.',
      'icon': Icons.pest_control_outlined,
    },
    {
      'title': 'Nutrient Management',
      'description':
          'Apply fertilizers according to crop recommendations and soil tests.',
      'icon': Icons.eco_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F4),
      appBar: AppBar(
        title: const Text('Crop Care Tips'),
        backgroundColor: Colors.white,
        foregroundColor: green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF174D2A), Color(0xFF40A66A)],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.agriculture,
                  color: Colors.white,
                  size: 45,
                ),
                SizedBox(height: 12),
                Text(
                  'Healthy Crops, Better Harvest',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Explore useful crop care practices.',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),

          const Text(
            'Crop Care Guide',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          ...tips.map((tip) {
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.all(14),
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFE2F2E5),
                  child: Icon(
                    tip['icon'] as IconData,
                    color: green,
                  ),
                ),
                title: Text(
                  tip['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(tip['description'] as String),
                ),
              ),
            );
          }),

          const SizedBox(height: 10),
          const Text(
            'For crop-specific treatment, consult a qualified '
            'agricultural expert or your local agricultural department.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
