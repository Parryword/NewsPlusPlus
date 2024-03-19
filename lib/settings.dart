/// https://stackoverflow.com/questions/12649573/how-do-you-build-a-singleton-in-dart
class Settings {
  static final Settings _instance = Settings._internal();
  bool isLoggedIn = false;
  bool toggleWarnings = false;
  Language chosenLanguage = Language.en;

  factory Settings() {
    return _instance;
  }

  Settings._internal();
}

enum Language {
  en, de, tr
}