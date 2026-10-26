import 'package:flutter/material.dart';
import 'package:krushimitra/farmer/FarmerHome.dart';

class FertilizerInformationScreen extends StatelessWidget {
  const FertilizerInformationScreen({super.key});

  static const green = Color(0xFF087F5B);

  static const fertilizers = [
    {
      'name': 'Urea',
      'description': 'Nitrogen fertilizer',
      'nutrient': '46% Nitrogen',
      'icon': Icons.grass,
    },
    {
      'name': 'DAP',
      'description': 'Nitrogen and phosphorus',
      'nutrient': '18-46-0',
      'icon': Icons.eco,
    },
    {
      'name': 'MOP',
      'description': 'Potassium fertilizer',
      'nutrient': '60% Potash (K₂O)',
      'icon': Icons.spa,
    },
    {
      'name': 'NPK 10:26:26',
      'description': 'Complex fertilizer',
      'nutrient': '10% N, 26% P₂O₅, 26% K₂O',
      'icon': Icons.agriculture,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F4),
      appBar: AppBar(
        title: const Text('Fertilizer Information'),
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
            'Explore Fertilizers 🌱',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Learn about commonly used fertilizers.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),

          ...fertilizers.map((fertilizer) {
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 14),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2F2E5),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        fertilizer['icon'] as IconData,
                        color: green,
                        size: 36,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fertilizer['name'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            fertilizer['description'] as String,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            fertilizer['nutrient'] as String,
                            style: const TextStyle(
                              color: green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(fertilizer['name'] as String),
                                  content: Text(
                                    'Nutrient information: '
                                    '${fertilizer['nutrient']}\n\n'
                                    'Follow the product label and '
                                    'soil-test recommendations.',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Close'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const Text('View Details'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          const Text(
            'Note: Check the product label and local agricultural '
            'recommendations before applying fertilizer.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
