import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:speedtrack/configs/routes.dart';
import 'package:speedtrack/utils/themes.dart';
import 'package:speedtrack/features/main_navigation/view/main_navigation_screen.dart';
import 'package:speedtrack/providers/theme_provider.dart';
import 'package:speedtrack/core/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencyInjection();
  
  runApp(const SpeedTrackApp());
}

/// The root widget of the SpeedTrack application.
class SpeedTrackApp extends StatelessWidget {
  const SpeedTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return ScreenUtilInit(
            designSize: const Size(390, 844), // Standard iPhone dimension
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                title: 'SpeedTrack',
                theme: appLightTheme,
                darkTheme: appDarkTheme,
                themeMode: themeProvider.themeMode,
                debugShowCheckedModeBanner: false,
                initialRoute: MainNavigationScreen.routeName,
                routes: appRoutes(),
                onGenerateRoute: onAppGenerateRoute(),
              );
            },
          );
        },
      ),
    );
  }
}
