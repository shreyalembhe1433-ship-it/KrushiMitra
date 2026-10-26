import 'package:flutter/material.dart';

class Shopkeeperhome extends StatefulWidget {
  const new({super.key});

  @override
  State<Shopkeeperhome> createState() => _ShopkeeperhomeState();
}

class _ShopkeeperhomeState extends State<Shopkeeperhome> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("ShopkeeperHome"),
      ),
    );
  }
}