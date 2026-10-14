// lib/screens/placeholder_screens.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../providers/theme_provider.dart';
import '../providers/user_profile_provider.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPlaceholderScaffold(
      context,
      title: 'Workout Schedule',
      subtitle: 'Your weekly training split and planned recovery days.',
      icon: Icons.calendar_month_outlined,
    );
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPlaceholderScaffold(
      context,
      title: 'Progress & Analytics',
      subtitle: 'Weekly volume, personal records, and consistency metrics.',
      icon: Icons.trending_up_rounded,
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = context.watch<UserProfileProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final profile = userProfileProvider.profile;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Athlete Profile',
          style: GoogleFonts.manrope(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: context.textPrimaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              // Avatar
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.darkSurfaceElevated,
                  border: Border.all(color: AppColors.neonLime, width: 2),
                ),
                child: Center(
                  child: Text(
                    (profile?.name.isNotEmpty == true) ? profile!.name[0].toUpperCase() : 'A',
                    style: GoogleFonts.manrope(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: AppColors.neonLime,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                profile?.name ?? 'Athlete',
                style: GoogleFonts.manrope(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: context.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${profile?.goal ?? "Fitness"} • ${profile?.experienceLevel ?? "Intermediate"}',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  color: context.textSecondaryColor,
                ),
              ),
              const SizedBox(height: 30),

              // Profile Details Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: context.surfaceColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: context.borderColor),
                ),
                child: Column(
                  children: [
                    _buildInfoRow(context, 'Equipment Tier', profile?.equipment ?? 'Rich'),
                    const Divider(color: AppColors.darkBorder, height: 24),
                    _buildInfoRow(context, 'Weekly Target', '${profile?.daysPerWeek ?? 4} Days/Week'),
                    const Divider(color: AppColors.darkBorder, height: 24),
                    _buildInfoRow(context, 'Limitations', (profile?.limitations.isNotEmpty == true) ? profile!.limitations : 'None reported'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Theme Toggle Tile
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: context.surfaceColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: context.borderColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          themeProvider.isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                          color: AppColors.neonLime,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Dark Theme',
                          style: GoogleFonts.manrope(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: context.textPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: themeProvider.isDarkMode,
                      activeThumbColor: AppColors.neonLime,
                      onChanged: (val) => themeProvider.toggleTheme(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Edit / Reset Profile
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/onboarding');
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.electricCyan),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: Text(
                  'Update Preferences',
                  style: GoogleFonts.manrope(
                    color: AppColors.electricCyan,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 14,
            color: context.textSecondaryColor,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: context.textPrimaryColor,
          ),
        ),
      ],
    );
  }
}

Widget _buildPlaceholderScaffold(
  BuildContext context, {
  required String title,
  required String subtitle,
  required IconData icon,
}) {
  return Scaffold(
    backgroundColor: context.backgroundColor,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        title,
        style: GoogleFonts.manrope(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: context.textPrimaryColor,
        ),
      ),
      centerTitle: true,
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: context.surfaceColor,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.neonLime.withValues(alpha: 0.3)),
              ),
              child: Icon(icon, size: 48, color: AppColors.neonLime),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: context.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 14,
                color: context.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
