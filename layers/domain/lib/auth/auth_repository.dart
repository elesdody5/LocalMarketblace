import 'package:domain/user/entity/user.dart';

abstract class AuthRepository {
  Future<void> signup(User user, String password);
  Future<void> login(String username, String password);
  Future<void> requestPasswordReset(String phone);

  /// Resets the user's password.
  /// Token handling is expected to be done via an interceptor.
  Future<void> resetPassword(String newPassword);
}