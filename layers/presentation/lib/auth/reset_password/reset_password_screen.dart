import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/auth/reset_password/reset_password_controller.dart';
import 'package:presentation/auth/reset_password/reset_password_state_handler.dart';
import 'package:presentation/auth/reset_password/state/reset_password_actions.dart';
import 'package:presentation/auth/reset_password/widgets/reset_password_form.dart';
import 'package:presentation/auth/reset_password/widgets/reset_password_header.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  void saveAndValidate(void Function() submit) {
    if (_formKey.currentState?.saveAndValidate() == true) submit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = Get.textTheme;
    final onSurfaceMuted = colorScheme.onSurface.withValues(alpha: 0.6);

    final controller = Get.put(GetIt.I<ResetPasswordController>());
    observeResetPasswordEvents(controller.event);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          'reset_password_title'.tr,
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: const [SizedBox(width: 48)],
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
                ResetPasswordHeader(
                  primaryColor: colorScheme.primary,
                  onSurfaceColor: colorScheme.onSurface,
                  onSurfaceMuted: onSurfaceMuted,
                  textTheme: textTheme,
                ),
                const SizedBox(height: 32),
                ResetPasswordForm(
                  formKey: _formKey,
                  controller: controller,
                  onSubmit: () => saveAndValidate(
                    () => controller.resetPasswordAction(SubmitResetPassword()),
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
