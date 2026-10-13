import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';

class CompactTopBar extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onProfileTap;

  const CompactTopBar({
    super.key,
    this.onMenuTap,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          // 1. Hamburger Menu on the Left
          _buildIconButton(
            context: context,
            icon: Icons.menu_rounded,
            onTap: onMenuTap,
            tooltip: 'Menu',
          ),

          const SizedBox(width: 14),

          // 2. Liftly Logo (Center-Left) with handwritten style & lime underline
          const LiftlyLogo(),

          const Spacer(),

          // 3. Light / Dark Mode Toggle
          _buildThemeToggle(context),

          const SizedBox(width: 10),

          // 4. Circular Profile Avatar
          _buildProfileAvatar(context),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required BuildContext context,
    required IconData icon,
    VoidCallback? onTap,
    String? tooltip,
  }) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: context.borderColor,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(13),
          onTap: onTap,
          child: Icon(
            icon,
            size: 22,
            color: context.textPrimaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    final isDark = context.isDarkMode;

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: context.borderColor,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          key: const Key('theme_toggle_button'),
          borderRadius: BorderRadius.circular(13),
          onTap: () {
            themeModeNotifier.value =
                isDark ? ThemeMode.light : ThemeMode.dark;
          },
          child: Icon(
            isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            size: 20,
            color: isDark ? AppColors.neonLime : AppColors.electricCyan,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAvatar(BuildContext context) {
    return GestureDetector(
      onTap: onProfileTap,
      child: Container(
        width: 42,
        height: 42,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [AppColors.neonLime, AppColors.electricCyan],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonLime.withValues(alpha: 0.25),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.surfaceColor,
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.person_rounded,
                color: context.isDarkMode ? AppColors.neonLime : AppColors.lightTextPrimary,
                size: 22,
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Liftly Logo with its handwritten style and lime underline
class LiftlyLogo extends StatelessWidget {
  const LiftlyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = context.textPrimaryColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Liftly',
          style: GoogleFonts.caveat(
            fontSize: 27,
            fontWeight: FontWeight.w800,
            color: textColor,
            letterSpacing: 0.5,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 1),
        // Handwritten-style lime underline
        CustomPaint(
          size: const Size(42, 4),
          painter: LimeUnderlinePainter(),
        ),
      ],
    );
  }
}

class LimeUnderlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.neonLime
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.15,
      size.width,
      size.height * 0.85,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
