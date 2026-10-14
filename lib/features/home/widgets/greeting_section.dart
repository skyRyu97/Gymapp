import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/date_helpers.dart';

class GreetingSection extends StatelessWidget {
  final String userName;

  const GreetingSection({
    super.key,
    this.userName = 'Gagan',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final greeting = DateHelpers.timeOfDayGreeting;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$greeting ',
                  style: TextStyle(
                    color: isDark ? Colors.white : AppColors.lightTextPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.2,
                  ),
                ),
                TextSpan(
                  text: userName,
                  style: const TextStyle(
                    color: AppColors.neonLime,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.4,
                  ),
                ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 1),
          Text(
            'Small steps. Big changes.',
            style: TextStyle(
              color: context.textSecondaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.1,
            ),
          ),
        ],
      ),
    );
  }
}
