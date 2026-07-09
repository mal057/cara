import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cara/app.dart';

void main() {
  testWidgets('CaraApp renders without errors', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: CaraApp()),
    );
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}