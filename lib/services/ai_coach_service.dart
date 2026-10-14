// lib/services/ai_coach_service.dart

import '../data/sample_data.dart';
import '../models/app_models.dart';

/// Abstract service contract for AI workout plan generation.
/// This allows swapping in a real Gemini / LLM backend later with zero changes to the UI.
abstract class AiCoachService {
  Future<WorkoutPlan> generatePlan(
    UserProfile profile,
    List<WorkoutLog> logs,
  );
}

/// Mock implementation that works offline without an API key.
class MockAiCoachService implements AiCoachService {
  @override
  Future<WorkoutPlan> generatePlan(
    UserProfile profile,
    List<WorkoutLog> logs,
  ) async {
    // Simulate slight network latency
    await Future.delayed(const Duration(milliseconds: 300));
    return SampleData.sampleWeeklyPlan;
  }
}
