import 'package:flutter/material.dart';

class TrackingScreen extends StatelessWidget {
  static const String routeName = '/tracking';
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Speedometer')),
      body: const Center(child: Text('Tracking Screen')),
    );
  }
}
