import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presentation/theme/app_text_styles.dart';

class ResetPasswordHeader extends StatelessWidget {
  final Color primaryColor;
  final Color onSurfaceColor;
  final Color onSurfaceMuted;
  final TextTheme textTheme;

  const ResetPasswordHeader({
    super.key,
    required this.primaryColor,
    required this.onSurfaceColor,
    required this.onSurfaceMuted,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Container(
          width: 128,
          height: 128,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF083344) : const Color(0xFFE3F2FD),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.lock,
            size: 64,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'reset_password_title'.tr,
          style: textTheme.headlineMedium?.copyWith(
            color: onSurfaceColor,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'reset_password_subtitle'.tr,
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
