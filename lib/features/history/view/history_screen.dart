import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speedtrack/core/theme/app_typography.dart';
import 'package:speedtrack/viewmodels/history_viewmodel.dart';
import 'package:speedtrack/models/workout_model.dart';

class HistoryScreen extends StatelessWidget {
  static const String routeName = '/history';

  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111315),
      body: SafeArea(
        child: Row(
          children: [
            // Left portion: Header and list
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 48.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'WORKOUT\nHISTORY',
                              style: AppTypography.heading1.copyWith(
                                fontSize: 56.spMin,
                                height: 1.1,
                                fontStyle: FontStyle.italic,
                                color: const Color(0xFFFF5A36),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              'Track your evolution\nover time',
                              style: AppTypography.heading3.copyWith(
                                color: Colors.grey[300],
                                fontWeight: FontWeight.normal,
                                height: 1.4,
                                fontSize: 16.spMin,
                              ),
                            ),
                          ],
                        ),
                        
                        // Filter Button
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E1E22),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.filter_list_rounded, color: const Color(0xFFFF5A36), size: 24.spMin),
                              SizedBox(width: 8.w),
                              Text(
                                'FILTER',
                                style: AppTypography.label.copyWith(color: Colors.white, letterSpacing: 2, fontSize: 10.spMin),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    
                    SizedBox(height: 48.h),
                    
                    // List of Workouts
                    Expanded(
                      child: Consumer<HistoryViewModel>(
                        builder: (context, viewModel, child) {
                          if (viewModel.isLoading) {
                            return Center(child: CircularProgressIndicator(color: const Color(0xFFFF5A36)));
                          }
                          
                          final workouts = viewModel.workouts;
                          if (workouts.isEmpty) {
                            return Center(
                              child: Text(
                                'No workouts logged yet.\nTime to hit the road!',
                                textAlign: TextAlign.center,
                                style: AppTypography.bodyMedium.copyWith(color: Colors.grey, height: 1.5, fontSize: 14.spMin),
                              ),
                            );
                          }

                          return ListView.separated(
                            itemCount: workouts.length,
                            separatorBuilder: (_, __) => SizedBox(height: 24.h),
                            itemBuilder: (context, index) {
                              final workout = workouts[index];
                              return _buildHistoryCard(workout);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Right portion: Spacer / details preview
            Expanded(
              flex: 3,
              child: Container(
                color: const Color(0xFF111315),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF1E1E22),
        child: Icon(Icons.visibility_rounded, color: Colors.grey, size: 24.spMin),
      ),
    );
  }

  Widget _buildHistoryCard(WorkoutModel workout) {
    // Generate dynamic title based on time of day
    final hour = workout.startTime.hour;
    String timeOfDay = 'MORNING';
    if (hour >= 12 && hour < 17) timeOfDay = 'AFTERNOON';
    if (hour >= 17 && hour < 21) timeOfDay = 'EVENING';
    if (hour >= 21 || hour < 4) timeOfDay = 'NIGHT';
    
    // Icon and Color based on speed heuristic (e.g. speed > 8km/h is running)
    final double avgSpeedKmh = workout.distance > 0 && workout.durationMs > 0 
        ? (workout.distance / (workout.durationMs / 3600000.0)) 
        : 0.0;
        
    final bool isRunning = avgSpeedKmh > 7.0;
    final IconData icon = isRunning ? Icons.directions_run_rounded : Icons.directions_walk_rounded;
    final Color iconColor = isRunning ? const Color(0xFFFF5A36) : const Color(0xFF00E5FF);
    final String activityName = isRunning ? 'RUN' : 'WALK';
    
    final title = '$timeOfDay\nPERFORMANCE\n$activityName';
    
    // Format date "Oct 24, 2023"
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final dateStr = '${months[workout.startTime.month - 1]} ${workout.startTime.day}, ${workout.startTime.year}';

    return Container(
      padding: EdgeInsets.all(24.spMin),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C1E),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Map Placeholder Image
          Container(
            width: 200.w,
            height: 140.h,
            decoration: BoxDecoration(
              color: const Color(0xFF232529),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(Icons.map_outlined, size: 64.spMin, color: Colors.white.withValues(alpha: 0.1)),
                ),
                Positioned(
                  bottom: 12.h,
                  right: 12.w,
                  child: Text(
                    '${workout.distance.toStringAsFixed(2)} KM',
                    style: AppTypography.label.copyWith(color: iconColor, fontWeight: FontWeight.bold, fontSize: 10.spMin),
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 32.w),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(icon, color: iconColor, size: 28.spMin),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Text(
                        title,
                        style: AppTypography.heading2.copyWith(color: Colors.white, height: 1.2, fontSize: 24.spMin),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, color: Colors.grey, size: 16.spMin),
                        SizedBox(width: 8.w),
                        Text(
                          dateStr,
                          style: AppTypography.bodyMedium.copyWith(color: Colors.grey, fontSize: 14.spMin),
                        ),
                      ],
                    ),
                    Text(
                      '${workout.calories} KCAL',
                      style: AppTypography.label.copyWith(color: Colors.grey, fontSize: 10.spMin),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
