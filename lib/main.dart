import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:speedtrack/utils/themes.dart';
import 'package:speedtrack/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SpeedTrackApp());
}

/// The root widget of the SpeedTrack application.
class SpeedTrackApp extends StatelessWidget {
  const SpeedTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
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
                home: Scaffold(
                  appBar: AppBar(title: const Text('SpeedTrack')),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('SpeedTrack Restructured Successfully'),
                        const SizedBox(height: 20),
                        SwitchListTile(
                          title: const Text('Dark Mode'),
                          value: themeProvider.themeMode == ThemeMode.dark,
                          onChanged: (isDark) {
                            themeProvider.toggleTheme(isDark);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
