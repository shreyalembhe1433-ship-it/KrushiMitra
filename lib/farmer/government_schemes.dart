import 'package:flutter/material.dart';
import 'package:krushimitra/farmer/FarmerHome.dart';

class GovernmentSchemesScreen extends StatefulWidget {
  const GovernmentSchemesScreen({super.key});

  @override
  State<GovernmentSchemesScreen> createState() =>
      _GovernmentSchemesScreenState();
}

class _GovernmentSchemesScreenState extends State<GovernmentSchemesScreen>
    with SingleTickerProviderStateMixin {
  static const green = Color(0xFF087F5B);

  late TabController _tabController;

  final activeSchemes = [
    {
      'name': 'PM-KISAN',
      'description': 'Financial support information for eligible farmers.',
      'icon': Icons.account_balance_wallet,
    },
    {
      'name': 'Soil Health Card',
      'description': 'Soil testing and soil health information.',
      'icon': Icons.grass,
    },
    {
      'name': 'Kisan Credit Card',
      'description': 'Credit facility information for eligible farmers.',
      'icon': Icons.credit_card,
    },
    {
      'name': 'Fertilizer Subsidy',
      'description': 'Information about fertilizer subsidy programmes.',
      'icon': Icons.agriculture,
    },
  ];

  final previousSchemes = [
    {
      'name': 'Previous Scheme Updates',
      'description': 'Review past announcements and deadlines.',
      'icon': Icons.history,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F4),
      appBar: AppBar(
        title: const Text('Government Schemes'),
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
        bottom: TabBar(
          controller: _tabController,
          labelColor: green,
          indicatorColor: green,
          tabs: const [
            Tab(text: 'Active Schemes'),
            Tab(text: 'Previous Schemes'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_schemeList(activeSchemes), _schemeList(previousSchemes)],
      ),
    );
  }

  Widget _schemeList(List<Map<String, dynamic>> schemes) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: schemes.length,
      itemBuilder: (context, index) {
        final scheme = schemes[index];

        return Card(
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 14),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 65,
                  height: 75,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2F2E5),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    scheme['icon'] as IconData,
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
                        scheme['name'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        scheme['description'] as String,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(scheme['name'] as String),
                              content: const Text(
                                'Check the official government portal '
                                'for current eligibility, application '
                                'dates and scheme details.',
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('View Details'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
