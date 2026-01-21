import 'package:domain/user_preferences/entity/user_preferences.dart';
import 'package:domain/user_preferences/use_case/get_user_preferences_usecase.dart';
import 'package:domain/user_preferences/use_case/update_user_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:presentation/welcome/language_controller.dart';

import 'language_controller_test.mocks.dart';

@GenerateMocks([GetUserPreferencesUseCase, UpdateUserPreferencesUseCase])
void main() {
  late MockGetUserPreferencesUseCase mockGetUseCase;
  late MockUpdateUserPreferencesUseCase mockUpdateUseCase;
  late LanguageController controller;

  setUp(() {
    mockGetUseCase = MockGetUserPreferencesUseCase();
    mockUpdateUseCase = MockUpdateUserPreferencesUseCase();
    controller = LanguageController(mockGetUseCase, mockUpdateUseCase);
  });

  tearDown(() {
    clearInteractions(mockGetUseCase);
    clearInteractions(mockUpdateUseCase);
  });

  group('LanguageController - Initialization', () {
    test('should load saved language on init', () {
      // Arrange
      final savedPrefs = UserPreferences(
        language: 'ar',
        darkMode: false,
      );
      when(mockGetUseCase.call()).thenReturn(savedPrefs);

      // Act
      controller.onInit();

      // Assert
      expect(controller.currentLanguage.value, 'ar');
      verify(mockGetUseCase.call()).called(1);
    });

    test('should use en as default when no preferences saved', () {
      // Arrange
      when(mockGetUseCase.call()).thenReturn(null);

      // Act
      controller.onInit();

      // Assert
      expect(controller.currentLanguage.value, 'en');
      verify(mockGetUseCase.call()).called(1);
    });
  });

  group('LanguageController - Update Language', () {
    test('should update language and save to preferences', () async {
      // Arrange
      when(mockGetUseCase.call()).thenReturn(null);
      when(mockUpdateUseCase.call(any))
          .thenAnswer((_) async => Future.value());

      // Act
      await controller.updateLanguage('ar');

      // Assert
      expect(controller.currentLanguage.value, 'ar');
      verify(mockUpdateUseCase.call(any)).called(1);
    });

    test('should update existing preferences when changing language', () async {
      // Arrange
      final existingPrefs = UserPreferences(
        language: 'en',
        darkMode: true,
        notificationsEnabled: true,
      );
      when(mockGetUseCase.call()).thenReturn(existingPrefs);
      when(mockUpdateUseCase.call(any))
          .thenAnswer((_) async => Future.value());

      // Act
      await controller.updateLanguage('ar');

      // Assert
      expect(controller.currentLanguage.value, 'ar');
      final captured = verify(mockUpdateUseCase.call(captureAny)).captured;
      expect(captured.length, 1);
      final updatedPrefs = captured[0] as UserPreferences;
      expect(updatedPrefs.language, 'ar');
      expect(updatedPrefs.darkMode, true);
      expect(updatedPrefs.notificationsEnabled, true);
    });
  });

  group('LanguageController - Toggle Language', () {
    test('should toggle from en to ar', () async {
      // Arrange
      when(mockGetUseCase.call()).thenReturn(null);
      when(mockUpdateUseCase.call(any))
          .thenAnswer((_) async => Future.value());
      controller.currentLanguage.value = 'en';

      // Act
      await controller.toggleLanguage();

      // Assert
      expect(controller.currentLanguage.value, 'ar');
    });

    test('should toggle from ar to en', () async {
      // Arrange
      when(mockGetUseCase.call()).thenReturn(null);
      when(mockUpdateUseCase.call(any))
          .thenAnswer((_) async => Future.value());
      controller.currentLanguage.value = 'ar';

      // Act
      await controller.toggleLanguage();

      // Assert
      expect(controller.currentLanguage.value, 'en');
    });
  });

  group('LanguageController - Check Active Language', () {
    test('should correctly identify active language', () {
      // Arrange
      controller.currentLanguage.value = 'en';

      // Act & Assert
      expect(controller.isLanguageActive('en'), true);
      expect(controller.isLanguageActive('ar'), false);
    });
  });
}
