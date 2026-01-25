import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:presentation/auth/forgot_password/forgot_password_controller.dart';
import 'package:presentation/auth/forgot_password/state/forgot_password_actions.dart';
import 'package:presentation/auth/signup/widgets/phone_input_field.dart';
import 'package:presentation/theme/app_text_styles.dart';
import 'package:presentation/widgets/primary_button.dart';

class ForgotPasswordForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final ForgotPasswordController controller;
  final VoidCallback onSubmit;
  final Color primaryColor;
  final Color onSurfaceMuted;
  final TextTheme textTheme;

  const ForgotPasswordForm({
    super.key,
    required this.formKey,
    required this.controller,
    required this.onSubmit,
    required this.primaryColor,
    required this.onSurfaceMuted,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Phone Number Field
          PhoneInputField(
            name: 'phone',
            label: 'phone_number'.tr,
            placeholder: '(555) 000-0000',
            onSaved: (value) => controller.forgotPasswordAction(
              SavePhone(value ?? ''),
            ),
          ),
          const SizedBox(height: 32),

          // Submit Button - Wrapped with GetBuilder for loading state
          GetBuilder<ForgotPasswordController>(
            builder: (controller) {
              return PrimaryButton(
                onPressed: onSubmit,
                isLoading: controller.state.isLoading,
                label: 'send_reset_code'.tr,
                borderRadius: 12,
                elevation: 8,
                padding: const EdgeInsets.symmetric(vertical: 16),
              );
            },
          ),
          const SizedBox(height: 32),

          // Contact Support Link
          Center(
            child: TextButton(
              onPressed: () {
                Get.snackbar(
                  'Coming Soon',
                  'Contact support feature will be available soon',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: RichText(
                text: TextSpan(
                  text: '${'need_more_help'.tr} ',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: onSurfaceMuted,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: 'contact_support'.tr,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: onSurfaceMuted,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Remember Password Link
          Center(
            child: RichText(
              text: TextSpan(
                text: '${'remember_password'.tr} ',
                style: textTheme.bodyMedium?.copyWith(
                  color: onSurfaceMuted,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Text(
                        'log_in'.tr,
                        style: textTheme.bodyMedium?.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
