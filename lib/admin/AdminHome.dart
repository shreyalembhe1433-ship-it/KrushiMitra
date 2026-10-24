import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const new({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("AdminHome"),
      ),
    );
  }
}