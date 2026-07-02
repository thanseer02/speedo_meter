import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:speedtrack/viewmodels/tracking_viewmodel.dart';
import 'package:speedtrack/core/theme/app_typography.dart';
import 'dart:math';

class TrackingScreen extends StatelessWidget {
  static const String routeName = '/tracking';

  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackingViewModel>(
      builder: (context, viewModel, child) {
        final speed = viewModel.lastLocation?.speed ?? 0.0;
        final speedKmh = speed * 3.6;

        return Scaffold(
          backgroundColor: const Color(0xFF111315),
          body: LayoutBuilder(
            builder: (context, constraints) {
              final isLandscape = constraints.maxWidth > constraints.maxHeight;

              final gpsCard = _buildGpsCard();
              final batteryCard = const BatteryCard();
              final compassActivityCard = _buildCompassActivityCard();
              final speedometer = Center(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: _buildGlowingSpeedometer(speedKmh),
                ),
              );
              
              final distanceCard = _buildStatCard(
                'DISTANCE',
                (viewModel.currentWorkout?.distance ?? 0.0).toStringAsFixed(2),
                'KM',
              );
              final durationCard = _buildStatCard(
                'DURATION',
                _formatDuration(viewModel.currentWorkout?.durationMs ?? 0),
                '',
              );
              final caloriesCard = _buildStatCard(
                'CALORIES',
                (viewModel.currentWorkout?.calories ?? 0).toStringAsFixed(0),
                'KCAL',
              );

              if (isLandscape) {
                return Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          // LEFT PANEL
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 16.h,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  gpsCard,
                                  SizedBox(height: 12.h),
                                  batteryCard,
                                  SizedBox(height: 12.h),
                                  Expanded(child: compassActivityCard),
                                ],
                              ),
                            ),
                          ),

                          // CENTER PANEL
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 24.h),
                              child: speedometer,
                            ),
                          ),

                          // RIGHT PANEL
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 16.h,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  distanceCard,
                                  SizedBox(height: 12.h),
                                  durationCard,
                                  SizedBox(height: 12.h),
                                  caloriesCard,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildBottomToolbar(viewModel),
                  ],
                );
              } else {
                // Portrait Layout
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(child: gpsCard),
                                SizedBox(width: 12.w),
                                Expanded(child: batteryCard),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                Expanded(child: distanceCard),
                                SizedBox(width: 8.w),
                                Expanded(child: durationCard),
                                SizedBox(width: 8.w),
                                Expanded(child: caloriesCard),
                              ],
                            ),
                            SizedBox(height: 24.h),
                            SizedBox(
                              height: 350.h,
                              child: speedometer,
                            ),
                            SizedBox(height: 24.h),
                            compassActivityCard,
                          ],
                        ),
                      ),
                    ),
                    _buildBottomToolbar(viewModel),
                  ],
                );
              }
            },
          ),
        );
      },
    );
  }

  String _formatDuration(int ms) {
    final dur = Duration(milliseconds: ms);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final h = dur.inHours;
    final m = twoDigits(dur.inMinutes.remainder(60));
    final s = twoDigits(dur.inSeconds.remainder(60));
    return h > 0 ? '${twoDigits(h)}:$m:$s' : '$m:$s';
  }

  Widget _buildGpsCard() {
    return Container(
      padding: EdgeInsets.all(12.spMin),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E22),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'GPS SIGNAL',
                style: AppTypography.label.copyWith(
                  color: Colors.grey,
                  fontSize: 10.spMin,
                ),
              ),
              Icon(
                Icons.signal_cellular_alt_rounded,
                color: const Color(0xFF00E5FF),
                size: 16.spMin,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'STRONG',
            style: AppTypography.bodySmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.spMin,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompassActivityCard() {
    return Container(
      padding: EdgeInsets.all(16.spMin),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E22),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 120.spMin,
                  height: 120.spMin,
                  child: CustomPaint(painter: DashedCirclePainter()),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.navigation_rounded,
                      color: const Color(0xFF00E5FF),
                      size: 24.spMin,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'NE',
                      style: AppTypography.heading2.copyWith(
                        color: Colors.white,
                        fontSize: 20.spMin,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.spMin),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF5A36),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.directions_run_rounded,
                    color: Colors.white,
                    size: 20.spMin,
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ACTIVITY',
                      style: AppTypography.label.copyWith(
                        color: Colors.grey,
                        fontSize: 8.spMin,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Text(
                      'RUNNING',
                      style: AppTypography.bodyMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        fontSize: 12.spMin,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlowingSpeedometer(double speed) {
    return Container(
      width: 320.spMin,
      height: 320.spMin,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF5A36).withValues(alpha: 0.1),
            blurRadius: 100,
            spreadRadius: 20,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 300.spMin,
            height: 300.spMin,
            child: CustomPaint(painter: ArcSpeedometerPainter(speed: speed)),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                speed.toStringAsFixed(1),
                style: AppTypography.heading1.copyWith(
                  fontSize: 72.spMin,
                  height: 1,
                ),
              ),
              Text(
                'KM/H',
                style: AppTypography.heading3.copyWith(
                  color: const Color(0xFFFF5A36),
                  letterSpacing: 2,
                  fontSize: 16.spMin,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, String unit) {
    return Container(
      padding: EdgeInsets.all(16.spMin),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E22),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppTypography.label.copyWith(
              color: Colors.grey,
              letterSpacing: 1.5,
              fontSize: 10.spMin,
            ),
          ),
          SizedBox(height: 4.h),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: AppTypography.heading2.copyWith(
                    color: Colors.white,
                    fontSize: 24.spMin,
                  ),
                ),
                if (unit.isNotEmpty) ...[
                  SizedBox(width: 4.w),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Text(
                      unit,
                      style: AppTypography.label.copyWith(
                        color: Colors.grey,
                        fontSize: 10.spMin,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomToolbar(TrackingViewModel viewModel) {
    return Container(
      height: 72.h,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E22),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Text(
                'BACKGROUND',
                style: AppTypography.label.copyWith(
                  color: Colors.grey,
                  letterSpacing: 1.5,
                  fontSize: 10.spMin,
                ),
              ),
              SizedBox(width: 8.w),
              Switch(
                value: false,
                onChanged: (v) {},
                activeThumbColor: const Color(0xFFFF5A36),
                activeTrackColor: const Color(
                  0xFFFF5A36,
                ).withValues(alpha: 0.3),
              ),
            ],
          ),
          Icon(Icons.lock_outline_rounded, color: Colors.grey, size: 24.spMin),
          GestureDetector(
            onTap: () {
              if (viewModel.state == TrackingState.idle) {
                viewModel.startWorkout();
              } else if (viewModel.state == TrackingState.active) {
                viewModel.pauseWorkout();
              } else {
                viewModel.resumeWorkout();
              }
            },
            child: Container(
              width: 56.spMin,
              height: 56.spMin,
              decoration: BoxDecoration(
                color: const Color(0xFFFF5A36),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF5A36).withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                viewModel.state == TrackingState.active
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
                color: Colors.white,
                size: 32.spMin,
              ),
            ),
          ),
          if (viewModel.state != TrackingState.idle)
            GestureDetector(
              onTap: () => viewModel.stopWorkout(),
              child: Container(
                width: 48.spMin,
                height: 48.spMin,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.stop_rounded,
                  color: Colors.white,
                  size: 24.spMin,
                ),
              ),
            )
          else
            SizedBox(width: 48.spMin),
        ],
      ),
    );
  }
}

