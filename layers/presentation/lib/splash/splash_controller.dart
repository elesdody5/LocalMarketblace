import 'package:domain/user_preferences/entity/user_preferences.dart';
import 'package:domain/user_preferences/use_case/get_user_preferences_usecase.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashController extends GetxController {
  final GetUserPreferencesUseCase _getUserPreferencesUseCase;

  SplashController(this._getUserPreferencesUseCase);

  final Rxn<UserPreferences> userPreferences = Rxn(UserPreferences());

  @override
  void onInit() async {
    super.onInit();
    _loadPreferencesAndNavigate();
  }

  void _loadPreferencesAndNavigate() async {
    final savedPreferences = _getUserPreferencesUseCase.call();
    await Future.delayed(const Duration(seconds: 1)); // Simulate splash delay
    userPreferences.value = savedPreferences;
  }
}
