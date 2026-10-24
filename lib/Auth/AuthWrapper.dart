import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:krushimitra/Auth/LoginPage.dart';

// Import your role-based home pages
import 'package:krushimitra/admin/AdminHome.dart';
import 'package:krushimitra/expert/ExpertHome.dart';
import 'package:krushimitra/farmer/FarmerHome.dart';
import 'package:krushimitra/shopekeeper/ShopKeerper.dart';

class Authwrapper extends StatelessWidget {
  const Authwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // User is not logged in
        if (!snapshot.hasData) {
          return Login();
        }

        // User is logged in
        final user = snapshot.data!;

        return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get(),

          builder: (context, roleSnapshot) {

            if (roleSnapshot.connectionState ==
                ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (roleSnapshot.hasError) {
              return const Scaffold(
                body: Center(
                  child: Text('Something went wrong. Please try again.'),
                ),
              );
            }

            if (!roleSnapshot.hasData ||
                !roleSnapshot.data!.exists) {
              return const Scaffold(
                body: Center(
                  child: Text(
                    'User profile not found. Please contact support.',
                  ),
                ),
              );
            }

            final userData = roleSnapshot.data!.data();
            final role = userData?['role'];

            // Navigate according to role
            switch (role) {

              case 'farmer':
                return Farmerhome();

              case 'shopkeeper':
                return Shopkeerper();

              case 'expert':
                return Experthome();

              case 'admin':
                return AdminHome();

              default:
                return const Scaffold(
                  body: Center(
                    child: Text('Invalid role. Please contact support.'),
                  ),
                );
            }
          },
        );
      },
    );
  }
}