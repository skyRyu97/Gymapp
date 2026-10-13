import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class WeekdaySelector extends StatelessWidget {
  final int selectedDayIndex;
  final ValueChanged<int> onDaySelected;

  static const List<String> weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  const WeekdaySelector({
    super.key,
    required this.selectedDayIndex,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final gap = constraints.maxWidth < 380 ? 4.0 : 6.0;
          final itemWidth = (constraints.maxWidth - (6 * gap)) / 7;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final isSelected = index == selectedDayIndex;
              final dayName = weekdays[index];

              return _buildDayButton(
                context: context,
                dayName: dayName,
                isSelected: isSelected,
                width: itemWidth,
                onTap: () => onDaySelected(index),
              );
            }),
          );
        },
      ),
    );
  }

  Widget _buildDayButton({
    required BuildContext context,
    required String dayName,
    required bool isSelected,
    required double width,
    required VoidCallback onTap,
  }) {
    final isDark = context.isDarkMode;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      width: width,
      height: 48,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.neonLime : context.surfaceColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSelected
              ? AppColors.neonLime
              : context.borderColor,
          width: isSelected ? 1.5 : 1.0,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppColors.neonLime.withValues(alpha: 0.35),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dayName,
                style: TextStyle(
                  color: isSelected
                      ? AppColors.textDark
                      : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                  fontSize: 12.5,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 3),
              // Small indicator dot beneath label
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? AppColors.textDark
                      : Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
