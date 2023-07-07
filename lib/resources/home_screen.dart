import 'package:flutter/material.dart';
import 'package:student_care_app/resources/styles_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(
      'مرحبا',
      style: StylesManager.medium18Black(),
    )));
  }
}
