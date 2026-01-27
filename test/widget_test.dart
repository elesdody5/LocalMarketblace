// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:data/di/injection.dart';
import 'package:domain/di/injection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_market_place/main.dart';
import 'package:presentation/di/injection.dart';

void main() {
  testWidgets('App builds smoke test', (WidgetTester tester) async {
    // Initialize DI like production main() does.
    configurePresentationDependencies();
    configureDomainDependencies();
    configureDataDependencies();

    await tester.pumpWidget(const MyApp());

    // Let splash timers / navigations settle to avoid pending timers.
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // If we got here without throwing, the widget tree built successfully.
    expect(find.byType(MyApp), findsOneWidget);
  });
}
