import 'package:domain/user_preferences/entity/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:presentation/routes/routes.dart';
import 'package:presentation/splash/splash_screen.dart';

extension SplashStateHandler on SplashScreen {
  void observeSplashState(Rxn<UserPreferences> userPreferences) {
    ever(userPreferences, (value) async {
      if (value != null) {
        await updatePreferences(value);
      }

      if (value?.firstLaunch == false) {
        await Get.offNamed(welcomeRouteName);
      } else {
        await Get.offNamed(onBoardingRouteName);
      }

      FlutterNativeSplash.remove();
    });
  }

  Future<void> updatePreferences(UserPreferences value) async {
    Get.updateLocale(Locale(value.language ?? 'en'));
    Get.changeThemeMode(
      value.darkMode == true ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
