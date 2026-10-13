import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liftly/core/theme/app_theme.dart';
import 'package:liftly/features/home/home_screen.dart';
import 'package:liftly/features/home/widgets/bottom_nav_bar.dart';
import 'package:liftly/features/home/widgets/greeting_section.dart';
import 'package:liftly/features/home/widgets/hero_workout_card.dart';
import 'package:liftly/features/home/widgets/top_bar.dart';
import 'package:liftly/features/home/widgets/weekday_selector.dart';
import 'package:liftly/main.dart';

void main() {
  group('Liftly Home Screen - Samsung Galaxy S24+ & Multi-Device Tests', () {
    testWidgets(
        '1. Samsung Galaxy S24+ (412 x 915) reference viewport verification',
        (WidgetTester tester) async {
      // Configure exact Samsung Galaxy S24+ reference viewport: 412 x 915 CSS px
      tester.view.physicalSize = const Size(412 * 2.625, 915 * 2.625);
      tester.view.devicePixelRatio = 2.625;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const LiftlyApp());
      await tester.pumpAndSettle();

      // 1. Verify HomeScreen renders without layout overflow errors
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(tester.takeException(), isNull);

      // 2. Verify Header elements:
      // Menu button present
      expect(find.byIcon(Icons.menu_rounded), findsOneWidget);
      // Liftly handwritten logo present
      expect(find.byType(LiftlyLogo), findsOneWidget);
      expect(find.text('Liftly'), findsOneWidget);
      // Theme toggle present
      expect(find.byKey(const Key('theme_toggle_button')), findsOneWidget);
      // Timer and Notification icons MUST NOT be present
      expect(find.byIcon(Icons.timer_outlined), findsNothing);
      expect(find.byIcon(Icons.notifications_none_rounded), findsNothing);

      // 3. Verify Personalized Greeting
      expect(find.byType(GreetingSection), findsOneWidget);
      expect(find.textContaining('Gagan'), findsOneWidget);
      expect(find.text('Small steps. Big changes.'), findsOneWidget);

      // 4. Verify Weekday Selector has all 7 days
      expect(find.byType(WeekdaySelector), findsOneWidget);
      expect(find.text('Mon'), findsOneWidget);
      expect(find.text('Tue'), findsOneWidget);
      expect(find.text('Wed'), findsOneWidget);
      expect(find.text('Thu'), findsOneWidget);
      expect(find.text('Fri'), findsOneWidget);
      expect(find.text('Sat'), findsOneWidget);
      expect(find.text('Sun'), findsOneWidget);

      // 5. Select Monday and verify Monday workout card details
      await tester.tap(find.text('Mon'));
      await tester.pumpAndSettle();

      expect(find.byType(HeroWorkoutCard), findsOneWidget);
      expect(find.text("TODAY'S WORKOUT"), findsOneWidget);
      expect(find.text('MON, APR 28'), findsOneWidget);
      expect(find.text('FOREARM PLANKS 🔥'), findsOneWidget);
      expect(find.textContaining('Difficulty: Medium'), findsOneWidget);
      expect(find.textContaining('Duration: 1 min'), findsOneWidget);

      // 6. Verify Demo Image panel and Next arrow button exist
      final nextArrow = find.byKey(const Key('next_exercise_button'));
      expect(nextArrow, findsOneWidget);

      // 7. Verify Start Workout CTA button is visible, tappable, and at least 48px high
      final startButtonFinder = find.byKey(const Key('start_workout_button'));
      expect(startButtonFinder, findsOneWidget);
      final startButtonSize = tester.getSize(startButtonFinder);
      expect(startButtonSize.height, greaterThanOrEqualTo(48.0));
      expect(find.text('Start Workout'), findsOneWidget);

      // 8. Verify About and Alternative panels
      expect(find.text('ABOUT:'), findsOneWidget);
      expect(find.textContaining('Engages your entire core, shoulders, and glutes.'),
          findsOneWidget);
      expect(find.text('ALTERNATIVE:'), findsOneWidget);
      expect(find.textContaining('Knee Planks, High Planks'), findsOneWidget);

      // 9. Verify Bottom Navigation is visible with 4 items & outline icons
      expect(find.byType(LiftlyBottomNavBar), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Schedule'), findsOneWidget);
      expect(find.text('Progress'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('2. Workout interactions: Start Workout, Alternative Swap & Next',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(412 * 2.0, 915 * 2.0);
      tester.view.devicePixelRatio = 2.0;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const LiftlyApp());
      await tester.pumpAndSettle();

      // Ensure Monday is selected
      await tester.tap(find.text('Mon'));
      await tester.pumpAndSettle();
      expect(find.text('FOREARM PLANKS 🔥'), findsOneWidget);

      // A. Test Alternative swap to KNEE PLANKS
      final kneePlankThumb =
          find.byKey(const ValueKey('alt_KNEE PLANKS'));
      expect(kneePlankThumb, findsOneWidget);
      await tester.ensureVisible(kneePlankThumb);
      await tester.pumpAndSettle();
      await tester.tap(kneePlankThumb);
      await tester.pumpAndSettle();

      // Verify title updated
      expect(find.text('KNEE PLANKS 🔥'), findsOneWidget);

      // B. Test Next exercise arrow
      final nextArrow = find.byKey(const Key('next_exercise_button'));
      expect(nextArrow, findsOneWidget);
      await tester.ensureVisible(nextArrow);
      await tester.pumpAndSettle();
      await tester.tap(nextArrow);
      await tester.pumpAndSettle();

      // Monday next exercise is Russian Twists
      expect(find.text('RUSSIAN TWISTS ⚡'), findsOneWidget);

      // C. Test Start Workout Button
      final startBtn = find.byKey(const Key('start_workout_button'));
      await tester.ensureVisible(startBtn);
      await tester.pumpAndSettle();
      await tester.tap(startBtn);
      await tester.pumpAndSettle();

      // Verify Workout Session Bottom Sheet opens
      expect(find.text('SESSION ACTIVE'), findsOneWidget);
      expect(find.text('Complete Exercise'), findsOneWidget);

      // Close session
      await tester.tap(find.text('Complete Exercise'));
      await tester.pumpAndSettle();
      expect(find.text('SESSION ACTIVE'), findsNothing);
    });

    testWidgets('3. Theme toggle: dark to light and back to dark',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(412 * 2.0, 915 * 2.0);
      tester.view.devicePixelRatio = 2.0;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const LiftlyApp());
      await tester.pumpAndSettle();

      // Default theme is dark
      expect(themeModeNotifier.value, ThemeMode.dark);
      expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);

      // Tap theme toggle to switch to light mode
      await tester.tap(find.byKey(const Key('theme_toggle_button')));
      await tester.pumpAndSettle();

      expect(themeModeNotifier.value, ThemeMode.light);
      expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);

      // Tap again to switch back to dark mode
      await tester.tap(find.byKey(const Key('theme_toggle_button')));
      await tester.pumpAndSettle();

      expect(themeModeNotifier.value, ThemeMode.dark);
      expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
    });

    testWidgets('4. Small Android Phone (360 x 800) responsive viewport test',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(360 * 2.0, 800 * 2.0);
      tester.view.devicePixelRatio = 2.0;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const LiftlyApp());
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(LiftlyBottomNavBar), findsOneWidget);

      // Verify Start Workout button is accessible
      expect(find.byKey(const Key('start_workout_button')), findsOneWidget);
    });

    testWidgets('5. Compact Modern Phone (384 x 854) responsive test',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(384 * 2.0, 854 * 2.0);
      tester.view.devicePixelRatio = 2.0;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const LiftlyApp());
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(WeekdaySelector), findsOneWidget);
      expect(find.byType(HeroWorkoutCard), findsOneWidget);
    });

    testWidgets('6. Shorter Mobile Viewport (412 x 892) responsive test',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(412 * 2.0, 892 * 2.0);
      tester.view.devicePixelRatio = 2.0;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const LiftlyApp());
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(HeroWorkoutCard), findsOneWidget);
    });

    testWidgets('7. Desktop Browser Viewport (1024 x 768) responsive test',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const LiftlyApp());
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(HeroWorkoutCard), findsOneWidget);
      expect(find.byType(LiftlyBottomNavBar), findsOneWidget);
    });
  });
}
