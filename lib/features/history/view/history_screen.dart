import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:speedtrack/viewmodels/history_viewmodel.dart';
import 'package:speedtrack/models/workout_model.dart';

class HistoryScreen extends StatelessWidget {
  static const String routeName = '/history';

  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity History'),
        centerTitle: true,
      ),
      body: Consumer<HistoryViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.workouts.isEmpty) {
            return const Center(
              child: Text('No workouts recorded yet.\nGo for a run!'),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: SizedBox(
                    height: 200.h,
                    child: _buildChart(context, viewModel.workouts),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final workout = viewModel.workouts[index];
                      return _buildWorkoutCard(context, workout, viewModel);
                    },
                    childCount: viewModel.workouts.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildChart(BuildContext context, List<WorkoutModel> workouts) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 10,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                // Simplified mock days
                const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                return Text(days[value.toInt() % 7]);
              },
            ),
          ),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: [
          // Mock data for the chart visual
          for (int i = 0; i < 7; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: (i * 1.5) % 8 + 1,
                  color: Theme.of(context).colorScheme.primary,
                  width: 16.w,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildWorkoutCard(BuildContext context, WorkoutModel workout, HistoryViewModel vm) {
    return Dismissible(
      key: Key(workout.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        vm.deleteWorkout(workout.id);
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: ListTile(
          contentPadding: EdgeInsets.all(16.w),
          leading: Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.directions_run,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          title: Text(
            '${(workout.distance / 1000).toStringAsFixed(2)} km Run',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('${workout.startTime.day}/${workout.startTime.month}/${workout.startTime.year}'),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
