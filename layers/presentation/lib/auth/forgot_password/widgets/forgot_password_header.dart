import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presentation/theme/app_text_styles.dart';

class ForgotPasswordHeader extends StatelessWidget {
  final Color primaryColor;
  final Color primaryShadow;
  final Color onSurfaceColor;
  final Color onSurfaceMuted;
  final TextTheme textTheme;

  const ForgotPasswordHeader({
    super.key,
    required this.primaryColor,
    required this.primaryShadow,
    required this.onSurfaceColor,
    required this.onSurfaceMuted,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Icon container with gradient background
        Container(
          width: 128,
          height: 128,
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF083344)
                : const Color(0xFFE3F2FD),
            shape: BoxShape.circle,
            // boxShadow: [
            //   BoxShadow(
            //     color: primaryShadow.withValues(alpha: 0.1),
            //     blurRadius: 8,
            //     offset: const Offset(0, 4),
            //   ),
            // ],
          ),
          child: Icon(
            Icons.lock_reset_rounded,
            size: 64,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 24),

        // Title
        Text(
          'forgot_password_title'.tr,
          style: textTheme.headlineMedium?.copyWith(
            color: onSurfaceColor,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),

        // Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'forgot_password_subtitle'.tr,
            style: AppTextStyles.bodyMedium.copyWith(
              color: onSurfaceMuted,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
