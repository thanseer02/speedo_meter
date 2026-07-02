import 'package:flutter/material.dart';
import 'package:speedtrack/core/theme/app_colors.dart';
import 'package:speedtrack/core/theme/app_typography.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: const Color(0xFF111315),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home_filled, 'HOME', 0, context),
          _buildNavItem(Icons.bar_chart_rounded, 'DATA', 1, context),
          _buildNavItem(Icons.history_rounded, 'LOGS', 2, context),
          _buildNavItem(Icons.emoji_events_rounded, 'WINS', 3, context),
          _buildNavItem(Icons.settings_outlined, 'SETTINGS', 4, context),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    int index,
    BuildContext context,
  ) {
    final isSelected = selectedIndex == index;
    final color = isSelected
        ? const Color(0xFF00E5FF)
        : AppColors.textSecondary; 

    return InkWell(
      onTap: () => onDestinationSelected(index),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTypography.label.copyWith(
              color: color,
              fontSize: 10,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
