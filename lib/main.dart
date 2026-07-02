import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/di/locator.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependency injection
  await setupLocator();
  
  runApp(const SpeedTrackApp());
}

/// The root widget of the SpeedTrack application.
class SpeedTrackApp extends StatelessWidget {
  const SpeedTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    // We will inject Providers here in the future.
    return MultiProvider(
      providers: [
        // Placeholder for global providers.
        Provider.value(value: null),
      ],
      child: MaterialApp.router(
        title: 'SpeedTrack',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
