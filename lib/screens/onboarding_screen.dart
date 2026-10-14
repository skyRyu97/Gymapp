// lib/screens/onboarding_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../models/app_models.dart';
import '../providers/user_profile_provider.dart';
import '../providers/workout_provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _nameController = TextEditingController();
  final _limitationsController = TextEditingController();

  String _selectedGoal = 'Build Muscle';
  String _selectedExperience = 'Intermediate';
  String _selectedEquipment = 'Rich';
  int _daysPerWeek = 4;

  final List<String> _goals = [
    'Build Muscle',
    'Lose Fat',
    'Strength',
    'General Fitness',
  ];

  final List<String> _experiences = [
    'Beginner',
    'Intermediate',
    'Advanced',
  ];

  final List<String> _equipments = [
    'Basic',
    'Intermediate',
    'Rich',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _limitationsController.dispose();
    super.dispose();
  }

  void _finishOnboarding() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your name to personalize your workouts!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final profile = UserProfile(
      name: name,
      goal: _selectedGoal,
      experienceLevel: _selectedExperience,
      equipment: _selectedEquipment,
      daysPerWeek: _daysPerWeek,
      limitations: _limitationsController.text.trim(),
    );

    final userProfileProvider = context.read<UserProfileProvider>();
    final workoutProvider = context.read<WorkoutProvider>();

    await userProfileProvider.saveProfile(profile);
    await workoutProvider.refreshPlan(profile);

    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo Header
              Text(
                'Liftly',
                style: GoogleFonts.manrope(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.neonLime,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Let\'s build your personalized routine.',
                style: GoogleFonts.manrope(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkTextPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tell us a bit about your setup and goals.',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  color: AppColors.darkTextSecondary,
                ),
              ),
              const SizedBox(height: 28),

              // Name Field
              _buildSectionTitle('What\'s your name?'),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                style: GoogleFonts.manrope(color: AppColors.darkTextPrimary),
                decoration: _inputDecoration('e.g. Alex Hunter'),
              ),
              const SizedBox(height: 24),

              // Goal Selector
              _buildSectionTitle('Primary Goal'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _goals.map((goal) {
                  final isSelected = _selectedGoal == goal;
                  return _buildChoiceChip(
                    label: goal,
                    isSelected: isSelected,
                    onSelected: () => setState(() => _selectedGoal = goal),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Experience Level
              _buildSectionTitle('Experience Level'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _experiences.map((exp) {
                  final isSelected = _selectedExperience == exp;
                  return _buildChoiceChip(
                    label: exp,
                    isSelected: isSelected,
                    onSelected: () => setState(() => _selectedExperience = exp),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Available Equipment
              _buildSectionTitle('Gym Equipment Setup'),
              const SizedBox(height: 4),
              Text(
                'Basic (Home/Bands) • Inter (Dumbbells/Barbell) • Rich (Full Machines)',
                style: GoogleFonts.manrope(fontSize: 12, color: AppColors.darkTextSecondary),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _equipments.map((eq) {
                  final isSelected = _selectedEquipment == eq;
                  return _buildChoiceChip(
                    label: eq,
                    isSelected: isSelected,
                    onSelected: () => setState(() => _selectedEquipment = eq),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Days Per Week
              _buildSectionTitle('Workout Days / Week: $_daysPerWeek days'),
              Slider(
                value: _daysPerWeek.toDouble(),
                min: 2,
                max: 6,
                divisions: 4,
                activeColor: AppColors.neonLime,
                inactiveColor: AppColors.darkBorder,
                label: '$_daysPerWeek days',
                onChanged: (val) {
                  setState(() => _daysPerWeek = val.round());
                },
              ),
              const SizedBox(height: 20),

              // Limitations / Injuries
              _buildSectionTitle('Any injuries or physical limitations? (Optional)'),
              const SizedBox(height: 8),
              TextField(
                controller: _limitationsController,
                style: GoogleFonts.manrope(color: AppColors.darkTextPrimary),
                decoration: _inputDecoration('e.g. Mild lower-back sensitivity'),
              ),
              const SizedBox(height: 36),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _finishOnboarding,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonLime,
                    foregroundColor: AppColors.textDark,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Start Training',
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.manrope(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.darkTextPrimary,
      ),
    );
  }

  Widget _buildChoiceChip({
    required String label,
    required bool isSelected,
    required VoidCallback onSelected,
  }) {
    return GestureDetector(
      onTap: onSelected,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.neonLime : AppColors.darkSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.neonLime : AppColors.darkBorder,
            width: 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.neonLime.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
            color: isSelected ? AppColors.textDark : AppColors.darkTextPrimary,
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.manrope(color: AppColors.darkTextSecondary.withValues(alpha: 0.6)),
      filled: true,
      fillColor: AppColors.darkSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.darkBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.neonLime, width: 1.5),
      ),
    );
  }
}
