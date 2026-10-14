// lib/screens/workout_session_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../models/app_models.dart';
import '../providers/workout_provider.dart';

class WorkoutSessionScreen extends StatefulWidget {
  final Exercise exercise;

  const WorkoutSessionScreen({super.key, required this.exercise});

  @override
  State<WorkoutSessionScreen> createState() => _WorkoutSessionScreenState();
}

class _WorkoutSessionScreenState extends State<WorkoutSessionScreen> {
  late List<WorkoutSet> _sets;
  late List<TextEditingController> _repsControllers;
  late List<TextEditingController> _weightControllers;

  // Rest Timer State
  int _restSecondsRemaining = 60;
  bool _isTimerRunning = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    final numSets = widget.exercise.defaultSets > 0 ? widget.exercise.defaultSets : 3;
    _sets = List.generate(
      numSets,
      (i) => WorkoutSet(
        setNumber: i + 1,
        reps: 10,
        weight: 0.0,
        isDone: false,
      ),
    );

    _repsControllers = List.generate(
      numSets,
      (i) => TextEditingController(text: '10'),
    );

    _weightControllers = List.generate(
      numSets,
      (i) => TextEditingController(text: '0'),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _repsControllers) {
      c.dispose();
    }
    for (var c in _weightControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _isTimerRunning = true;
      _restSecondsRemaining = 60;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_restSecondsRemaining > 0) {
        setState(() => _restSecondsRemaining--);
      } else {
        timer.cancel();
        setState(() => _isTimerRunning = false);
      }
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isTimerRunning = false;
      _restSecondsRemaining = 60;
    });
  }

  void _finishWorkout() async {
    // Update sets from text controllers
    final completedSets = <WorkoutSet>[];
    for (int i = 0; i < _sets.length; i++) {
      final reps = int.tryParse(_repsControllers[i].text) ?? _sets[i].reps;
      final weight = double.tryParse(_weightControllers[i].text) ?? _sets[i].weight;
      completedSets.add(
        _sets[i].copyWith(
          reps: reps,
          weight: weight,
        ),
      );
    }

    final log = WorkoutLog(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      exerciseId: widget.exercise.id,
      sets: completedSets,
    );

    await context.read<WorkoutProvider>().saveWorkoutLog(log);

    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: AppColors.neonLime),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Great work! Workout logged successfully.',
                  style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.darkSurfaceElevated,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.darkTextPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.exercise.name,
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.darkTextPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Exercise Info Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.darkSurface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.darkBorder),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              widget.exercise.heroImage,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 60,
                                height: 60,
                                color: AppColors.darkSurfaceElevated,
                                child: const Icon(Icons.fitness_center, color: AppColors.neonLime),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.exercise.name,
                                  style: GoogleFonts.manrope(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.darkTextPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${widget.exercise.difficulty} • ${widget.exercise.defaultReps}',
                                  style: GoogleFonts.manrope(
                                    fontSize: 13,
                                    color: AppColors.electricCyan,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Rest Timer Box
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.darkSurfaceElevated,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _isTimerRunning ? AppColors.neonLime : AppColors.darkBorder,
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                color: _isTimerRunning ? AppColors.neonLime : AppColors.darkTextSecondary,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Rest Timer: ${_restSecondsRemaining}s',
                                style: GoogleFonts.manrope(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: _isTimerRunning ? AppColors.neonLime : AppColors.darkTextPrimary,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  _isTimerRunning ? Icons.pause_circle_filled : Icons.play_circle_fill,
                                  color: AppColors.neonLime,
                                  size: 28,
                                ),
                                onPressed: () {
                                  if (_isTimerRunning) {
                                    _timer?.cancel();
                                    setState(() => _isTimerRunning = false);
                                  } else {
                                    _startTimer();
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.refresh_rounded, color: AppColors.darkTextSecondary),
                                onPressed: _resetTimer,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Sets Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          _buildColHeader('SET', flex: 2),
                          _buildColHeader('REPS', flex: 3),
                          _buildColHeader('KG (+)', flex: 3),
                          _buildColHeader('DONE', flex: 2, align: TextAlign.center),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Set Rows
                    ...List.generate(_sets.length, (index) {
                      final s = _sets[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: s.isDone ? AppColors.darkSurfaceElevated : AppColors.darkSurface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: s.isDone ? AppColors.neonLime.withValues(alpha: 0.4) : AppColors.darkBorder,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                '#${s.setNumber}',
                                style: GoogleFonts.manrope(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.darkTextPrimary,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                height: 40,
                                child: TextField(
                                  controller: _repsControllers[index],
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.manrope(
                                    color: AppColors.darkTextPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    filled: true,
                                    fillColor: AppColors.darkBackground,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                height: 40,
                                child: TextField(
                                  controller: _weightControllers[index],
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.manrope(
                                    color: AppColors.darkTextPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    filled: true,
                                    fillColor: AppColors.darkBackground,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _sets[index] = s.copyWith(isDone: !s.isDone);
                                    });
                                    if (!s.isDone) {
                                      _startTimer();
                                    }
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: s.isDone ? AppColors.neonLime : Colors.transparent,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: s.isDone ? AppColors.neonLime : AppColors.darkTextSecondary,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: s.isDone
                                        ? const Icon(Icons.check, size: 20, color: AppColors.textDark)
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 14),

                    // Add Set Button
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          final newSetNum = _sets.length + 1;
                          _sets.add(WorkoutSet(
                            setNumber: newSetNum,
                            reps: 10,
                            weight: 0.0,
                            isDone: false,
                          ));
                          _repsControllers.add(TextEditingController(text: '10'));
                          _weightControllers.add(TextEditingController(text: '0'));
                        });
                      },
                      icon: const Icon(Icons.add, color: AppColors.electricCyan, size: 18),
                      label: Text(
                        'Add Set',
                        style: GoogleFonts.manrope(
                          color: AppColors.electricCyan,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Finish Workout Button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                color: AppColors.darkSurface,
                border: Border(top: BorderSide(color: AppColors.darkBorder)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _finishWorkout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonLime,
                    foregroundColor: AppColors.textDark,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  child: Text(
                    'Finish Workout',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColHeader(String text, {required int flex, TextAlign align = TextAlign.start}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: align,
        style: GoogleFonts.manrope(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: AppColors.darkTextSecondary,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
