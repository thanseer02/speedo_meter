import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  static const String routeName = '/history';
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout History')),
      body: const Center(child: Text('History Screen')),
    );
  }
}
