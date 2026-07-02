import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Centralized router configuration for the application.
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const PlaceholderHomeScreen(),
      ),
    ],
  );
}

/// A placeholder screen until the actual HomeView is implemented.
class PlaceholderHomeScreen extends StatelessWidget {
  const PlaceholderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SpeedTrack')),
      body: const Center(
        child: Text('SpeedTrack Phase 1 Setup Complete'),
      ),
    );
  }
}
