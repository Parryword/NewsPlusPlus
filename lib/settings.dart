/// https://stackoverflow.com/questions/12649573/how-do-you-build-a-singleton-in-dart
class Settings {
  static final Settings _instance = Settings._internal();
  bool isLoggedIn = false;
  bool toggleWarnings = true;
  Language chosenLanguage = Language.en;
  List<String> bookmarkUrls = List<String>.empty(growable: true);

  factory Settings() {
    return _instance;
  }

  Settings._internal();
}

enum Language {
  en, de, tr
}