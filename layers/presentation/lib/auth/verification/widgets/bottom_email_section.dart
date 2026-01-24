import 'package:domain/auth/usecase/verification_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presentation/auth/verification/verification_controller.dart';
import 'package:presentation/auth/verification/state/verification_actions.dart';
import 'package:presentation/auth/verification/state/verification_state.dart';

/// Bottom section with verification type switcher
/// Allows switching between phone and email verification
class VerificationTypeSwitcher extends StatelessWidget {
  final VerificationController controller;
  final Color surfaceTranslucent;
  final Color borderColor;
  final Color onSurfaceMuted;
  final Color primaryColor;
  final TextTheme textTheme;

  const VerificationTypeSwitcher({
    super.key,
    required this.controller,
    required this.surfaceTranslucent,
    required this.borderColor,
    required this.onSurfaceMuted,
    required this.primaryColor,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    final isPhone = controller.state.verificationType == VerificationType.phone;
    final hasAlternative = isPhone
        ? controller.state.email.isNotEmpty
        : controller.state.phoneNumber.isNotEmpty;

    if (!hasAlternative) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        color: surfaceTranslucent,
        border: Border(
          top: BorderSide(
            color: borderColor,
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: TextButton.icon(
          onPressed: () {
            controller.verificationAction(SwitchVerificationType());
          },
          icon: Icon(
            isPhone ? Icons.mail_outline : Icons.sms,
            size: 20,
            color: onSurfaceMuted,
          ),
          label: Text(
            isPhone ? 'verify_via_email'.tr : 'verify_via_phone'.tr,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: onSurfaceMuted,
            ),
          ),
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ),
    );
  }
}
