import 'package:flutter/material.dart';

class Farmerhome extends StatefulWidget {
  const new({super.key});

  @override
  State<Farmerhome> createState() => _FarmerhomeState();
}

class _FarmerhomeState extends State<Farmerhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("FarmerHome"),
      ),
    );
  }
}