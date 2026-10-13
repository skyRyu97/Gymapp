import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/exercise.dart';

class HeroWorkoutCard extends StatelessWidget {
  final Exercise exercise;
  final String dateHeading;
  final VoidCallback onNextExercise;
  final ValueChanged<ExerciseAlternative> onSelectAlternative;
  final VoidCallback onStartWorkout;

  const HeroWorkoutCard({
    super.key,
    required this.exercise,
    this.dateHeading = 'MON, APR 28',
    required this.onNextExercise,
    required this.onSelectAlternative,
    required this.onStartWorkout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      // Neon green-to-cyan gradient border
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: AppColors.cardBorderGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.neonLime.withValues(alpha: 0.10),
            blurRadius: 20,
            spreadRadius: -2,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: AppColors.electricCyan.withValues(alpha: 0.08),
            blurRadius: 18,
            spreadRadius: -4,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(1.5), // Gradient border thickness
      child: Container(
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(24.5),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. Gym Photograph at the top of the card
            _buildGymPhoto(context),

            // Small gap (about 4-6px) between gym photo and demo panel
            const SizedBox(height: 5),

            // 2. Exercise Demonstration Image Panel with Next Arrow button
            _buildDemoImagePanel(context),

            // 3. Card Content Section
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Category label: TODAY'S WORKOUT
                  const Text(
                    "TODAY'S WORKOUT",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: AppColors.neonLime,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 2),

                  // Large Date Heading
                  Text(
                    dateHeading,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Exercise Title
                  Text(
                    exercise.title,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.4,
                      height: 1.15,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 10),

                  // Metadata Badges (Difficulty & Duration)
                  _buildMetadataBadges(context),

                  const SizedBox(height: 12),

                  // Start Workout Button (Strongest Call to Action)
                  _buildStartWorkoutButton(),

                  const SizedBox(height: 10),

                  // Compact "ABOUT:" Panel
                  _buildAboutPanel(context),

                  const SizedBox(height: 8),

                  // Compact "ALTERNATIVE:" Panel with interactive thumbnails
                  _buildAlternativePanel(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGymPhoto(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageHeight = (constraints.maxWidth * 0.46).clamp(145.0, 185.0);

        return SizedBox(
          height: imageHeight,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Gym photograph showing exercise / forearm plank
              Image.network(
                exercise.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: context.surfaceElevatedColor,
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.neonLime),
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: context.surfaceElevatedColor,
                    child: const Center(
                      child: Icon(
                        Icons.fitness_center_rounded,
                        color: AppColors.neonLime,
                        size: 44,
                      ),
                    ),
                  );
                },
              ),

              // Gradient vignette overlay at the bottom to blend into the card
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.15),
                      Colors.transparent,
                      context.surfaceColor.withValues(alpha: 0.8),
                      context.surfaceColor,
                    ],
                    stops: const [0.0, 0.4, 0.85, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),

              // Workout Live Pill Tag in top-left
              Positioned(
                top: 14,
                left: 14,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.neonLime.withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: AppColors.neonLime,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.neonLime.withValues(alpha: 0.8),
                              blurRadius: 6,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        "TARGET FOCUS",
                        style: TextStyle(
                          color: AppColors.neonLime,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDemoImagePanel(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Full width edge-to-edge illustration panel on white background
        Container(
          width: double.infinity,
          height: 195,
          color: Colors.white,
          alignment: Alignment.center,
          child: exercise.demoImage.isNotEmpty
              ? Image.asset(
                  exercise.demoImage,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildDemoPlaceholder(context);
                  },
                )
              : _buildDemoPlaceholder(context),
        ),

        // Circular lime-green "next" arrow button sitting at bottom-right,
        // slightly overlapping the panel's bottom edge
        Positioned(
          right: 14,
          bottom: -16,
          child: GestureDetector(
            key: const Key('next_exercise_button'),
            onTap: onNextExercise,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.neonLime,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.neonLime.withValues(alpha: 0.6),
                    blurRadius: 16,
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.textDark,
                  size: 22,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDemoPlaceholder(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Frame 1: Start Position
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F7F8),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFDCE5E9),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.fitness_center_rounded,
                      size: 36,
                      color: Color(0xFF15212A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "1. START",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF15212A),
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),

              // Transition movement indicator
              const Icon(
                Icons.arrow_forward_rounded,
                size: 24,
                color: Color(0xFF637585),
              ),

              // Frame 2: Finish Position
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F7F8),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFC4FF5A),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.sports_gymnastics_rounded,
                      size: 36,
                      color: Color(0xFF15212A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "2. FINISH",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF15212A),
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFEDF2F4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "TECHNIQUE & FORM GUIDE",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Color(0xFF637585),
                letterSpacing: 0.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetadataBadges(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [
        // Difficulty Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0x1AFFD166),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.goldAccent.withValues(alpha: 0.6),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.bolt_rounded,
                size: 14,
                color: AppColors.goldAccent,
              ),
              const SizedBox(width: 4),
              Text(
                "Difficulty: ${exercise.difficulty}",
                style: const TextStyle(
                  color: AppColors.goldAccent,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),

        // Duration Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0x1A00D9FF),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.electricCyan.withValues(alpha: 0.6),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.schedule_rounded,
                size: 14,
                color: AppColors.electricCyan,
              ),
              const SizedBox(width: 4),
              Text(
                "Duration: ${exercise.duration}",
                style: const TextStyle(
                  color: AppColors.electricCyan,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStartWorkoutButton() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.neonLime,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonLime.withValues(alpha: 0.45),
            blurRadius: 16,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          key: const Key('start_workout_button'),
          borderRadius: BorderRadius.circular(25),
          onTap: onStartWorkout,
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.play_arrow_rounded,
                  color: AppColors.textDark,
                  size: 24,
                ),
                SizedBox(width: 6),
                Text(
                  "Start Workout",
                  style: TextStyle(
                    color: AppColors.textDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutPanel(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: context.surfaceElevatedColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: context.borderColor,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: AppColors.electricCyan.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.info_outline_rounded,
              color: AppColors.electricCyan,
              size: 15,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "ABOUT:",
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.electricCyan,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  exercise.about,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.textPrimaryColor,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _titleCase(String text) {
    return text.split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  Widget _buildAlternativePanel(BuildContext context) {
    final alternativeTitles =
        exercise.alternatives.map((a) => _titleCase(a.title)).join(", ");

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: context.surfaceElevatedColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: context.borderColor,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Info & Alternative titles
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.swap_horiz_rounded,
                      size: 15,
                      color: AppColors.neonLime,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "ALTERNATIVE:",
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.neonLime,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  alternativeTitles,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: context.textSecondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Right: 2 Small Exercise Thumbnails
          Row(
            mainAxisSize: MainAxisSize.min,
            children: exercise.alternatives.map((alt) {
              return Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: _buildAlternativeThumbnail(context, alt),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAlternativeThumbnail(
      BuildContext context, ExerciseAlternative alt) {
    return Tooltip(
      message: "Swap to ${alt.title}",
      child: GestureDetector(
        key: ValueKey('alt_${alt.title}'),
        onTap: () => onSelectAlternative(alt),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.neonLime.withValues(alpha: 0.5),
              width: 1.2,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                alt.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: context.surfaceColor,
                    child: const Icon(
                      Icons.fitness_center_rounded,
                      color: AppColors.neonLime,
                      size: 18,
                    ),
                  );
                },
              ),
              // Subtle dark tint with swap icon overlay
              Container(
                color: Colors.black.withValues(alpha: 0.25),
                child: const Center(
                  child: Icon(
                    Icons.swap_calls_rounded,
                    color: AppColors.neonLime,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
