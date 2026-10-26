
import 'package:flutter/material.dart';
import 'package:krushimitra/farmer/ProfilePage.dart';
import 'package:krushimitra/farmer/ask_question.dart';
import 'package:krushimitra/farmer/expertAdvice.dart';
import 'package:krushimitra/farmer/farmer_dashboad.dart';
import 'package:krushimitra/farmer/fertilizer_info.dart';
import 'package:krushimitra/farmer/government_schemes.dart';

class Farmerhome extends StatefulWidget {
  const Farmerhome({super.key});

  @override
  State<Farmerhome> createState() => _FarmerhomeState();
}

class _FarmerhomeState extends State<Farmerhome> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    FarmerDashboard(),
    ExpertAdviceScreen(),
    AskQuestionScreen(),
    GovernmentSchemesScreen(),
    FertilizerInformationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 32),
            label: 'Ask',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_outlined),
            label: 'Schemes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grass),
            label: 'Fetilizer Information',
          ),
        ],
      ),
    );
  }
}
