import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speedtrack/core/theme/app_typography.dart';
import 'package:speedtrack/viewmodels/tracking_viewmodel.dart';
import 'package:speedtrack/viewmodels/history_viewmodel.dart';
import 'dart:math';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '/dashboard';

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryViewModel>(
      builder: (context, historyVm, child) {
        final workouts = historyVm.workouts;
        final now = DateTime.now();

        // Calculate daily stats
        double dailyDistance = 0;
        double dailyCalories = 0;
        for (final w in workouts) {
          if (w.startTime.year == now.year &&
              w.startTime.month == now.month &&
              w.startTime.day == now.day) {
            dailyDistance += w.distance;
            dailyCalories += w.calories;
          }
        }

        final double dailyGoal = 5.0; // 5km goal
        final double goalProgress = (dailyDistance / dailyGoal).clamp(0.0, 1.0);
        final double remaining = max(0, dailyGoal - dailyDistance);

        // Calculate 5-day history for the bar chart
        final List<double> last5DaysDistances = List.filled(5, 0.0);
        for (int i = 0; i < 5; i++) {
          final targetDate = now.subtract(Duration(days: 4 - i));
          for (final w in workouts) {
            if (w.startTime.year == targetDate.year &&
                w.startTime.month == targetDate.month &&
                w.startTime.day == targetDate.day) {
              last5DaysDistances[i] += w.distance;
            }
          }
        }
        final double maxDistance = last5DaysDistances.isEmpty ? 0 : last5DaysDistances.reduce(max);
        final double barChartMax = maxDistance > 0 ? maxDistance : 1.0;

        // Calculate Streak
        int streak = 0;
        DateTime checkDate = now;
        while (true) {
          bool found = false;
          for (final w in workouts) {
            if (w.startTime.year == checkDate.year &&
                w.startTime.month == checkDate.month &&
                w.startTime.day == checkDate.day) {
              found = true;
              break;
            }
          }
          if (found) {
            streak++;
            checkDate = checkDate.subtract(const Duration(days: 1));
          } else {
            // If today doesn't have a workout yet, we should check if yesterday had one to not lose the streak
            if (streak == 0 &&
                checkDate.year == now.year &&
                checkDate.month == now.month &&
                checkDate.day == now.day) {
              checkDate = checkDate.subtract(const Duration(days: 1));
            } else {
              break;
            }
          }
        }

        return Scaffold(
          backgroundColor: const Color(0xFF111315),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isLandscape = constraints.maxWidth > constraints.maxHeight;

                final dailyCard = _buildDailyCard(dailyDistance, dailyCalories, remaining, goalProgress);
                final weeklyCard = _buildWeeklyCard(last5DaysDistances, barChartMax);
                final streakCard = _buildStreakCard(streak);

                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 48.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      if (isLandscape)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildHeaderTitle()),
                            _buildLiveTrackingToggle(),
                          ],
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: _buildHeaderTitle()),
                                _buildLiveTrackingToggle(),
                              ],
                            ),
                          ],
                        ),

                      SizedBox(height: 48.h),

                      // Cards Section
                      if (isLandscape)
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(flex: 2, child: dailyCard),
                              SizedBox(width: 24.w),
                              Expanded(flex: 1, child: weeklyCard),
                              SizedBox(width: 24.w),
                              Expanded(flex: 1, child: streakCard),
                            ],
                          ),
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            dailyCard,
                            SizedBox(height: 24.h),
                            Row(
                              children: [
                                Expanded(child: weeklyCard),
                                SizedBox(width: 16.w),
                                Expanded(child: streakCard),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<TrackingViewModel>().startWorkout();
            },
            backgroundColor: const Color(0xFFFF5A36),
            child: Icon(
              Icons.play_arrow_rounded,
              size: 32.spMin,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'READY\nTO\nRUN,\nALEX?',
          style: AppTypography.heading1.copyWith(
            fontSize: 64.spMin,
            height: 1.1,
            color: const Color(0xFFFF5A36),
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'Condition:\nOptimal •\nHigh\nVisibility',
          style: AppTypography.bodyMedium.copyWith(
            color: Colors.grey,
            height: 1.5,
            fontSize: 14.spMin,
          ),
        ),
      ],
    );
  }

  Widget _buildLiveTrackingToggle() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C1E),
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'LIVE\nTRACKING',
            style: AppTypography.label.copyWith(
              color: Colors.grey,
              fontSize: 10.spMin,
            ),
          ),
          SizedBox(width: 12.w),
          Switch(
            value: true,
            onChanged: (v) {},
            activeThumbColor: const Color(0xFFFF5A36),
            activeTrackColor: const Color(
              0xFFFF5A36,
            ).withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyCard(double dailyDistance, double dailyCalories, double remaining, double goalProgress) {
    return Container(
      padding: EdgeInsets.all(24.spMin),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C1E),
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DAILY\nPERFORMANCE',
                  style: AppTypography.heading3.copyWith(
                    color: const Color(0xFFFF5A36),
                    letterSpacing: 2,
                    fontSize: 12.spMin,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Goal\nProgress',
                  style: AppTypography.heading3.copyWith(
                    color: Colors.white,
                    fontSize: 16.spMin,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  remaining > 0
                      ? "You're\nonly\n${remaining.toStringAsFixed(1)}km\naway\nfrom\nhitting\nyour\ndaily\nendurance\nmilestone."
                      : "Incredible!\nYou've\nsmashed\nyour\ndaily\nendurance\nmilestone.",
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.grey,
                    height: 1.6,
                    fontSize: 12.spMin,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Distance',
                          style: AppTypography.label.copyWith(
                            color: Colors.grey,
                            fontSize: 10.spMin,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: dailyDistance.toStringAsFixed(1),
                            style: AppTypography.heading2.copyWith(
                              color: const Color(0xFFFF5A36),
                              fontSize: 24.spMin,
                            ),
                            children: [
                              TextSpan(
                                text: ' KM',
                                style: AppTypography.label.copyWith(
                                  color: const Color(0xFFFF5A36),
                                  fontSize: 12.spMin,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 32.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Calories',
                          style: AppTypography.label.copyWith(
                            color: Colors.grey,
                            fontSize: 10.spMin,
                          ),
                        ),
                        Text(
                          dailyCalories.toStringAsFixed(0),
                          style: AppTypography.heading2.copyWith(
                            color: const Color(0xFF00E5FF),
                            fontSize: 24.spMin,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Circular Progress Arc
          SizedBox(
            width: 120.spMin,
            child: CustomPaint(
              painter: DashboardArcPainter(
                progress: goalProgress,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyCard(List<double> last5DaysDistances, double barChartMax) {
    return Container(
      padding: EdgeInsets.all(24.spMin),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C1E),
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'WEEKLY\nDISTANCE',
            style: AppTypography.heading3.copyWith(
              color: Colors.white,
              letterSpacing: 2,
              fontSize: 12.spMin,
            ),
          ),
          SizedBox(height: 24.h),
          // Real Bar Chart
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              final isToday = index == 4;
              final val = last5DaysDistances[index];
              final heightPct = val / barChartMax;
              final barHeight = (heightPct * 120.h).clamp(4.0, 120.0.h);
              return _buildBar(
                barHeight,
                isToday ? const Color(0xFFFF5A36) : Colors.grey.withValues(alpha: 0.3),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakCard(int streak) {
    return Container(
      padding: EdgeInsets.all(24.spMin),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C1E),
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.local_fire_department_rounded,
            color: const Color(0xFFFF5A36),
            size: 36.spMin,
          ),
          SizedBox(height: 12.h),
          Text(
            'CURRENT\nSTREAK',
            textAlign: TextAlign.center,
            style: AppTypography.label.copyWith(
              color: Colors.grey,
              letterSpacing: 1.5,
              fontSize: 10.spMin,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '$streak',
            style: AppTypography.heading1.copyWith(
              fontSize: 48.spMin,
              height: 1,
            ),
          ),
          Text(
            'DAYS',
            style: AppTypography.heading3.copyWith(
              color: Colors.white,
              letterSpacing: 2,
              fontSize: 12.spMin,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            streak > 0
                ? 'Keep it\nup! Every\nday\ncounts.'
                : 'Start a\nnew streak\ntoday!',
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium.copyWith(
              color: Colors.grey,
              height: 1.2,
              fontSize: 10.spMin,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(double height, Color color) {
    return Container(
      width: 24.w,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}

class DashboardArcPainter extends CustomPainter {
  final double progress;
  DashboardArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final trackPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = const Color(0xFFFF5A36)
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 4);

    const startAngle = pi / 2;
    const sweepAngle = pi;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      trackPaint,
    );

    if (progress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle * progress,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant DashboardArcPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
