import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:krushimitra/Auth/LoginPage.dart';
import 'package:krushimitra/Expert/ExpertHome.dart';
import 'package:krushimitra/Admin/AdminHome.dart';
import 'package:krushimitra/farmer/FarmerHome.dart';
import 'package:krushimitra/shopekeeper/ShopKeeperHome.dart';

class Authwrapper extends StatelessWidget {
  const Authwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),

      builder: (context, snapshot) {

        // 1. Check authentication status
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // 2. If user is not logged in
        if (!snapshot.hasData) {
          return Login();
        }

        // 3. Get logged-in user's UID
        final user = snapshot.data!;

        // 4. Fetch user role from Firestore
        return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('user')
              .doc(user.uid)
              .snapshots(),

          builder: (context, roleSnapshot) {

            // Show loading indicator
            if (roleSnapshot.connectionState ==
                ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            // Handle Firestore errors
            if (roleSnapshot.hasError) {
              return const Scaffold(
                body: Center(
                  child: Text('Error loading user profile'),
                ),
              );
            }

            // Check whether user document exists
            if (!roleSnapshot.hasData ||
                !roleSnapshot.data!.exists) {
              return const Scaffold(
                body: Center(
                  child: Text('User profile not found'),
                ),
              );
            }

            // Get role
            final userData = roleSnapshot.data!.data();
            final String? role = userData?['role'] as String?;

            // 5. Navigate according to role
            switch (role) {

              case 'Farmer':
                return Farmerhome();

              case 'Shopkeeper':
                return Shopkeeperhome();

              case 'Expert':
                return Experthome();

              case 'Admin':
                return AdminHome();

              default:
                return const Scaffold(
                  body: Center(
                    child: Text(
                      'Invalid role. Please contact administrator.',
                    ),
                  ),
                );
            }
          },
        );
      },
    );
  }
}