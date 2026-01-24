import 'package:domain/auth/usecase/verification_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presentation/auth/verification/state/verification_state.dart';

/// Header section for verification screen
/// Displays SMS or Email icon with hover effect, title, and subtitle with masked contact
class VerificationHeader extends StatefulWidget {
  final Color primaryColor;
  final Color primaryShadow;
  final Color onSurfaceColor;
  final Color onSurfaceMuted;
  final TextTheme textTheme;
  final String maskedContact;
  final VerificationType verificationType;
  final bool isDark;

  const VerificationHeader({
    super.key,
    required this.primaryColor,
    required this.primaryShadow,
    required this.onSurfaceColor,
    required this.onSurfaceMuted,
    required this.textTheme,
    required this.maskedContact,
    required this.verificationType,
    required this.isDark,
  });

  @override
  State<VerificationHeader> createState() => _VerificationHeaderState();
}

class _VerificationHeaderState extends State<VerificationHeader> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // ✅ SMS Icon with hover glow effect wrapped in RepaintBoundary
          RepaintBoundary(
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Blur glow effect (animated)
                  AnimatedOpacity(
                    opacity: _isHovered ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 700),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: widget.primaryColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: widget.primaryColor.withValues(alpha: 0.2),
                            blurRadius: 30,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Main icon container
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: widget.isDark ? Colors.grey.shade800 : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: widget.isDark
                            ? Colors.grey.shade700
                            : Colors.grey.shade100,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.verificationType == VerificationType.phone
                          ? Icons.sms
                          : Icons.mail_outline,
                      size: 40,
                      color: widget.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Title
          Text(
            'verification_title'.tr,
            style: widget.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: widget.onSurfaceColor,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),

          // Subtitle with masked phone number or email
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: widget.textTheme.bodyMedium?.copyWith(
                color: widget.onSurfaceMuted,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
              children: [
                TextSpan(text: 'verification_subtitle'.tr),
                const TextSpan(text: ' '),
                TextSpan(
                  text: widget.maskedContact,
                  style: TextStyle(
                    color: widget.onSurfaceColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
