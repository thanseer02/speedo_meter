import 'package:flutter/material.dart';
import 'package:speedtrack/core/theme/app_colors.dart';
import 'package:speedtrack/core/theme/app_typography.dart';
import 'package:speedtrack/core/widgets/pill_button.dart';
import 'package:speedtrack/features/onboarding/view/permission_screen.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = '/signin';

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),
              Center(
                child: Icon(
                  Icons.speed_rounded,
                  size: 80,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'SpeedTrack',
                style: AppTypography.heading1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to sync your workouts across all your devices.',
                style: AppTypography.body1.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 3),
              PillButton(
                label: 'Continue with Google',
                icon: Icons.g_mobiledata_rounded,
                isPrimary: false,
                onPressed: () {
                  // Navigate to permission flow
                  Navigator.of(context).pushReplacementNamed(PermissionScreen.routeName);
                },
              ),
              const SizedBox(height: 16),
              PillButton(
                label: 'Continue with Apple',
                icon: Icons.apple_rounded,
                isPrimary: false,
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(PermissionScreen.routeName);
                },
              ),
              const SizedBox(height: 32),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(PermissionScreen.routeName);
                  },
                  child: Text(
                    'Continue as Guest',
                    style: AppTypography.body2.copyWith(
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
