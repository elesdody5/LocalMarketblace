import 'package:domain/auth/auth_repository.dart';
import 'package:domain/user/entity/user.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository{
  @override
  Future<void> login(String username, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> signup(User user, String password) {
    // TODO: implement signup
    throw UnimplementedError();
  }

  @override
  Future<void> requestPasswordReset(String phone) async {
    // TODO: implement requestPasswordReset
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    // For now, just return successfully
    return;
  }

}