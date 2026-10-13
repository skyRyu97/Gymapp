import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../models/exercise.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/greeting_section.dart';
import 'widgets/hero_workout_card.dart';
import 'widgets/top_bar.dart';
import 'widgets/weekday_selector.dart';

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

  static const List<String> dayDateHeadings = [
    'MON, APR 28',
    'TUE, APR 29',
    'WED, APR 30',
    'THU, MAY 1',
    'FRI, MAY 2',
    'SAT, MAY 3',
    'SUN, MAY 4',
  ];

  @override
  void initState() {
    super.initState();
    // Default to current weekday: DateTime.now().weekday (1=Mon ... 7=Sun) -> 0..6
    _selectedDayIndex = (DateTime.now().weekday - 1).clamp(0, 6);
    _loadExerciseForCurrentState();
  }

  void _loadExerciseForCurrentState() {
    final dayWorkouts = MockExerciseData.weeklyWorkouts[_selectedDayIndex];
    if (dayWorkouts.isEmpty) return;

    if (_currentExerciseIndex >= dayWorkouts.length) {
      _currentExerciseIndex = 0;
    }

    setState(() {
      _activeExercise = dayWorkouts[_currentExerciseIndex];
    });
  }

  void _onDaySelected(int dayIndex) {
    setState(() {
      _selectedDayIndex = dayIndex;
      _currentExerciseIndex = 0;
      _loadExerciseForCurrentState();
    });
  }

  void _onNextExercise() {
    final dayWorkouts = MockExerciseData.weeklyWorkouts[_selectedDayIndex];
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
        title: "${alt.title} 🔥",
        imageUrl: alt.imageUrl,
        demoImage: alt.demoImage,
        difficulty: alt.difficulty,
        duration: alt.duration,
        about: alt.about,
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
        MockExerciseData.weeklyWorkouts[_selectedDayIndex].first;

    showModalBottomSheet(
      context: context,
      backgroundColor: context.surfaceColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: context.borderColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 18),

                // Live Workout Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "SESSION ACTIVE",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.neonLime,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.neonLime.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        currentExercise.duration,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: AppColors.neonLime,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Text(
                  currentExercise.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: context.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  currentExercise.about,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: context.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 24),

                // Finish / Close Workout Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.neonLime,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            "Great workout completed! Keep it up!",
                            style: TextStyle(
                              color: AppColors.textDark,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          backgroundColor: AppColors.neonLime,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Complete Exercise",
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentExercise = _activeExercise ??
        MockExerciseData.weeklyWorkouts[_selectedDayIndex].first;
    final currentDateHeading = dayDateHeadings[_selectedDayIndex];

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

                    // B. Weekday Selector (Mon - Sun)
                    WeekdaySelector(
                      selectedDayIndex: _selectedDayIndex,
                      onDaySelected: _onDaySelected,
                    ),

                    // C. Main Hero Workout Card
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
