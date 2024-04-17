import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Admin Home',
      )),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.blueAccent.withOpacity(0.1),
          Colors.purpleAccent.withOpacity(0.5),
        ])),
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
