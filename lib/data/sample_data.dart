// lib/data/sample_data.dart

import '../models/app_models.dart';

class SampleData {
  static const Exercise planks = Exercise(
    id: 'planks',
    name: 'FOREARM PLANKS 🔥',
    description: 'Engages your entire core, shoulders, and glutes.',
    difficulty: 'Medium',
    defaultSets: 3,
    defaultReps: '1 min',
    heroImage: 'https://images.unsplash.com/photo-1566241134883-13eb2393a3cc?auto=format&fit=crop&w=1200&q=80',
    demoImage: 'assets/exercises/forearm_plank.png',
    alternativeIds: ['knee_planks', 'high_planks'],
    alternatives: [
      ExerciseAlternative(
        title: 'KNEE PLANKS',
        imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?auto=format&fit=crop&w=600&q=80',
        demoImage: 'assets/exercises/knee_plank.png',
        difficulty: 'Easy',
        duration: '45 sec',
        about: 'Gentle core activation with reduced lower-back torque.',
      ),
      ExerciseAlternative(
        title: 'HIGH PLANKS',
        imageUrl: 'https://images.unsplash.com/photo-1598971639058-fab3c3109a00?auto=format&fit=crop&w=600&q=80',
        demoImage: 'assets/exercises/high_plank.png',
        difficulty: 'Medium',
        duration: '1 min',
        about: 'Full arm extension strengthening wrists and deltoids.',
      ),
    ],
  );

  static const Exercise russianTwists = Exercise(
    id: 'russian_twists',
    name: 'RUSSIAN TWISTS ⚡',
    description: 'Torques rotational obliques and builds deep anti-shear control.',
    difficulty: 'Hard',
    defaultSets: 3,
    defaultReps: '45 sec',
    heroImage: 'https://images.unsplash.com/photo-1541534741688-6078c6bfb5c5?auto=format&fit=crop&w=1200&q=80',
    demoImage: 'assets/exercises/russian_twist.png',
    alternativeIds: [],
    alternatives: [
      ExerciseAlternative(
        title: 'HEEL TAPS',
        imageUrl: 'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&w=600&q=80',
        demoImage: 'assets/exercises/heel_taps.png',
        difficulty: 'Easy',
        duration: '40 sec',
        about: 'Controlled lateral oblique touches on the mat.',
      ),
      ExerciseAlternative(
        title: 'BICYCLE CRUNCHES',
        imageUrl: 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&w=600&q=80',
        demoImage: 'assets/exercises/bicycle_crunches.png',
        difficulty: 'Medium',
        duration: '1 min',
        about: 'Dynamic cross-body contraction firing rectus abdominis.',
      ),
    ],
  );

  static const Exercise hangingLegRaises = Exercise(
    id: 'hanging_leg_raises',
    name: 'HANGING LEG RAISES 🎯',
    description: 'Heavy lower-abdominal contraction with grip-strength conditioning.',
    difficulty: 'Hard',
    defaultSets: 3,
    defaultReps: '10-12',
    heroImage: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&w=1200&q=80',
    demoImage: 'assets/exercises/hanging_leg_raise.png',
    alternativeIds: [],
    alternatives: [
      ExerciseAlternative(
        title: 'LYING LEG RAISES',
        imageUrl: 'https://images.unsplash.com/photo-1575052814086-f385e2e2ad1b?auto=format&fit=crop&w=600&q=80',
        demoImage: 'assets/exercises/lying_leg_raise.png',
        difficulty: 'Medium',
        duration: '1 min',
        about: 'Grounded pelvic tilt protecting the spine.',
      ),
      ExerciseAlternative(
        title: 'CAPTAIN\'S CHAIR',
        imageUrl: 'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?auto=format&fit=crop&w=600&q=80',
        demoImage: 'assets/exercises/captains_chair.png',
        difficulty: 'Medium',
        duration: '1 min',
        about: 'Forearm-supported knee drive isolating the lower core.',
      ),
    ],
  );

  static const Exercise inclineDbPress = Exercise(
    id: 'incline_db_press',
    name: 'INCLINE DB PRESS ⚡',
    description: 'Targets upper clavicular head of the pectoralis major.',
    difficulty: 'Hard',
    defaultSets: 4,
    defaultReps: '10-12',
    heroImage: 'https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?auto=format&fit=crop&w=1200&q=80',
    demoImage: 'assets/exercises/incline_db_press.png',
    alternativeIds: [],
    alternatives: [
      ExerciseAlternative(
        title: 'FLAT BENCH PRESS',
        imageUrl: 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&w=600&q=80',
        demoImage: 'assets/exercises/flat_bench_press.png',
        difficulty: 'Hard',
        duration: '3 sets x 8',
        about: 'Maximal mechanical tension for mid-chest thickness.',
      ),
      ExerciseAlternative(
        title: 'PUSH-UPS',
        imageUrl: 'https://images.unsplash.com/photo-1598971639058-fab3c3109a00?auto=format&fit=crop&w=600&q=80',
        demoImage: 'assets/exercises/push_ups.png',
        difficulty: 'Easy',
        duration: '3 sets x 15',
        about: 'Bodyweight foundation developing scapular control.',
      ),
    ],
  );

