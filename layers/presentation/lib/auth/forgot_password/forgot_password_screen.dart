import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/auth/forgot_password/forgot_password_controller.dart';
import 'package:presentation/auth/forgot_password/forgot_password_state_handler.dart';
import 'package:presentation/auth/forgot_password/state/forgot_password_actions.dart';
import 'package:presentation/auth/forgot_password/widgets/forgot_password_form.dart';
import 'package:presentation/auth/forgot_password/widgets/forgot_password_header.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  void saveAndValidate(void Function() submit) {
    // Validate and save the form values
    if (_formKey.currentState?.saveAndValidate() == true) submit();
  }

  @override
  Widget build(BuildContext context) {
    // Cache theme values at build start
    final theme = Get.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = Get.textTheme;

    // Pre-calculate alpha colors for performance
    final primaryShadow = colorScheme.primary.withValues(alpha: 0.2);
    final onSurfaceMuted = colorScheme.onSurface.withValues(alpha: 0.6);

    final controller = Get.put(GetIt.I<ForgotPasswordController>());
    observeForgotPasswordEvents(controller.event);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: colorScheme.onSurface,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),

                // Header with icon and text
                ForgotPasswordHeader(
                  primaryColor: colorScheme.primary,
                  primaryShadow: primaryShadow,
                  onSurfaceColor: colorScheme.onSurface,
                  onSurfaceMuted: onSurfaceMuted,
                  textTheme: textTheme,
                ),
                const SizedBox(height: 32),

                // Form
                ForgotPasswordForm(
                  formKey: _formKey,
                  controller: controller,
                  onSubmit: () => saveAndValidate(
                    () => controller.forgotPasswordAction(SubmitForgotPassword()),
                  ),
                  primaryColor: colorScheme.primary,
                  onSurfaceMuted: onSurfaceMuted,
                  textTheme: textTheme,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
