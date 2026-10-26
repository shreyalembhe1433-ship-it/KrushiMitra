import 'package:flutter/material.dart';
import 'package:krushimitra/farmer/FarmerHome.dart';

class ExpertAdviceScreen extends StatelessWidget {
  const ExpertAdviceScreen({super.key});

  static const green = Color(0xFF087F5B);

  final List<Map<String, String>> experts = const [
    {
      'name': 'Agriculture Expert',
      'speciality': 'Crop diseases and crop protection',
      'status': 'Expert information',
    },
    {
      'name': 'Soil Specialist',
      'speciality': 'Soil health and fertilizers',
      'status': 'Expert information',
    },
    {
      'name': 'Crop Consultant',
      'speciality': 'Crop care and irrigation',
      'status': 'Expert information',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F4),
      appBar: AppBar(
        title: const Text('Expert Advice'),
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Get Expert Guidance 🌱',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Find guidance for your farming questions.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),

          ...experts.map((expert) {
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 14),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 28,
                          backgroundColor: Color(0xFFE2F2E5),
                          child: Icon(
                            Icons.support_agent,
                            color: green,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                expert['name']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                expert['speciality']!,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    Text(
                      expert['status']!,
                      style: const TextStyle(
                        color: green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Connect this screen to registered experts '
                                'in Firebase.',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.chat_outlined),
                        label: const Text('Request Advice'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
