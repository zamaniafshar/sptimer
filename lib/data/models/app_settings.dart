class AppSettings {
  final bool isDarkTheme;
  final bool isEnglish;
  AppSettings({
    required this.isDarkTheme,
    required this.isEnglish,
  });

  AppSettings copyWith({
    bool? isDarkTheme,
    bool? isEnglish,
  }) {
    return AppSettings(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      isEnglish: isEnglish ?? this.isEnglish,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isDarkTheme': isDarkTheme,
      'isEnglish': isEnglish,
    };
  }

  factory AppSettings.fromMap(Map<dynamic, dynamic> map) {
    return AppSettings(
      isDarkTheme: map['isDarkTheme'] ?? false,
      isEnglish: map['isEnglish'] ?? false,
    );
  }
}
