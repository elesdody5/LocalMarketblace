
import 'package:domain/auth/usecase/verification_usecase.dart';

class VerificationState {
  final String code;
  final bool isLoading;
  final bool isResendEnabled;
  final String phoneNumber;
  final String email;
  final VerificationType verificationType;
  final int resendCountdown;

  const VerificationState({
    this.code = '',
    this.isLoading = false,
    this.isResendEnabled = false,
    this.phoneNumber = '',
    this.email = '',
    this.verificationType = VerificationType.phone,
    this.resendCountdown = 60,
  });

  /// Returns true if all 6 digits have been entered
  bool get isCodeComplete => code.length == 6;

  /// Returns current contact based on verification type
  String get currentContact => verificationType == VerificationType.phone ? phoneNumber : email;

  /// Returns masked phone number showing only last 4 digits
  /// Example: "***-***-4567"
  String get maskedPhoneNumber {
    if (phoneNumber.isEmpty) {
      return '***-***-****';
    }

    // Remove all non-digit characters
    final digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length < 4) {
      return '***-***-****';
    }

    // Get last 4 digits
    final lastFour = digitsOnly.substring(digitsOnly.length - 4);
    return '***-***-$lastFour';
  }

  /// Returns masked email showing first character and domain
  /// Example: "a***@example.com"
  String get maskedEmail {
    if (email.isEmpty) {
      return 'a***@example.com';
    }

    final parts = email.split('@');
    if (parts.length != 2) {
      return 'a***@example.com';
    }

    final username = parts[0];
    final domain = parts[1];

    if (username.isEmpty) {
      return 'a***@$domain';
    }

    return '${username[0]}***@$domain';
  }

  /// Returns current masked contact based on verification type
  String get maskedContact => verificationType == VerificationType.phone ? maskedPhoneNumber : maskedEmail;

  VerificationState copyWith({
    String? code,
    bool? isLoading,
    bool? isResendEnabled,
    String? phoneNumber,
    String? email,
    VerificationType? verificationType,
    int? resendCountdown,
  }) {
    return VerificationState(
      code: code ?? this.code,
      isLoading: isLoading ?? this.isLoading,
      isResendEnabled: isResendEnabled ?? this.isResendEnabled,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      verificationType: verificationType ?? this.verificationType,
      resendCountdown: resendCountdown ?? this.resendCountdown,
    );
  }
}
