import 'package:domain/di/injection.dart';
import 'package:data/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:local_market_place/pages/app_pages.dart';
import 'package:presentation/di/injection.dart';
import 'package:presentation/routes/routes.dart';
import 'package:presentation/theme/app_theme.dart';
import 'package:get_storage/get_storage.dart';
import 'localization/messages.dart';

void main() async {
  // Preserve native splash screen
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize dependencies
  await GetStorage.init();
  configurePresentationDependencies();
  configureDomainDependencies();
  configureDataDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Local Marketblace',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      translations: Messages(),
      locale: const Locale("en"),
      fallbackLocale: const Locale('en'),
      getPages: appPages,
      initialRoute: splashRouteName,
    );
  }
}

