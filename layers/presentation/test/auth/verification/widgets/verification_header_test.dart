import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:domain/auth/usecase/verification_usecase.dart';
import 'package:presentation/auth/verification/widgets/verification_header.dart';

void main() {
  setUp(() {
    Get.testMode = true;
  });

  tearDown(() {
    Get.reset();
  });

  Widget createWidget({
    required VerificationType verificationType,
    required String maskedContact,
  }) {
    return GetMaterialApp(
      home: Scaffold(
        body: VerificationHeader(
          primaryColor: Colors.blue,
          primaryShadow: Colors.blue.withOpacity(0.2),
          onSurfaceColor: Colors.black,
          onSurfaceMuted: Colors.grey,
          textTheme: const TextTheme(),
          maskedContact: maskedContact,
          verificationType: verificationType,
          isDark: false,
        ),
      ),
    );
  }

  group('VerificationHeader Widget', () {
    testWidgets('should display SMS icon when phone type is active',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(
        verificationType: VerificationType.phone,
        maskedContact: '***-***-1234',
      ));

      expect(find.byIcon(Icons.sms), findsOneWidget);
      expect(find.byIcon(Icons.mail_outline), findsNothing);
    });

    testWidgets('should display mail icon when email type is active',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(
        verificationType: VerificationType.email,
        maskedContact: 't***@example.com',
      ));

      expect(find.byIcon(Icons.mail_outline), findsOneWidget);
      expect(find.byIcon(Icons.sms), findsNothing);
    });

    testWidgets('should display masked phone number',
        (WidgetTester tester) async {
      const maskedPhone = '***-***-1234';
      await tester.pumpWidget(createWidget(
        verificationType: VerificationType.phone,
        maskedContact: maskedPhone,
      ));

      expect(find.text(maskedPhone), findsOneWidget);
    });

    testWidgets('should display masked email',
        (WidgetTester tester) async {
      const maskedEmail = 't***@example.com';
      await tester.pumpWidget(createWidget(
        verificationType: VerificationType.email,
        maskedContact: maskedEmail,
      ));

      expect(find.text(maskedEmail), findsOneWidget);
    });

    testWidgets('should display verification title',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(
        verificationType: VerificationType.phone,
        maskedContact: '***-***-1234',
      ));

      expect(find.text('Enter Verification Code'), findsOneWidget);
    });
  });
}
