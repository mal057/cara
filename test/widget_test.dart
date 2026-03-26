import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sola/app.dart';

void main() {
  testWidgets('SolaApp renders without errors', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: SolaApp()),
    );
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}