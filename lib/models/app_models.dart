// lib/models/app_models.dart

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

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'demoImage': demoImage,
      'difficulty': difficulty,
      'duration': duration,
      'about': about,
    };
  }

  factory ExerciseAlternative.fromJson(Map<String, dynamic> json) {
    return ExerciseAlternative(
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      demoImage: (json['demoImage'] as String?) ?? '',
      difficulty: json['difficulty'] as String,
      duration: json['duration'] as String,
      about: json['about'] as String,
    );
  }
}

class Exercise {
  final String id;
  final String name;
  final String description;
  final String difficulty;
  final int defaultSets;
  final String defaultReps;
  final String heroImage;
  final String demoImage;
  final List<String> alternativeIds;
  final List<ExerciseAlternative> alternatives;

  const Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.difficulty,
    this.defaultSets = 3,
    this.defaultReps = '1 min',
    required this.heroImage,
    this.demoImage = '',
    this.alternativeIds = const [],
    this.alternatives = const [],
  });

  // Backward compatibility getters for UI widgets
  String get title => name;
  String get about => description;
  String get imageUrl => heroImage;
  String get duration => defaultReps;

  Exercise copyWith({
    String? id,
    String? name,
    String? description,
    String? difficulty,
    int? defaultSets,
    String? defaultReps,
    String? heroImage,
    String? demoImage,
    List<String>? alternativeIds,
    List<ExerciseAlternative>? alternatives,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      difficulty: difficulty ?? this.difficulty,
      defaultSets: defaultSets ?? this.defaultSets,
      defaultReps: defaultReps ?? this.defaultReps,
      heroImage: heroImage ?? this.heroImage,
      demoImage: demoImage ?? this.demoImage,
      alternativeIds: alternativeIds ?? this.alternativeIds,
      alternatives: alternatives ?? this.alternatives,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'difficulty': difficulty,
      'defaultSets': defaultSets,
      'defaultReps': defaultReps,
      'heroImage': heroImage,
      'demoImage': demoImage,
      'alternativeIds': alternativeIds,
      'alternatives': alternatives.map((a) => a.toJson()).toList(),
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      difficulty: json['difficulty'] as String,
      defaultSets: (json['defaultSets'] as int?) ?? 3,
      defaultReps: (json['defaultReps'] as String?) ?? '1 min',
      heroImage: json['heroImage'] as String,
      demoImage: (json['demoImage'] as String?) ?? '',
      alternativeIds: json['alternativeIds'] != null
          ? List<String>.from(json['alternativeIds'] as List)
          : const [],
      alternatives: json['alternatives'] != null
          ? (json['alternatives'] as List)
              .map((a) => ExerciseAlternative.fromJson(a as Map<String, dynamic>))
              .toList()
          : const [],
    );
  }
}

class WorkoutPlan {
  final String id;
  final Map<int, List<Exercise>> weeklySchedule;

  const WorkoutPlan({
    required this.id,
    required this.weeklySchedule,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weeklySchedule': weeklySchedule.map(
        (key, value) => MapEntry(key.toString(), value.map((e) => e.toJson()).toList()),
      ),
    };
  }

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) {
    final raw = json['weeklySchedule'] as Map<String, dynamic>;
    return WorkoutPlan(
      id: json['id'] as String,
      weeklySchedule: raw.map(
        (key, value) => MapEntry(
          int.parse(key),
          (value as List<dynamic>)
              .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      ),
    );
  }
}

class UserProfile {
  final String name;
  final String goal;
  final String experienceLevel;
  final String equipment;
  final int daysPerWeek;
  final String limitations;

  const UserProfile({
    required this.name,
    required this.goal,
    required this.experienceLevel,
    required this.equipment,
    required this.daysPerWeek,
    required this.limitations,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'goal': goal,
      'experienceLevel': experienceLevel,
      'equipment': equipment,
      'daysPerWeek': daysPerWeek,
      'limitations': limitations,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] as String,
      goal: json['goal'] as String,
      experienceLevel: json['experienceLevel'] as String,
      equipment: json['equipment'] as String,
      daysPerWeek: json['daysPerWeek'] as int,
      limitations: (json['limitations'] as String?) ?? '',
    );
  }
}

class WorkoutSet {
  final int setNumber;
  final int reps;
  final double weight;
  final bool isDone;

  const WorkoutSet({
    required this.setNumber,
    required this.reps,
    required this.weight,
    required this.isDone,
  });

  WorkoutSet copyWith({
    int? setNumber,
    int? reps,
    double? weight,
    bool? isDone,
  }) {
    return WorkoutSet(
      setNumber: setNumber ?? this.setNumber,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'setNumber': setNumber,
      'reps': reps,
      'weight': weight,
      'isDone': isDone,
    };
  }

  factory WorkoutSet.fromJson(Map<String, dynamic> json) {
    return WorkoutSet(
      setNumber: json['setNumber'] as int,
      reps: json['reps'] as int,
      weight: (json['weight'] as num).toDouble(),
      isDone: json['isDone'] as bool,
    );
  }
}

class WorkoutLog {
  final String id;
  final DateTime date;
  final String exerciseId;
  final List<WorkoutSet> sets;

  const WorkoutLog({
    required this.id,
    required this.date,
    required this.exerciseId,
    required this.sets,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'exerciseId': exerciseId,
      'sets': sets.map((s) => s.toJson()).toList(),
    };
  }

  factory WorkoutLog.fromJson(Map<String, dynamic> json) {
    return WorkoutLog(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      exerciseId: json['exerciseId'] as String,
      sets: (json['sets'] as List<dynamic>)
          .map((s) => WorkoutSet.fromJson(s as Map<String, dynamic>))
          .toList(),
    );
  }
}
