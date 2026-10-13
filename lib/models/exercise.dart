class ExerciseAlternative {
  final String title;
  final String imageUrl;
  final String demoImage;
  final String difficulty;
  final String duration;
  final String about;

  const ExerciseAlternative({
    required this.title,
    required this.imageUrl,
    this.demoImage = '',
    required this.difficulty,
    required this.duration,
    required this.about,
  });
}

class Exercise {
  final String title;
  final String imageUrl;
  final String demoImage;
  final String difficulty;
  final String duration;
  final String about;
  final List<ExerciseAlternative> alternatives;

  const Exercise({
    required this.title,
    required this.imageUrl,
    this.demoImage = '',
    required this.difficulty,
    required this.duration,
    required this.about,
    required this.alternatives,
  });

  Exercise copyWith({
    String? title,
    String? imageUrl,
    String? demoImage,
    String? difficulty,
    String? duration,
    String? about,
    List<ExerciseAlternative>? alternatives,
  }) {
    return Exercise(
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      demoImage: demoImage ?? this.demoImage,
      difficulty: difficulty ?? this.difficulty,
      duration: duration ?? this.duration,
      about: about ?? this.about,
      alternatives: alternatives ?? this.alternatives,
    );
  }
}

class MockExerciseData {
  static final List<List<Exercise>> weeklyWorkouts = [
    // 0: Monday (Core & Stability)
    [
      const Exercise(
        title: "FOREARM PLANKS 🔥",
        imageUrl:
            "https://images.unsplash.com/photo-1566241134883-13eb2393a3cc?auto=format&fit=crop&w=1200&q=80",
        demoImage: "assets/exercises/forearm_plank.png",
        difficulty: "Medium",
        duration: "1 min",
        about: "Engages your entire core, shoulders, and glutes.",
        alternatives: [
          ExerciseAlternative(
            title: "KNEE PLANKS",
            imageUrl:
                "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?auto=format&fit=crop&w=600&q=80",
            demoImage: "assets/exercises/knee_plank.png",
            difficulty: "Easy",
            duration: "45 sec",
            about: "Gentle core activation with reduced lower-back torque.",
          ),
          ExerciseAlternative(
            title: "HIGH PLANKS",
            imageUrl:
                "https://images.unsplash.com/photo-1598971639058-fab3c3109a00?auto=format&fit=crop&w=600&q=80",
            demoImage: "assets/exercises/high_plank.png",
            difficulty: "Medium",
            duration: "1 min",
            about: "Full arm extension strengthening wrists and deltoids.",
          ),
        ],
      ),
      const Exercise(
        title: "RUSSIAN TWISTS ⚡",
        imageUrl:
            "https://images.unsplash.com/photo-1541534741688-6078c6bfb5c5?auto=format&fit=crop&w=1200&q=80",
        demoImage: "assets/exercises/russian_twist.png",
        difficulty: "Hard",
        duration: "45 sec",
        about: "Torques rotational obliques and builds deep anti-shear control.",
        alternatives: [
          ExerciseAlternative(
            title: "HEEL TAPS",
            imageUrl:
                "https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&w=600&q=80",
            demoImage: "assets/exercises/heel_taps.png",
            difficulty: "Easy",
            duration: "40 sec",
            about: "Controlled lateral oblique touches on the mat.",
          ),
          ExerciseAlternative(
            title: "BICYCLE CRUNCHES",
            imageUrl:
                "https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&w=600&q=80",
            demoImage: "assets/exercises/bicycle_crunches.png",
            difficulty: "Medium",
            duration: "1 min",
            about: "Dynamic cross-body contraction firing rectus abdominis.",
          ),
        ],
      ),
      const Exercise(
        title: "HANGING LEG RAISES 🎯",
        imageUrl:
            "https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&w=1200&q=80",
        demoImage: "assets/exercises/hanging_leg_raise.png",
        difficulty: "Hard",
        duration: "1.5 min",
        about: "Heavy lower-abdominal contraction with grip-strength conditioning.",
        alternatives: [
          ExerciseAlternative(
            title: "LYING LEG RAISES",
            imageUrl:
                "https://images.unsplash.com/photo-1575052814086-f385e2e2ad1b?auto=format&fit=crop&w=600&q=80",
            demoImage: "assets/exercises/lying_leg_raise.png",
            difficulty: "Medium",
            duration: "1 min",
            about: "Grounded pelvic tilt protecting the spine.",
          ),
          ExerciseAlternative(
            title: "CAPTAIN'S CHAIR",
            imageUrl:
                "https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?auto=format&fit=crop&w=600&q=80",
            demoImage: "assets/exercises/captains_chair.png",
            difficulty: "Medium",
            duration: "1 min",
            about: "Forearm-supported knee drive isolating the lower core.",
          ),
        ],
      ),
    ],

    // 1: Tuesday (Chest & Triceps)
    [
      const Exercise(
        title: "INCLINE DB PRESS ⚡",
        imageUrl:
            "https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?auto=format&fit=crop&w=1200&q=80",
        demoImage: "assets/exercises/incline_db_press.png",
        difficulty: "Hard",
        duration: "3 sets x 10",
        about: "Targets upper clavicular head of the pectoralis major.",
        alternatives: [
          ExerciseAlternative(
            title: "FLAT BENCH PRESS",
            imageUrl:
                "https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&w=600&q=80",
            demoImage: "assets/exercises/flat_bench_press.png",
            difficulty: "Hard",
            duration: "3 sets x 8",
            about: "Maximal mechanical tension for mid-chest thickness.",
          ),
          ExerciseAlternative(
            title: "PUSH-UPS",
            imageUrl:
                "https://images.unsplash.com/photo-1598971639058-fab3c3109a00?auto=format&fit=crop&w=600&q=80",
            demoImage: "assets/exercises/push_ups.png",
            difficulty: "Easy",
            duration: "3 sets x 15",
            about: "Bodyweight foundation developing scapular control.",
          ),
        ],
      ),
    ],

    // 2: Wednesday (Legs & Quads)
    [
      const Exercise(
        title: "BARBELL BACK SQUAT 🚀",
        imageUrl:
            "https://images.unsplash.com/photo-1574680096145-d05b474e2155?auto=format&fit=crop&w=1200&q=80",
        demoImage: "assets/exercises/barbell_squat.png",
        difficulty: "Hard",
        duration: "4 sets x 8",
        about: "King of lower-body compounds maximizing quad and glute hypertrophy.",
        alternatives: [
          ExerciseAlternative(
            title: "GOBLET SQUAT",
            imageUrl:
                "https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&w=600&q=80",
            demoImage: "assets/exercises/goblet_squat.png",
            difficulty: "Medium",
            duration: "3 sets x 12",
            about: "Front-loaded kettlebell movement training upright posture.",
          ),
          ExerciseAlternative(
            title: "LEG PRESS",
            imageUrl:
                "https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?auto=format&fit=crop&w=600&q=80",
            demoImage: "assets/exercises/leg_press.png",
            difficulty: "Medium",
            duration: "3 sets x 12",
            about: "High-load quad isolation with zero axial spinal load.",
          ),
        ],
      ),
    ],

    // 3: Thursday (Back & Pull)
    [
      const Exercise(
        title: "WEIGHTED PULL-UPS 💥",
        imageUrl:
            "https://images.unsplash.com/photo-1598971639058-fab3c3109a00?auto=format&fit=crop&w=1200&q=80",
        demoImage: "assets/exercises/weighted_pullup.png",
        difficulty: "Hard",
        duration: "4 sets x 6",
        about: "Builds a wide V-taper and upper back pulling horsepower.",
        alternatives: [
          ExerciseAlternative(
            title: "LAT PULLDOWNS",
            imageUrl:
                "https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?auto=format&fit=crop&w=600&q=80",
            demoImage: "assets/exercises/lat_pulldown.png",
            difficulty: "Medium",
            duration: "3 sets x 12",
            about: "Cable-controlled lat retraction and eccentric control.",
          ),
          ExerciseAlternative(
            title: "BANDED PULL-UPS",
            imageUrl:
                "https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&w=600&q=80",
            demoImage: "assets/exercises/banded_pullup.png",
            difficulty: "Easy",
            duration: "3 sets x 8",
            about: "Assisted ascent for groove pattern progression.",
          ),
        ],
      ),
    ],

    // 4: Friday (Shoulders & Arms)
    [
      const Exercise(
        title: "OVERHEAD DB PRESS ⚡",
        imageUrl:
            "https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?auto=format&fit=crop&w=1200&q=80",
        demoImage: "assets/exercises/overhead_db_press.png",
        difficulty: "Medium",
        duration: "3 sets x 10",
        about: "Overhead vertical press for 3D capped deltoids and triceps.",
        alternatives: [
          ExerciseAlternative(
            title: "ARNOLD PRESS",
            imageUrl:
                "https://images.unsplash.com/photo-1574680096145-d05b474e2155?auto=format&fit=crop&w=600&q=80",
            demoImage: "assets/exercises/arnold_press.png",
            difficulty: "Medium",
            duration: "3 sets x 10",
            about: "Rotational press hitting anterior and lateral delts.",
          ),
          ExerciseAlternative(
            title: "LATERAL RAISES",
            imageUrl:
                "https://images.unsplash.com/photo-1566241134883-13eb2393a3cc?auto=format&fit=crop&w=600&q=80",
            demoImage: "assets/exercises/lateral_raises.png",
            difficulty: "Easy",
            duration: "4 sets x 15",
            about: "Strict side-delt pump creating shoulder width.",
          ),
        ],
      ),
    ],

    // 5: Saturday (HIIT & Conditioning)
    [
      const Exercise(
        title: "ASSAULT BIKE SPRINTS 🔥",
        imageUrl:
            "https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&w=1200&q=80",
        demoImage: "assets/exercises/assault_bike.png",
        difficulty: "Hard",
        duration: "10 mins HIIT",
        about: "All-out metabolic conditioning pushing anaerobic threshold.",
        alternatives: [
          ExerciseAlternative(
            title: "ROWING SPRINTS",
            imageUrl:
                "https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&w=600&q=80",
            demoImage: "assets/exercises/rowing_sprints.png",
            difficulty: "Hard",
            duration: "500m intervals",
            about: "Full posterior-chain cardio power.",
          ),
          ExerciseAlternative(
            title: "SKIERG DRILLS",
            imageUrl:
                "https://images.unsplash.com/photo-1541534741688-6078c6bfb5c5?auto=format&fit=crop&w=600&q=80",
            demoImage: "assets/exercises/skierg_drills.png",
            difficulty: "Medium",
            duration: "8 mins",
            about: "Upper-body hinge cardio burn.",
          ),
        ],
      ),
    ],

    // 6: Sunday (Mobility & Flow)
    [
      const Exercise(
        title: "MOBILITY & RECOVERY 🧘",
        imageUrl:
            "https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&w=1200&q=80",
        demoImage: "assets/exercises/mobility_recovery.png",
        difficulty: "Easy",
        duration: "20 mins",
        about: "Restores joint synovial fluid, thoracic rotation, and hip flexion.",
        alternatives: [
          ExerciseAlternative(
            title: "FOAM ROLLING",
            imageUrl:
                "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?auto=format&fit=crop&w=600&q=80",
            demoImage: "assets/exercises/foam_rolling.png",
            difficulty: "Easy",
            duration: "15 mins",
            about: "Myofascial release for tight quads and lats.",
          ),
          ExerciseAlternative(
            title: "YOGA FLOW",
            imageUrl:
                "https://images.unsplash.com/photo-1575052814086-f385e2e2ad1b?auto=format&fit=crop&w=600&q=80",
            demoImage: "assets/exercises/yoga_flow.png",
            difficulty: "Easy",
            duration: "25 mins",
            about: "Mind-muscle decompression and nervous system calm.",
          ),
        ],
      ),
    ],
  ];
}
