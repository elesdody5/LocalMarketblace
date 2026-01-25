import 'package:injectable/injectable.dart';
import '../auth_repository.dart';

@injectable
class ForgotPasswordUseCase {
  final AuthRepository authRepository;

  ForgotPasswordUseCase(this.authRepository);

  /// Requests a password reset code to be sent to the provided phone number
  /// Throws an exception if the phone number is not registered or request fails
  Future<void> call(String phone) async {
    return await authRepository.requestPasswordReset(phone);
  }
}
