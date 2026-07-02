import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:speedtrack/configs/routes.dart';
import 'package:speedtrack/core/theme/app_theme.dart';
import 'package:speedtrack/features/onboarding/view/splash_screen.dart';
import 'package:speedtrack/providers/theme_provider.dart';
import 'package:speedtrack/core/dependency_injection.dart';
import 'package:speedtrack/viewmodels/tracking_viewmodel.dart';
import 'package:speedtrack/viewmodels/history_viewmodel.dart';
import 'package:speedtrack/viewmodels/settings_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencyInjection();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) => TrackingViewModel(
            repository: getIt(),
            permissionService: getIt(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => HistoryViewModel(
            repository: getIt(),
          )..loadWorkouts(),
        ),
        ChangeNotifierProvider(
          create: (_) => SettingsViewModel(
            repository: getIt(),
          ),
        ),
      ],
      child: const SpeedTrackApp(),
    ),
  );
}

/// The root widget of the SpeedTrack application.
class SpeedTrackApp extends StatelessWidget {
  const SpeedTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ScreenUtilInit(
          designSize: const Size(390, 844), // Standard iPhone dimension
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              title: 'SpeedTrack',
              theme: AppTheme.darkTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.dark, // Force dark mode as per design
              debugShowCheckedModeBanner: false,
              initialRoute: SplashScreen.routeName,
              routes: appRoutes(),
              onGenerateRoute: onAppGenerateRoute(),
            );
          },
        );
      },
    );
  }
}
