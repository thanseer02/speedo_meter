import 'package:flutter/material.dart';
import 'package:speedtrack/core/theme/app_colors.dart';
import 'package:speedtrack/core/theme/app_typography.dart';

class CustomNavigationRail extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const CustomNavigationRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      color: const Color(
        0xFF111315,
      ), // Very dark background matching screenshot
      child: ListView(
        children: [
          const SizedBox(height: 32),

          _buildNavItem(Icons.home_filled, 'HOME', 0, context),
          const SizedBox(height: 24),
          _buildNavItem(Icons.bar_chart_rounded, 'DATA', 1, context),
          const SizedBox(height: 24),
          _buildNavItem(Icons.history_rounded, 'LOGS', 2, context),
          const SizedBox(height: 24),
          _buildNavItem(Icons.emoji_events_rounded, 'WINS', 3, context),
          const SizedBox(height: 24),
          _buildNavItem(Icons.settings_outlined, 'SETTINGS', 4, context),
          const SizedBox(height: 24),
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
        : AppColors.textSecondary; // Cyan if active

    return InkWell(
      onTap: () => onDestinationSelected(index),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 28),
          if (label.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.label.copyWith(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
