import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speedtrack/viewmodels/history_viewmodel.dart';
import 'package:speedtrack/viewmodels/tracking_viewmodel.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '/dashboard';

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpeedTrack'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer2<HistoryViewModel, TrackingViewModel>(
        builder: (context, history, tracking, child) {
          final isTrackingActive = tracking.state != TrackingState.idle;

          return RefreshIndicator(
            onRefresh: () async => history.loadWorkouts(),
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                if (isTrackingActive) _buildActiveTrackingBanner(context),
                SizedBox(height: 16.h),
                _buildGoalCard(context, history),
                SizedBox(height: 24.h),
                _buildQuickStats(context, history),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildActiveTrackingBanner(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Workout in Progress',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'Tap to view details',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.8),
                    ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // The MainNavigationScreen handles tabs. We could trigger a tab switch here using a global key,
              // but for now, it's just a visual banner.
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: const Text('VIEW'),
          )
        ],
      ),
    );
  }

  Widget _buildGoalCard(BuildContext context, HistoryViewModel history) {
    double totalDistance = 0;
    for (var w in history.workouts) {
      totalDistance += w.distance; // in meters
    }
    final distanceKm = totalDistance / 1000;
    
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        children: [
          Text(
            'WEEKLY DISTANCE',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 16.h),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 150.w,
                height: 150.w,
                child: CircularProgressIndicator(
                  value: (distanceKm / 20.0).clamp(0.0, 1.0),
                  strokeWidth: 12.w,
                  backgroundColor: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Column(
                children: [
                  Text(
                    distanceKm.toStringAsFixed(1),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    '/ 20 km',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context, HistoryViewModel history) {
    return Row(
      children: [
        Expanded(
          child: _buildStatTile(context, 'WORKOUTS', history.workouts.length.toString()),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: _buildStatTile(context, 'CALORIES', '1,245'), // Mock for now
        ),
      ],
    );
  }

  Widget _buildStatTile(BuildContext context, String label, String value) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  letterSpacing: 1.2,
                ),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
