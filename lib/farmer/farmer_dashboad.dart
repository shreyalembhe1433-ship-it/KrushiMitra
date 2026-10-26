import 'package:flutter/material.dart';
import 'package:krushimitra/farmer/ask_question.dart';
import 'package:krushimitra/farmer/cropCare.dart';
import 'package:krushimitra/farmer/expertAdvice.dart';
import 'package:krushimitra/farmer/fertilizer_info.dart';
import 'package:krushimitra/farmer/government_schemes.dart';


class FarmerDashboard extends StatefulWidget {
  const FarmerDashboard({super.key});

  @override
  State<FarmerDashboard> createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
  static const Color green = Color(0xFF087F5B);
  static const Color darkGreen = Color(0xFF174D2A);

  int _selectedIndex = 0;

  void _openScreen(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F2),

      // APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            Icon(Icons.eco, color: green, size: 32),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'KrushiMitra',
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Together We Grow',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: darkGreen,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.account_circle_outlined,
              color: darkGreen,
            ),
          ),
        ],
      ),

      // HOME CONTENT
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hello, Farmer! 👋',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF203326),
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Welcome to your farming community.',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 20),

              // GREEN BANNER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [darkGreen, Color(0xFF40A66A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Healthy Crops\nHappy Farmers',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Learn, connect and grow together!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.agriculture,
                      color: Colors.white,
                      size: 65,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // QUICK ACTIONS TITLE
              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),

              // QUICK ACTIONS GRID
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.35,
                children: [
                  _quickAction(
                    icon: Icons.help_outline,
                    title: 'Ask a Question',
                    subtitle: 'Get expert advice',
                    onTap: () => _openScreen(
                      const AskQuestionScreen(),
                    ),
                  ),

                  _quickAction(
                    icon: Icons.grass,
                    title: 'Fertilizer Info',
                    subtitle: 'Explore fertilizers',
                    onTap: () => _openScreen(
                      const FertilizerInformationScreen(),
                    ),
                  ),

                  _quickAction(
                    icon: Icons.account_balance_outlined,
                    title: 'Government Schemes',
                    subtitle: 'Explore schemes',
                    onTap: () => _openScreen(
                      const GovernmentSchemesScreen(),
                    ),
                  ),

                  _quickAction(
                    icon: Icons.support_agent,
                    title: 'Expert Advice',
                    subtitle: 'Connect with experts',
                    onTap: () => _openScreen(
                      const ExpertAdviceScreen(),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // CROP CARE
              InkWell(
                onTap: () => _openScreen(
                  const CropCareScreen(),
                ),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE1EAE0),
                    ),
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFFE2F2E5),
                        child: Icon(
                          Icons.agriculture,
                          color: green,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Crop Care Tips',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Learn how to care for your crops.',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: green,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // RECENT UPDATES
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Updates',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View All',
                      style: TextStyle(color: green),
                    ),
                  ),
                ],
              ),

              _updateCard(
                icon: Icons.eco,
                title: 'Fertilizer Information',
                subtitle: 'Explore fertilizer types and their uses.',
              ),

              _updateCard(
                icon: Icons.account_balance,
                title: 'Government Schemes',
                subtitle: 'Check available farmer schemes.',
              ),

              _updateCard(
                icon: Icons.support_agent,
                title: 'Expert Advice',
                subtitle: 'Find guidance for your farming questions.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // QUICK ACTION CARD
  Widget _quickAction({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE1EAE0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: green, size: 30),
            const SizedBox(height: 9),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // RECENT UPDATE CARD
  Widget _updateCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(
          color: Color(0xFFE1EAE0),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE2F2E5),
          child: Icon(icon, color: green),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
        ),
      ),
    );
  }
}