class BatteryCard extends StatefulWidget {
  const BatteryCard({super.key});

  @override
  State<BatteryCard> createState() => _BatteryCardState();
}

class _BatteryCardState extends State<BatteryCard> {
  int _batteryLevel = 100;
  final Battery _battery = Battery();

  @override
  void initState() {
    super.initState();
    _fetchBattery();
    _battery.onBatteryStateChanged.listen((state) {
      _fetchBattery();
    });
  }

  Future<void> _fetchBattery() async {
    final level = await _battery.batteryLevel;
    if (mounted) setState(() => _batteryLevel = level);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.spMin),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E22),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'BATTERY',
            style: AppTypography.label.copyWith(
              color: Colors.grey,
              fontSize: 10.spMin,
            ),
          ),
          Row(
            children: [
              Text(
                '$_batteryLevel%',
                style: AppTypography.bodySmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.spMin,
                ),
              ),
              SizedBox(width: 4.w),
              Icon(
                _batteryLevel > 20
                    ? Icons.battery_full_rounded
                    : Icons.battery_alert_rounded,
                color: _batteryLevel > 20
                    ? const Color(0xFFFF5A36)
                    : Colors.red,
                size: 14.spMin,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF5A36).withValues(alpha: 0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    const dashWidth = 8;
    const dashSpace = 6;
    final circumference = 2 * pi * radius;
    final dashCount = (circumference / (dashWidth + dashSpace)).floor();
    final anglePerDash = (2 * pi) / dashCount;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * anglePerDash;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        anglePerDash * (dashWidth / (dashWidth + dashSpace)),
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ArcSpeedometerPainter extends CustomPainter {
  final double speed;
  ArcSpeedometerPainter({required this.speed});

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

    const startAngle = pi * 0.75;
    const sweepAngle = pi * 1.5;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      trackPaint,
    );

    final progress = (speed / 40.0).clamp(0.0, 1.0);
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
  bool shouldRepaint(covariant ArcSpeedometerPainter oldDelegate) =>
      oldDelegate.speed != speed;
}
