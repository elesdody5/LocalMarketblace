import 'package:domain/auth/usecase/verification_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:presentation/auth/verification/verification_controller.dart';
import 'package:presentation/auth/verification/state/verification_actions.dart';
import 'package:presentation/auth/verification/state/verification_state.dart';
import 'package:presentation/auth/verification/widgets/bottom_email_section.dart';

import '../verification_controller_test.mocks.dart';

void main() {
  late MockVerificationUseCase mockVerificationUseCase;
  late VerificationController controller;

  setUp(() {
    Get.testMode = true;
    mockVerificationUseCase = MockVerificationUseCase();
    controller = VerificationController(mockVerificationUseCase);
    controller.onInit(); // Initialize the controller
  });

  tearDown(() {
    controller.onClose();
    Get.reset();
  });

  Widget createWidget(VerificationController controller) {
    return GetMaterialApp(
      home: Scaffold(
        body: VerificationTypeSwitcher(
          controller: controller,
          surfaceTranslucent: Colors.white,
          borderColor: Colors.grey,
          onSurfaceMuted: Colors.grey,
          primaryColor: Colors.blue,
          textTheme: const TextTheme(),
        ),
      ),
    );
  }

  group('VerificationTypeSwitcher Widget', () {
    testWidgets('should show "Verify via Email" when phone type is active and email is available',
        (WidgetTester tester) async {
      controller.setPhoneNumber('+1234567890');
      controller.setEmail('test@example.com');

      await tester.pumpWidget(createWidget(controller));

      expect(find.text('Verify via Email instead'), findsOneWidget);
      expect(find.byIcon(Icons.mail_outline), findsOneWidget);
    });

    testWidgets('should show "Verify via Phone" when email type is active and phone is available',
        (WidgetTester tester) async {
      controller.setPhoneNumber('+1234567890');
      controller.setEmail('test@example.com');
      controller.verificationAction(SwitchVerificationType());

      await tester.pumpWidget(createWidget(controller));
      await tester.pump();

      expect(find.text('Verify via Phone instead'), findsOneWidget);
      expect(find.byIcon(Icons.sms), findsOneWidget);
    });

    testWidgets('should not show switcher when email is empty and phone type is active',
        (WidgetTester tester) async {
      controller.setPhoneNumber('+1234567890');
      controller.setEmail('');

      await tester.pumpWidget(createWidget(controller));

      expect(find.byType(TextButton), findsNothing);
    });

    testWidgets('should not show switcher when phone is empty and email type is active',
        (WidgetTester tester) async {
      controller.setPhoneNumber('');
      controller.setEmail('test@example.com');
      controller.verificationAction(SwitchVerificationType());

      await tester.pumpWidget(createWidget(controller));
      await tester.pump();

      expect(find.byType(TextButton), findsNothing);
    });

    testWidgets('should trigger SwitchVerificationType action when tapped',
        (WidgetTester tester) async {
      controller.setPhoneNumber('+1234567890');
      controller.setEmail('test@example.com');

      await tester.pumpWidget(createWidget(controller));

      expect(controller.state.verificationType, VerificationType.phone);

      await tester.tap(find.byType(TextButton));
      await tester.pump();

      expect(controller.state.verificationType, VerificationType.email);
    });
  });
}
