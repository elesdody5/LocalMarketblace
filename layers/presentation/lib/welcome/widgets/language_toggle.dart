import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presentation/welcome/language_controller.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

/// Language toggle widget using LanguageController
class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.dividerDark : const Color(0xFFD1D5DB),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(2),
      child: Obx(() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LanguageButton(
            label: 'EN',
            isActive: languageController.isLanguageActive('en'),
            onPressed: () => languageController.updateLanguage('en'),
            isDark: isDark,
          ),
          _LanguageButton(
            label: 'AR',
            isActive: languageController.isLanguageActive('ar'),
            onPressed: () => languageController.updateLanguage('ar'),
            isDark: isDark,
          ),
        ],
      )),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onPressed;
  final bool isDark;

  const _LanguageButton({
    required this.label,
    required this.isActive,
    required this.onPressed,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: isActive
                  ? Colors.white
                  : (isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight),
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
