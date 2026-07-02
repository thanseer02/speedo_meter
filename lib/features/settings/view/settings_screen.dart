import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speedtrack/providers/theme_provider.dart';
import 'package:speedtrack/viewmodels/settings_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = '/settings';
  
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Consumer2<SettingsViewModel, ThemeProvider>(
        builder: (context, settings, themeProvider, child) {
          return ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              _buildSectionHeader('Appearance', context),
              SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: const Text('Toggle between light and dark theme'),
                value: themeProvider.isDarkMode,
                onChanged: (val) => themeProvider.toggleTheme(val),
              ),
              SizedBox(height: 24.h),
              
              _buildSectionHeader('Tracking', context),
              SwitchListTile(
                title: const Text('Background Tracking'),
                subtitle: const Text('Continue tracking when app is closed'),
                value: settings.isBackgroundTrackingEnabled,
                onChanged: (val) => settings.setBackgroundTracking(val),
              ),
              SwitchListTile(
                title: const Text('Auto-Pause'),
                subtitle: const Text('Automatically pause when you stop moving'),
                value: settings.isAutoPauseEnabled,
                onChanged: (val) => settings.setAutoPause(val),
              ),
              SizedBox(height: 24.h),
              
              _buildSectionHeader('Units', context),
              SwitchListTile(
                title: const Text('Metric Units'),
                subtitle: const Text('Use Kilometers instead of Miles'),
                value: settings.isMetricUnitsEnabled,
                onChanged: (val) => settings.setMetricUnits(val),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}
