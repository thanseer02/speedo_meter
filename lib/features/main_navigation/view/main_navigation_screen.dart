import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:speedtrack/features/dashboard/view/dashboard_screen.dart';
import 'package:speedtrack/features/analytics/view/analytics_screen.dart';
import 'package:speedtrack/features/tracking/view/tracking_screen.dart';
import 'package:speedtrack/viewmodels/tracking_viewmodel.dart';
import 'package:speedtrack/features/history/view/history_screen.dart';
import 'package:speedtrack/features/wins/view/wins_screen.dart';
import 'package:speedtrack/features/settings/view/settings_screen.dart';
import 'package:speedtrack/core/widgets/custom_navigation_rail.dart';
import 'package:speedtrack/core/widgets/custom_bottom_navigation_bar.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = '/main_navigation';
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  Widget _buildHomeTab(BuildContext context) {
    return Consumer<TrackingViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.state != TrackingState.idle) {
          return const TrackingScreen();
        }
        return const DashboardScreen();
      },
    );
  }

  List<Widget> _buildScreens(BuildContext context) {
    return [
      _buildHomeTab(context),
      const AnalyticsScreen(),
      const HistoryScreen(),
      const WinsScreen(),
      const SettingsScreen(),
    ];
  }

  @override
  void initState() {
    super.initState();
    // Force Landscape Mode for the Dashboard/Tracking Hub
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // Revert to portrait if navigating back (optional safeguard)
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111315),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isLandscape = constraints.maxWidth > constraints.maxHeight;

            if (isLandscape) {
              return Row(
                children: [
                  CustomNavigationRail(
                    selectedIndex: _currentIndex,
                    onDestinationSelected: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  Container(
                    width: 1,
                    color: Colors.white.withValues(alpha: 0.05),
                    margin: const EdgeInsets.symmetric(vertical: 24),
                  ),
                  Expanded(
                    child: IndexedStack(
                      index: _currentIndex,
                      children: _buildScreens(context),
                    ),
                  ),
                ],
              );
            } else {
              // Portrait
              return Column(
                children: [
                  Expanded(
                    child: IndexedStack(
                      index: _currentIndex,
                      children: _buildScreens(context),
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                  CustomBottomNavigationBar(
                    selectedIndex: _currentIndex,
                    onDestinationSelected: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
