// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:cara/core/constants/app_colors.dart';
import 'package:cara/data/database/app_database.dart';
import 'package:cara/data/database/daos/cycle_dao.dart';
import 'package:cara/data/database/daos/settings_dao.dart';
import 'package:cara/features/onboarding/screens/cycle_setup_screen.dart';
import 'package:cara/providers/auth_providers.dart';
import 'package:cara/providers/database_provider.dart';

// ---------------------------------------------------------------------------
// Fake DAOs
// ---------------------------------------------------------------------------

class FakeCycleDao extends Fake implements CycleDao {
  int insertCallCount = 0;
  CyclesTableCompanion? lastInserted;
  Exception? throwOn;

  @override
  Future<int> insertCycle(CyclesTableCompanion cycle) async {
    insertCallCount++;
    lastInserted = cycle;
    if (throwOn != null) throw throwOn!;
    return 1;
  }
}

class FakeSettingsDao extends Fake implements SettingsDao {
  final Map<String, String> stored = {};
  Exception? throwOn;

  @override
  Future<void> setSetting(String key, String value) async {
    if (throwOn != null) throw throwOn!;
    stored[key] = value;
  }
}

class FakeAppDatabase extends Fake implements AppDatabase {}

// ---------------------------------------------------------------------------
// Stub AuthStateNotifier — completeOnboarding() is a no-op for tests.
// ---------------------------------------------------------------------------

class StubAuthNotifier extends AuthStateNotifier {
  StubAuthNotifier(super.authService);

  @override
  void completeOnboarding() {
    // Intentionally empty for tests.
  }
}

// ---------------------------------------------------------------------------
// Helper: builds the widget under test with GoRouter + ProviderScope.
// GoRouter is required because CycleSetupScreen calls context.go() after save.
// ---------------------------------------------------------------------------

