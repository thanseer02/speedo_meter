import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speedtrack/viewmodels/tracking_viewmodel.dart';
import 'package:speedtrack/widgets/speedometer_painter.dart';

class TrackingScreen extends StatelessWidget {
  static const String routeName = '/tracking';

  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackingViewModel>(
      builder: (context, viewModel, child) {
        final speed = viewModel.lastLocation?.speed ?? 0.0;
        // Convert m/s to km/h
        final speedKmh = speed * 3.6; 
        
        return Scaffold(
          body: Stack(
            children: [
              // Placeholder for Map since API key is not available
              Positioned.fill(
                child: Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.map_outlined,
                          size: 64.w,
                          color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Map Unavailable',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Speedometer Overlay
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 20.h),
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    width: 250.w,
                    height: 250.w,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          size: Size(250.w, 250.w),
                          painter: SpeedometerPainter(
                            currentSpeed: speedKmh,
                            maxSpeed: 30.0,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              speedKmh.toStringAsFixed(1),
                              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'km/h',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: _buildControls(context, viewModel),
        );
      },
    );
  }

  Widget _buildControls(BuildContext context, TrackingViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (viewModel.state == TrackingState.idle)
            FloatingActionButton.extended(
              onPressed: () => viewModel.startWorkout(),
              label: const Text('START'),
              icon: const Icon(Icons.play_arrow),
              backgroundColor: Colors.green,
            ),
          if (viewModel.state == TrackingState.active)
            FloatingActionButton.extended(
              onPressed: () => viewModel.pauseWorkout(),
              label: const Text('PAUSE'),
              icon: const Icon(Icons.pause),
              backgroundColor: Colors.orange,
            ),
          if (viewModel.state == TrackingState.paused) ...[
            FloatingActionButton.extended(
              onPressed: () => viewModel.resumeWorkout(),
              label: const Text('RESUME'),
              icon: const Icon(Icons.play_arrow),
              backgroundColor: Colors.green,
            ),
            FloatingActionButton.extended(
              onPressed: () => viewModel.stopWorkout(),
              label: const Text('STOP'),
              icon: const Icon(Icons.stop),
              backgroundColor: Colors.red,
            ),
          ]
        ],
      ),
    );
  }
}
