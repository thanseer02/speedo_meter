import 'package:flutter/material.dart';
import 'package:speedtrack/core/theme/app_colors.dart';
import 'package:speedtrack/core/theme/app_typography.dart';
import 'package:speedtrack/core/widgets/pill_button.dart';
import 'package:speedtrack/features/main_navigation/view/main_navigation_screen.dart';

class PermissionScreen extends StatelessWidget {
  static const routeName = '/permissions';

  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surface,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.gps_fixed_rounded,
                  size: 80,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 48),
              Text(
                'Location Access',
                style: AppTypography.heading1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'SpeedTrack needs access to your location to track your speed, distance, and route accurately, even when the app is running in the background.',
                style: AppTypography.body1.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: PillButton(
                  label: 'Allow Access',
                  icon: Icons.check_circle_outline,
                  onPressed: () {
                    // In a real app, trigger permission service here.
                    Navigator.of(context).pushReplacementNamed(MainNavigationScreen.routeName);
                  },
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(MainNavigationScreen.routeName);
                },
                child: Text(
                  'Not Now',
                  style: AppTypography.body2.copyWith(color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
