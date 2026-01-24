import 'package:injectable/injectable.dart';

// Import VerificationType enum from presentation layer
// Note: In a clean architecture, this should be in domain layer
// For now, we'll use String to avoid circular dependency
enum VerificationType {
  phone,
  email,
}

@injectable
class VerificationUseCase {
  /// Verifies the code sent to the phone number or email
  /// Returns successfully if verification passes, throws error otherwise
  Future<void> call(VerificationType type, String contact, String code) async {
    // Placeholder: Implement verification logic here
    // This will be connected to an authentication repository later
    await Future.delayed(const Duration(seconds: 2));

    // Log the verification attempt
    print('Verifying $type: $contact with code: $code');

    throw Exception('Invalid verification code');
    // Simulate successful verification
    // In real implementation, this would call the backend API
  }

  /// Resends the verification code to the phone number or email
  Future<void> resendCode(VerificationType type, String contact) async {
    // Placeholder: Implement resend code logic here
    await Future.delayed(const Duration(seconds: 1));

    // Log the resend attempt
    print('Resending code to $type: $contact');

    // Simulate successful resend
  }
}
