// lib/providers/workout_provider.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/sample_data.dart';
import '../models/app_models.dart';
import '../services/ai_coach_service.dart';

class WorkoutProvider extends ChangeNotifier {
  static const String _logsKey = 'liftly_workout_logs';
  final AiCoachService _aiService;

  int _selectedDayIndex = 0;
  int _currentExerciseIndex = 0;
  WorkoutPlan _currentPlan = SampleData.sampleWeeklyPlan;
  final List<WorkoutLog> _workoutLogs = [];
  bool _isLoading = false;

  int get selectedDayIndex => _selectedDayIndex;
  int get currentExerciseIndex => _currentExerciseIndex;
  WorkoutPlan get currentPlan => _currentPlan;
  List<WorkoutLog> get workoutLogs => List.unmodifiable(_workoutLogs);
  bool get isLoading => _isLoading;

  WorkoutProvider({AiCoachService? aiService})
      : _aiService = aiService ?? MockAiCoachService() {
    _initDayToToday();
    _loadLogs();
  }

  void _initDayToToday() {
    // DateTime.monday is 1, sunday is 7 -> convert to 0-indexed (0 = Mon, 6 = Sun)
    final now = DateTime.now();
    _selectedDayIndex = (now.weekday - 1).clamp(0, 6);
  }

  Future<void> _loadLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_logsKey);
    if (jsonList != null) {
      _workoutLogs.clear();
      for (final item in jsonList) {
        try {
          _workoutLogs.add(WorkoutLog.fromJson(jsonDecode(item)));
        } catch (e) {
          debugPrint('Error parsing workout log: $e');
        }
      }
      notifyListeners();
    }
  }

  Future<void> refreshPlan(UserProfile profile) async {
    _isLoading = true;
    notifyListeners();
    try {
      _currentPlan = await _aiService.generatePlan(profile, _workoutLogs);
    } catch (e) {
      debugPrint('Error generating workout plan: $e');
      _currentPlan = SampleData.sampleWeeklyPlan;
    } finally {
      _isLoading = false;
      _currentExerciseIndex = 0;
      notifyListeners();
    }
  }

  void selectDay(int index) {
    if (index >= 0 && index <= 6) {
      _selectedDayIndex = index;
      _currentExerciseIndex = 0;
      notifyListeners();
    }
  }

  List<Exercise> get exercisesForSelectedDay {
    return _currentPlan.weeklySchedule[_selectedDayIndex] ?? [];
  }

  Exercise? get currentExercise {
    final exercises = exercisesForSelectedDay;
    if (exercises.isEmpty) return null;
    if (_currentExerciseIndex >= exercises.length) {
      _currentExerciseIndex = 0;
    }
    return exercises[_currentExerciseIndex];
  }

  void cycleNextExercise() {
    final exercises = exercisesForSelectedDay;
    if (exercises.isEmpty) return;
    _currentExerciseIndex = (_currentExerciseIndex + 1) % exercises.length;
    notifyListeners();
  }

  void swapCurrentExercise(Exercise newExercise) {
    final exercises = exercisesForSelectedDay;
    if (exercises.isEmpty) return;
    
    // Replace current exercise with the chosen alternative in the schedule
    final updatedList = List<Exercise>.from(exercises);
    updatedList[_currentExerciseIndex] = newExercise;
    
    final updatedSchedule = Map<int, List<Exercise>>.from(_currentPlan.weeklySchedule);
    updatedSchedule[_selectedDayIndex] = updatedList;

    _currentPlan = WorkoutPlan(
      id: _currentPlan.id,
      weeklySchedule: updatedSchedule,
    );
    notifyListeners();
  }

  Future<void> saveWorkoutLog(WorkoutLog log) async {
    _workoutLogs.add(log);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _workoutLogs.map((l) => jsonEncode(l.toJson())).toList();
    await prefs.setStringList(_logsKey, jsonList);
  }
}
