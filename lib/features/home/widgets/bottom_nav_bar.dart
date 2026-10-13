import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class NavItemData {
  final String label;
  final IconData icon;

  const NavItemData({
    required this.label,
    required this.icon,
  });
}

class LiftlyBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const LiftlyBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  static const List<NavItemData> navItems = [
    NavItemData(
      label: 'Home',
      icon: Icons.home_outlined,
    ),
    NavItemData(
      label: 'Schedule',
      icon: Icons.calendar_today_outlined,
    ),
    NavItemData(
      label: 'Progress',
      icon: Icons.trending_up_rounded,
    ),
    NavItemData(
      label: 'Profile',
      icon: Icons.person_outline_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        border: Border(
          top: BorderSide(
            color: context.borderColor,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: context.isDarkMode ? 0.35 : 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        bottom: true,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(navItems.length, (index) {
              final item = navItems[index];
              final isActive = index == selectedIndex;

              return Expanded(
                child: _buildNavItem(
                  context: context,
                  item: item,
                  isActive: isActive,
                  onTap: () => onItemSelected(index),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required NavItemData item,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final inactiveColor = context.textSecondaryColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.neonLime.withValues(alpha: 0.12),
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              size: 22,
              color: isActive ? AppColors.neonLime : inactiveColor,
            ),
            const SizedBox(height: 2),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w500,
                color: isActive ? AppColors.neonLime : inactiveColor,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 2),
            // Active underline indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isActive ? 16 : 0,
              height: 2.5,
              decoration: BoxDecoration(
                color: isActive ? AppColors.neonLime : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: AppColors.neonLime.withValues(alpha: 0.8),
                          blurRadius: 4,
                          spreadRadius: 0.5,
                        ),
                      ]
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
