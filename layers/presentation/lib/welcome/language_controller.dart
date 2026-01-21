import 'package:domain/user_preferences/entity/user_preferences.dart';
import 'package:domain/user_preferences/use_case/get_user_preferences_usecase.dart';
import 'package:domain/user_preferences/use_case/update_user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@injectable
class LanguageController extends GetxController {
  final GetUserPreferencesUseCase _getUserPreferencesUseCase;
  final UpdateUserPreferencesUseCase _updateUserPreferencesUseCase;

  LanguageController(
    this._getUserPreferencesUseCase,
    this._updateUserPreferencesUseCase,
  );

  // Observable for current language
  final Rx<String> currentLanguage = 'en'.obs;

  @override
  void onInit() {
    super.onInit();
    final preferences = _getUserPreferencesUseCase.call();
    if (preferences != null) {
      _updateUserPreferencesUseCase(preferences.copyWith(firstLaunch: false));
    }
    _loadCurrentLanguage(preferences);
  }

  /// Load the current language from user preferences
  void _loadCurrentLanguage(UserPreferences? preferences) {
    if (preferences?.language != null) {
      currentLanguage.value = preferences!.language!;
    } else {
      // Use system locale as default
      final systemLocale = Get.deviceLocale?.languageCode ?? 'en';
      currentLanguage.value = systemLocale;
    }
  }

  /// Update the app language
  Future<void> updateLanguage(String languageCode) async {
    // Update GetX locale
    Get.updateLocale(Locale(languageCode));

    // Update observable
    currentLanguage.value = languageCode;

    // Get current preferences
    final currentPreferences = _getUserPreferencesUseCase.call();

    // Create updated preferences
    final updatedPreferences =
        currentPreferences?.copyWith(language: languageCode) ??
        UserPreferences(language: languageCode);

    // Save to storage
    await _updateUserPreferencesUseCase.call(updatedPreferences);
  }

  /// Toggle between English and Arabic
  Future<void> toggleLanguage() async {
    final newLanguage = currentLanguage.value == 'en' ? 'ar' : 'en';
    await updateLanguage(newLanguage);
  }

  /// Check if a specific language is active
  bool isLanguageActive(String languageCode) {
    return currentLanguage.value == languageCode;
  }
}
