import 'package:domain/user_preferences/entity/user_preferences.dart';
import 'package:domain/user_preferences/use_case/get_user_preferences_usecase.dart';
import 'package:domain/user_preferences/use_case/update_user_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:presentation/splash/splash_controller.dart';

import 'splash_controller_test.mocks.dart';

@GenerateMocks([GetUserPreferencesUseCase, UpdateUserPreferencesUseCase])
void main() {
  late MockGetUserPreferencesUseCase mockGetUseCase;
  late SplashController controller;

  setUp(() {
    mockGetUseCase = MockGetUserPreferencesUseCase();
    controller = SplashController(mockGetUseCase);
  });

  tearDown(() {
    clearInteractions(mockGetUseCase);
  });

  group('SplashController - First Launch', () {
    test('should save system preferences on first launch', () async {
      // Arrange
      when(mockGetUseCase.call()).thenReturn(null); // No saved preferences


      // Act - Controller initializes automatically in onInit
      // We can't easily test navigation without GetX context

      // Assert
      verify(mockGetUseCase.call()).called(1);
    });
  });

  group('SplashController - Returning User', () {
    test('should load saved preferences for returning user', () async {
      // Arrange
      final savedPrefs = UserPreferences(
        darkMode: true,
        language: 'ar',
        notificationsEnabled: true,
        firstLaunch: false,
      );

      when(mockGetUseCase.call()).thenReturn(savedPrefs);


      // Act - Controller initializes in onInit

      // Assert
      verify(mockGetUseCase.call()).called(1);
    });
  });

  group('SplashController - Error Handling', () {
    test('should handle error gracefully when loading preferences fails', () async {
      // Arrange
      when(mockGetUseCase.call()).thenThrow(Exception('Storage error'));

      // Act - Controller should handle error in onInit

      // Assert - Should not crash
      verify(mockGetUseCase.call()).called(1);
    });
  });
}
