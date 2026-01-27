import 'package:injectable/injectable.dart';

import '../auth_repository.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepository authRepository;

  ResetPasswordUseCase(this.authRepository);

  /// Resets the current user's password.
  ///
  /// Token handling is expected to be done via an interceptor.
  Future<void> call(String newPassword) async {
    return await authRepository.resetPassword(newPassword);
  }
}
