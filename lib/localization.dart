import 'dart:collection';

class Localization {
  static final Localization _instance = Localization._internal();

  factory Localization() {
    return _instance;
  }

  Localization._internal();
}