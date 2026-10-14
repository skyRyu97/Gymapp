import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../models/exercise.dart';
import '../../core/utils/date_helpers.dart';
import '../../data/sample_data.dart';
import '../../screens/workout_session_screen.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/greeting_section.dart';
import 'widgets/hero_workout_card.dart';
import 'widgets/top_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // State: selected day (0=Mon, 6=Sun) initialized with today
  late int _selectedDayIndex;

  // State: current exercise index within selected day
  int _currentExerciseIndex = 0;

  // State: currently active exercise (can be overridden by alternative swap)
  Exercise? _activeExercise;

  // State: bottom navigation bar selected index
  int _bottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    // Automatically detect current day of the week
    _selectedDayIndex = DateHelpers.currentWeekdayIndex;
    _loadExerciseForCurrentState();
  }

  List<Exercise> get _todayExercises =>
      SampleData.sampleWeeklyPlan.weeklySchedule[_selectedDayIndex] ?? [];

  void _loadExerciseForCurrentState() {
    final dayWorkouts = _todayExercises;
    if (dayWorkouts.isEmpty) return;

    if (_currentExerciseIndex >= dayWorkouts.length) {
      _currentExerciseIndex = 0;
    }

    setState(() {
      _activeExercise = dayWorkouts[_currentExerciseIndex];
    });
  }

  void _onNextExercise() {
    final dayWorkouts = _todayExercises;
    if (dayWorkouts.isEmpty) return;

    setState(() {
      _currentExerciseIndex = (_currentExerciseIndex + 1) % dayWorkouts.length;
      _activeExercise = dayWorkouts[_currentExerciseIndex];
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Next exercise loaded: ${_activeExercise?.title}",
          style: const TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.w700,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: AppColors.neonLime,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _onSelectAlternative(ExerciseAlternative alt) {
    if (_activeExercise == null) return;

    // Create a new swapped exercise representation
    final swappedAlternatives = <ExerciseAlternative>[];

    // Put current active exercise into the alternatives list
    swappedAlternatives.add(
      ExerciseAlternative(
        title: _activeExercise!.title.replaceAll(' 🔥', '').replaceAll(' ⚡', '').replaceAll(' 🎯', '').replaceAll(' 🚀', '').replaceAll(' 💥', '').replaceAll(' 🧘', ''),
        imageUrl: _activeExercise!.imageUrl,
        demoImage: _activeExercise!.demoImage,
        difficulty: _activeExercise!.difficulty,
        duration: _activeExercise!.duration,
        about: _activeExercise!.about,
      ),
    );

    // Keep other alternatives except the chosen one
    for (final existingAlt in _activeExercise!.alternatives) {
      if (existingAlt.title != alt.title) {
        swappedAlternatives.add(existingAlt);
      }
    }

    setState(() {
      _activeExercise = Exercise(
        id: 'swapped_${DateTime.now().millisecondsSinceEpoch}',
        name: "${alt.title} 🔥",
        description: alt.about,
        difficulty: alt.difficulty,
        defaultReps: alt.duration,
        heroImage: alt.imageUrl,
        demoImage: alt.demoImage,
        alternatives: swappedAlternatives,
      );
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.swap_horiz_rounded,
              color: AppColors.textDark,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Swapped to ${alt.title}!",
                style: const TextStyle(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.neonLime,
        duration: const Duration(milliseconds: 1400),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _onStartWorkout() {
    final currentExercise = _activeExercise ??
        (_todayExercises.isNotEmpty ? _todayExercises.first : SampleData.planks);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WorkoutSessionScreen(exercise: currentExercise),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentExercise = _activeExercise ??
        (_todayExercises.isNotEmpty ? _todayExercises.first : SampleData.planks);
    final currentDateHeading = DateHelpers.formattedTodayDate.toUpperCase();

    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            // 1. Compact Header (Pinned at Top)
            CompactTopBar(
              onMenuTap: () => _showActionToast("Sidebar menu coming soon"),
              onProfileTap: () => _showActionToast("Profile: Level 14 Athlete"),
            ),

            // 2. Central Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // A. Personalized Greeting
                    const GreetingSection(userName: 'Gagan'),

                    const SizedBox(height: 8),

                    // B. Main Hero Workout Card (Automated for Today)
                    HeroWorkoutCard(
                      exercise: currentExercise,
                      dateHeading: currentDateHeading,
                      onNextExercise: _onNextExercise,
                      onSelectAlternative: _onSelectAlternative,
                      onStartWorkout: _onStartWorkout,
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // 3. Fixed Bottom Navigation Bar (Never Overlaps Workout Card)
            LiftlyBottomNavBar(
              selectedIndex: _bottomNavIndex,
              onItemSelected: (index) {
                setState(() {
                  _bottomNavIndex = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showActionToast(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: context.textPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: context.surfaceColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: AppColors.electricCyan.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
    );
  }
}