  static const Exercise overheadPress = Exercise(
    id: 'overhead_press',
    name: 'OVERHEAD PRESS 💥',
    description: 'Heavy vertical push building deltoid strength and core brace.',
    difficulty: 'Hard',
    defaultSets: 3,
    defaultReps: '8-10',
    heroImage: 'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?auto=format&fit=crop&w=1200&q=80',
    demoImage: 'assets/exercises/overhead_press.png',
    alternativeIds: [],
    alternatives: [
      ExerciseAlternative(
        title: 'DUMBBELL SHOULDER PRESS',
        imageUrl: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&w=600&q=80',
        demoImage: '',
        difficulty: 'Medium',
        duration: '3 sets x 10',
        about: 'Allows freer wrist and shoulder rotation.',
      ),
    ],
  );

  static const Exercise latPulldown = Exercise(
    id: 'lat_pulldown',
    name: 'LAT PULLDOWN 🦅',
    description: 'Builds back width and activates latissimus dorsi and rhomboids.',
    difficulty: 'Medium',
    defaultSets: 4,
    defaultReps: '10-12',
    heroImage: 'https://images.unsplash.com/photo-1605296867304-46d5465a13f1?auto=format&fit=crop&w=1200&q=80',
    demoImage: 'assets/exercises/lat_pulldown.png',
    alternativeIds: [],
    alternatives: [
      ExerciseAlternative(
        title: 'PULL-UPS',
        imageUrl: 'https://images.unsplash.com/photo-1598971639058-fab3c3109a00?auto=format&fit=crop&w=600&q=80',
        demoImage: '',
        difficulty: 'Hard',
        duration: '3 sets x 8',
        about: 'Bodyweight vertical pull for lat and bicep recruitment.',
      ),
    ],
  );

  static const Exercise barbellSquat = Exercise(
    id: 'barbell_squat',
    name: 'BARBELL BACK SQUAT 🚀',
    description: 'King of lower-body compounds maximizing quad and glute hypertrophy.',
    difficulty: 'Hard',
    defaultSets: 4,
    defaultReps: '8-10',
    heroImage: 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?auto=format&fit=crop&w=1200&q=80',
    demoImage: 'assets/exercises/barbell_squat.png',
    alternativeIds: [],
    alternatives: [
      ExerciseAlternative(
        title: 'GOBLET SQUAT',
        imageUrl: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&w=600&q=80',
        demoImage: 'assets/exercises/goblet_squat.png',
        difficulty: 'Easy',
        duration: '3 sets x 12',
        about: 'Front-loaded kettlebell squat reducing spinal compression.',
      ),
    ],
  );

  static const Exercise romanianDeadlift = Exercise(
    id: 'romanian_deadlift',
    name: 'ROMANIAN DEADLIFT 🍑',
    description: 'Hinges posterior chain stressing hamstrings and glutes.',
    difficulty: 'Hard',
    defaultSets: 3,
    defaultReps: '10-12',
    heroImage: 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&w=1200&q=80',
    demoImage: '',
    alternativeIds: [],
    alternatives: [],
  );

  static const Exercise mobilityFlow = Exercise(
    id: 'mobility_flow',
    name: 'RECOVERY MOBILITY FLOW 🧘',
    description: 'Full-body thoracic rotation, hip opening, and joint decompression.',
    difficulty: 'Easy',
    defaultSets: 2,
    defaultReps: '15 min',
    heroImage: 'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&w=1200&q=80',
    demoImage: '',
    alternativeIds: [],
    alternatives: [],
  );

  static const WorkoutPlan sampleWeeklyPlan = WorkoutPlan(
    id: 'samplePlan',
    weeklySchedule: {
      0: [planks, russianTwists, hangingLegRaises], // Monday (Core & Stability)
      1: [inclineDbPress, overheadPress],           // Tuesday (Push)
      2: [latPulldown],                             // Wednesday (Pull)
      3: [barbellSquat, romanianDeadlift],          // Thursday (Legs)
      4: [inclineDbPress, latPulldown],             // Friday (Upper)
      5: [barbellSquat, planks],                    // Saturday (Conditioning)
      6: [mobilityFlow],                            // Sunday (Active Recovery)
    },
  );
}
