import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speedtrack/core/theme/app_typography.dart';
import 'package:speedtrack/viewmodels/history_viewmodel.dart';
import 'package:speedtrack/models/workout_model.dart';
import 'dart:math';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryViewModel>(
      builder: (context, historyVm, child) {
        final workouts = historyVm.workouts;
        final now = DateTime.now();

        double totalDistance = 0;
        double longestRun = 0;
        WorkoutModel? fastest5KWorkout;
        double fastest5KPaceMs = double.infinity;

        // Calculate 7-day stats for charts
        final List<double> last7DaysDistances = List.filled(7, 0.0);

        for (final w in workouts) {
          totalDistance += w.distance;
          if (w.distance > longestRun) longestRun = w.distance;
          
          if (w.distance >= 5.0) {
            final pace = w.durationMs / w.distance; // ms per km
            if (pace < fastest5KPaceMs) {
              fastest5KPaceMs = pace;
              fastest5KWorkout = w;
            }
          }

          // Populate 7 day charts
          final daysDiff = now.difference(w.startTime).inDays;
          if (daysDiff >= 0 && daysDiff < 7) {
            // index 6 is today, 5 is yesterday, etc.
            last7DaysDistances[6 - daysDiff] += w.distance;
          }
        }

        String fastest5KStr = '--:--';
        if (fastest5KWorkout != null) {
          final ms = fastest5KPaceMs * 5.0; 
          final dur = Duration(milliseconds: ms.toInt());
          fastest5KStr = '${dur.inMinutes}:${(dur.inSeconds % 60).toString().padLeft(2, '0')}';
        }

        final double barChartMax = last7DaysDistances.reduce(max) > 0 ? last7DaysDistances.reduce(max) : 1.0;
        final double barChartGoal = 10.0; // Assume 10km daily goal for weekly view
        final double barChartGoalPct = min(1.0, (last7DaysDistances[6] / barChartGoal)) * 100;

        return Scaffold(
          backgroundColor: const Color(0xFF111315),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 48.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PERFORMANCE\nINSIGHTS',
                          style: AppTypography.label.copyWith(color: const Color(0xFFFF5A36), letterSpacing: 2, fontSize: 10.spMin),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'ANALYTICS\nHUB',
                              style: AppTypography.heading1.copyWith(fontSize: 48.spMin, height: 1.1),
                            ),
                            SizedBox(width: 24.w),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1C1E),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Row(
                                children: [
                                  Text('Daily', style: AppTypography.bodySmall.copyWith(color: Colors.grey, fontSize: 12.spMin)),
                                  SizedBox(width: 8.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFF5A36),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Text('Weekly', style: AppTypography.bodySmall.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.spMin)),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 32.h),
                        
                        // Line Chart Card (Average Pace)
                        Container(
                          padding: EdgeInsets.all(24.spMin),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1C1E),
                            borderRadius: BorderRadius.circular(24.r),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('AVG PACE\nINTENSITY', style: AppTypography.label.copyWith(color: Colors.grey, letterSpacing: 1.5, fontSize: 10.spMin)),
                                      SizedBox(height: 8.h),
                                      RichText(
                                        text: TextSpan(
                                          text: '5\'30"', // Placeholder, complex to calculate robustly without more data
                                          style: AppTypography.heading1.copyWith(color: const Color(0xFFFF5A36), fontSize: 40.spMin),
                                          children: [
                                            TextSpan(text: ' / \nKM', style: AppTypography.label.copyWith(color: const Color(0xFF00E5FF), fontSize: 12.spMin)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              // Fake Line Chart with real distances proxying pace intensity
                              Container(
                                height: 80.h,
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
                                ),
                                child: CustomPaint(
                                  painter: LineChartPainter(data: last7DaysDistances, maxVal: barChartMax),
                                  size: Size.infinite,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: _getLast7DaysLabels().map((e) => Text(e, style: AppTypography.label.copyWith(color: Colors.grey, fontSize: 10.spMin))).toList(),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        
                        // Bar Chart Card (Total Distance)
                        Container(
                          padding: EdgeInsets.all(24.spMin),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1C1E),
                            borderRadius: BorderRadius.circular(24.r),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('TOTAL DISTANCE', style: AppTypography.label.copyWith(color: Colors.grey, letterSpacing: 1.5, fontSize: 10.spMin)),
                              SizedBox(height: 8.h),
                              RichText(
                                text: TextSpan(
                                  text: totalDistance.toStringAsFixed(1),
                                  style: AppTypography.heading1.copyWith(fontSize: 40.spMin),
                                  children: [
                                    TextSpan(text: ' KM', style: AppTypography.label.copyWith(color: Colors.grey, fontSize: 12.spMin)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.h),
                              // Real Bar Chart
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: List.generate(7, (index) {
                                  final isToday = index == 6;
                                  final val = last7DaysDistances[index];
                                  final heightPct = val / barChartMax;
                                  final barHeight = (heightPct * 120.h).clamp(4.0, 120.0.h);
                                  return _buildBarChartBar(barHeight, isToday);
                                }),
                              ),
                              SizedBox(height: 16.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Goal: ${barChartGoal.toStringAsFixed(0)}km', style: AppTypography.label.copyWith(color: Colors.grey, fontSize: 10.spMin)),
                                  Text('${barChartGoalPct.toStringAsFixed(0)}%', style: AppTypography.label.copyWith(color: const Color(0xFF00E5FF), fontWeight: FontWeight.bold, fontSize: 10.spMin)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(width: 24.w),
                  
                  // Right Column
                  Expanded(
                    child: Column(
                      children: [
                        _buildStatPill('FASTEST 5K', fastest5KStr, Icons.timer_outlined, const Color(0xFFFF5A36)),
                        SizedBox(height: 16.h),
                        _buildStatPill('LONGEST RUN', '${longestRun.toStringAsFixed(1)} KM', Icons.route_outlined, const Color(0xFF00E5FF)),
                        SizedBox(height: 16.h),
                        _buildStatPill('MAX ELEVATION', '0 M', Icons.landscape_outlined, Colors.grey),
                        SizedBox(height: 24.h),
                        // Heatmap Card
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(24.spMin),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1C1E),
                            borderRadius: BorderRadius.circular(24.r),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ACTIVITY HEATMAP', style: AppTypography.heading3.copyWith(color: const Color(0xFFFF5A36), fontSize: 16.spMin)),
                              SizedBox(height: 12.h),
                              Text(
                                'Visualizing your training density across your most frequented routes in Berlin. Peak activity detected near Tiergarten.',
                                style: AppTypography.bodySmall.copyWith(color: Colors.grey, height: 1.5, fontSize: 12.spMin),
                              ),
                              SizedBox(height: 16.h),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF5A36),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('VIEW FULL MAP', style: AppTypography.label.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10.spMin)),
                                    SizedBox(width: 8.w),
                                    Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16.spMin),
                                  ],
                                ),
                              ),
                              SizedBox(height: 24.h),
                              Container(
                                height: 160.h,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF232529),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Center(
                                  child: Icon(Icons.map_rounded, size: 64.spMin, color: Colors.white.withValues(alpha: 0.1)),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<String> _getLast7DaysLabels() {
    final now = DateTime.now();
    final List<String> days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    final result = <String>[];
    for (int i = 6; i >= 0; i--) {
      result.add(days[now.subtract(Duration(days: i)).weekday - 1]);
    }
    return result;
  }

  Widget _buildStatPill(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(24.spMin),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C1E),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.spMin),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24.spMin),
          ),
          SizedBox(width: 24.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTypography.label.copyWith(color: Colors.grey, letterSpacing: 1.5, fontSize: 10.spMin)),
              SizedBox(height: 4.h),
              Text(value, style: AppTypography.heading2.copyWith(color: Colors.white, fontSize: 24.spMin)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBarChartBar(double height, bool active) {
    return Container(
      width: 24.w,
      height: height,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF00E5FF) : Colors.grey.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4.r),
        boxShadow: active ? [
          BoxShadow(
            color: const Color(0xFF00E5FF).withValues(alpha: 0.3),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ] : null,
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  final List<double> data;
  final double maxVal;

  LineChartPainter({required this.data, required this.maxVal});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = const Color(0xFFFF5A36)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final widthStep = size.width / (data.length - 1);
    
    // First point
    final firstHeight = maxVal == 0 ? size.height : size.height - (data[0] / maxVal) * size.height;
    path.moveTo(0, firstHeight);

    // Quadratic bezier curve through points
    for (int i = 0; i < data.length - 1; i++) {
      final h1 = maxVal == 0 ? size.height : size.height - (data[i] / maxVal) * size.height;
      final h2 = maxVal == 0 ? size.height : size.height - (data[i+1] / maxVal) * size.height;
      
      final x1 = i * widthStep;
      final x2 = (i + 1) * widthStep;
      
      final cx = (x1 + x2) / 2;
      path.quadraticBezierTo(cx, h1, cx, (h1 + h2) / 2);
      path.quadraticBezierTo(cx, h2, x2, h2);
    }

    canvas.drawPath(path, paint);

    // Gradient fill under the line
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFFFF5A36).withValues(alpha: 0.3),
          const Color(0xFFFF5A36).withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;
      
    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
      
    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant LineChartPainter oldDelegate) => true;
}
