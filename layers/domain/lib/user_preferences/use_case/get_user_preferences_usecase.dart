import 'package:domain/user_preferences/entity/user_preferences.dart';
import 'package:domain/user_preferences/user_preferences_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserPreferencesUseCase {
  final UserPreferencesRepository _repository;

  GetUserPreferencesUseCase(this._repository);

  UserPreferences? call() {
    return _repository.getUserPreferences();
  }
}
