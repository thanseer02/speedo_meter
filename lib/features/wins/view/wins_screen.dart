import 'package:flutter/material.dart';
import 'package:speedtrack/core/theme/app_typography.dart';

class WinsScreen extends StatelessWidget {
  const WinsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111315),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.emoji_events_rounded, color: Color(0xFFFF5A36), size: 120),
            const SizedBox(height: 32),
            Text('WINS & ACHIEVEMENTS', style: AppTypography.heading2.copyWith(color: Colors.white, letterSpacing: 2)),
            const SizedBox(height: 16),
            Text('Coming Soon', style: AppTypography.bodyMedium.copyWith(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