Widget buildSubject({
  required FakeCycleDao fakeCycleDao,
  required FakeSettingsDao fakeSettingsDao,
  required FakeAppDatabase fakeDb,
}) {
  final router = GoRouter(
    initialLocation: '/cycle-setup',
    routes: [
      GoRoute(
        path: '/cycle-setup',
        builder: (context, state) => const CycleSetupScreen(),
      ),
      // Stub destination routes so context.go() doesn't throw.
      GoRoute(
        path: '/calendar',
        builder: (context, state) => const Scaffold(body: Text('Calendar')),
      ),
      GoRoute(
        path: '/onboarding/biometric',
        builder: (context, state) =>
            const Scaffold(body: Text('Biometric Setup')),
      ),
    ],
  );

  return ProviderScope(
    overrides: [
      // Override databaseProvider build so .future resolves immediately.
      databaseProvider.overrideWithBuild((ref, notifier) async => fakeDb),
      // Override DAO providers with in-memory fakes.
      cycleDaoProvider.overrideWithValue(fakeCycleDao),
      settingsDaoProvider.overrideWithValue(fakeSettingsDao),
      // Override auth so completeOnboarding() is a no-op.
      authStateProvider.overrideWith(
        (ref) => StubAuthNotifier(ref.read(authServiceProvider)),
      ),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

// ---------------------------------------------------------------------------
// Helper: scroll to widget then tap it (handles off-screen widgets).
// ---------------------------------------------------------------------------

Future<void> scrollToAndTap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  late FakeCycleDao fakeCycleDao;
  late FakeSettingsDao fakeSettingsDao;
  late FakeAppDatabase fakeDb;

  setUp(() {
    fakeCycleDao = FakeCycleDao();
    fakeSettingsDao = FakeSettingsDao();
    fakeDb = FakeAppDatabase();
  });

  // -------------------------------------------------------------------------
  // Test 1: Subtitle text color must be textPrimary (the bug fix we validate)
  // -------------------------------------------------------------------------
  testWidgets('subtitle uses textPrimary color, not textSecondary',
      (tester) async {
    await tester.pumpWidget(buildSubject(
      fakeCycleDao: fakeCycleDao,
      fakeSettingsDao: fakeSettingsDao,
      fakeDb: fakeDb,
    ));
    await tester.pumpAndSettle();

    const subtitleText =
        'This helps Cara give you more accurate predictions. All fields are optional.';

    final subtitleFinder = find.text(subtitleText);
    expect(subtitleFinder, findsOneWidget,
        reason: 'Subtitle text must be present on screen');

    final textWidget = tester.widget<Text>(subtitleFinder);
    final color = textWidget.style?.color;

    expect(
      color,
      equals(AppColors.textPrimary),
      reason: 'Subtitle color must be AppColors.textPrimary (0xFF2D2540). '
          'Changed from textSecondary to textPrimary for visibility.',
    );

    expect(
      color,
      isNot(equals(AppColors.textSecondary)),
      reason: 'Subtitle must NOT use textSecondary (0xFF8A8199)',
    );

    print('PASS Test 1: subtitle color = $color '
        '(textPrimary=${AppColors.textPrimary})');
  });

  // -------------------------------------------------------------------------
  // Test 2: "Save and Continue" calls insertCycle + setSetting, no error
  // This also validates the async DB fix (databaseProvider.future).
  // -------------------------------------------------------------------------
  testWidgets(
      '"Save and Continue" calls insertCycle + setSetting, no error message',
      (tester) async {
    await tester.pumpWidget(buildSubject(
      fakeCycleDao: fakeCycleDao,
      fakeSettingsDao: fakeSettingsDao,
      fakeDb: fakeDb,
    ));
    await tester.pumpAndSettle();

    final saveBtn = find.text('Save and Continue');
    expect(saveBtn, findsOneWidget, reason: '"Save and Continue" button must exist');

    // Scroll to button in case it is below the fold.
    await scrollToAndTap(tester, saveBtn);

    // Use pump with duration rather than pumpAndSettle to avoid confetti
    // animation timeout (confetti uses AnimationController.repeat()).
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));

    expect(fakeCycleDao.insertCallCount, equals(1),
        reason: 'insertCycle must be called exactly once on Save');

    expect(fakeSettingsDao.stored.containsKey('default_cycle_length'), isTrue,
        reason: 'default_cycle_length must be saved');
    expect(fakeSettingsDao.stored.containsKey('default_period_length'), isTrue,
        reason: 'default_period_length must be saved');

    // Critical: no error message visible.
    expect(
      find.text('Could not save your cycle data. You can set this up later in Settings.'),
      findsNothing,
      reason: 'Error message must NOT appear on successful save',
    );

    print('PASS Test 2: insertCycle=${fakeCycleDao.insertCallCount}, '
        'settings=${fakeSettingsDao.stored}, no error shown');
  });

  // -------------------------------------------------------------------------
  // Test 3: DB error shows error message (regression guard)
  // -------------------------------------------------------------------------
  testWidgets('shows error message when insertCycle throws', (tester) async {
    fakeCycleDao.throwOn = Exception('Simulated DB error');

    await tester.pumpWidget(buildSubject(
      fakeCycleDao: fakeCycleDao,
      fakeSettingsDao: fakeSettingsDao,
      fakeDb: fakeDb,
    ));
    await tester.pumpAndSettle();

    await scrollToAndTap(tester, find.text('Save and Continue'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(
      find.text('Could not save your cycle data. You can set this up later in Settings.'),
      findsOneWidget,
      reason: 'Error message must appear when insertCycle throws',
    );

    print('PASS Test 3: error message shown on DB failure');
  });

  // -------------------------------------------------------------------------
  // Test 4: Skip does NOT call insertCycle or setSetting
  // -------------------------------------------------------------------------
  testWidgets('"Skip for now" does not persist any data', (tester) async {
    await tester.pumpWidget(buildSubject(
      fakeCycleDao: fakeCycleDao,
      fakeSettingsDao: fakeSettingsDao,
      fakeDb: fakeDb,
    ));
    await tester.pumpAndSettle();

    await scrollToAndTap(tester, find.text('Skip for now'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));

    expect(fakeCycleDao.insertCallCount, equals(0),
        reason: 'Skip must NOT call insertCycle');
    expect(fakeSettingsDao.stored.isEmpty, isTrue,
        reason: 'Skip must NOT write any settings');

    print('PASS Test 4: Skip does not touch the database');
  });

  // -------------------------------------------------------------------------
  // Test 5: Screen renders all required UI elements
  // -------------------------------------------------------------------------
  testWidgets('screen renders required UI elements', (tester) async {
    await tester.pumpWidget(buildSubject(
      fakeCycleDao: fakeCycleDao,
      fakeSettingsDao: fakeSettingsDao,
      fakeDb: fakeDb,
    ));
    await tester.pumpAndSettle();

    expect(find.text('Set up your cycle'), findsOneWidget,
        reason: 'Heading must be visible');

    expect(
      find.text('This helps Cara give you more accurate predictions. All fields are optional.'),
      findsOneWidget,
      reason: 'Subtitle must be visible',
    );

    expect(
      find.text('When did your last period start?'),
      findsOneWidget,
      reason: 'Date picker label must be visible',
    );

    expect(find.text('Save and Continue'), findsOneWidget,
        reason: 'Save button must exist');
    expect(find.text('Skip for now'), findsOneWidget,
        reason: 'Skip button must exist');

    print('PASS Test 5: all required UI elements present');
  });
}
