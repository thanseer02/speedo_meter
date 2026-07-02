import 'package:flutter/material.dart';
import 'package:speedtrack/features/dashboard/view/dashboard_screen.dart';
import 'package:speedtrack/features/history/view/history_screen.dart';
import 'package:speedtrack/features/settings/view/settings_screen.dart';
import 'package:speedtrack/features/tracking/view/tracking_screen.dart';
import 'package:speedtrack/features/main_navigation/view/main_navigation_screen.dart';
import 'package:speedtrack/features/onboarding/view/splash_screen.dart';
import 'package:speedtrack/features/onboarding/view/onboarding_screen.dart';
import 'package:speedtrack/features/onboarding/view/sign_in_screen.dart';
import 'package:speedtrack/features/onboarding/view/permission_screen.dart';

Map<String, WidgetBuilder> appRoutes() {
  return {
    SplashScreen.routeName: (context) => const SplashScreen(),
    OnboardingScreen.routeName: (context) => const OnboardingScreen(),
    SignInScreen.routeName: (context) => const SignInScreen(),
    PermissionScreen.routeName: (context) => const PermissionScreen(),
    MainNavigationScreen.routeName: (context) => const MainNavigationScreen(),
    DashboardScreen.routeName: (context) => const DashboardScreen(),
    TrackingScreen.routeName: (context) => const TrackingScreen(),
    HistoryScreen.routeName: (context) => const HistoryScreen(),
    SettingsScreen.routeName: (context) => const SettingsScreen(),
  };
}

Widget? _getScreen(RouteSettings settings) {
  // Add dynamic parameterized routes here in the future.
  return null;
}

RouteFactory onAppGenerateRoute() => (settings) {
      Widget? screen = _getScreen(settings);
      if (screen != null) {
        return PageRouteBuilder<Object?>(
          settings: settings,
          pageBuilder: (_, __, ___) => screen,
          transitionsBuilder: (_, a, __, c) {
            return FadeTransition(opacity: a, child: c);
          },
        );
      }
      return null;
    };
