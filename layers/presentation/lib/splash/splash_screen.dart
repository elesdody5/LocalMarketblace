import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/splash/splash_controller.dart';
import 'package:presentation/splash/splash_state_handler.dart';
import 'package:presentation/theme/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(GetIt.I<SplashController>());
    observeSplashState(controller.userPreferences);
    return const Placeholder();
  }
}
