class UserPreferences {
  final bool? darkMode;
  final String? language;
  final bool? notificationsEnabled;
  final bool? firstLaunch;

  UserPreferences({
     this.darkMode,
     this.language,
     this.notificationsEnabled,
     this.firstLaunch,
  });

  UserPreferences copyWith({
    bool? darkMode,
    String? language,
    bool? notificationsEnabled,
    bool? firstLaunch,
  }) {
    return UserPreferences(
      darkMode: darkMode ?? this.darkMode,
      language: language ?? this.language,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      firstLaunch: firstLaunch ?? this.firstLaunch,
    );
  }
}

