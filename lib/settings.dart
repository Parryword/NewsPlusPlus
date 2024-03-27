import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
// dart pub add thread

/// https://stackoverflow.com/questions/12649573/how-do-you-build-a-singleton-in-dart
class Settings {
  static Settings? _instance;
  static final SettingsStorage _storage = SettingsStorage();
  bool isLoggedIn = false;
  bool toggleWarnings = true;
  Language chosenLanguage = Language.en;
  List<String> bookmarkUrls = List<String>.empty(growable: true);

  factory Settings() {
    _instance ??= Settings._internal();
    return _instance!;
  }

  Settings._internal();

  Settings.fromJson(Map<String, dynamic> json)
    : isLoggedIn = json['isLoggedIn'] as bool,
      toggleWarnings = json['toggleWarnings'] as bool,
      chosenLanguage = Language.values.elementAt(json['chosenLanguage']),
      bookmarkUrls = (json['bookmarkUrls'] as List).cast<String>();

  Map<String, dynamic> toJson() => {
    'isLoggedIn': isLoggedIn,
    'toggleWarnings': toggleWarnings,
    'chosenLanguage': chosenLanguage.index,
    'bookmarkUrls': bookmarkUrls
  };

  void save() {
    debugPrint("Saving...");
    _storage.write(jsonEncode(toJson()));
  }

  static Future<void> load() async {
    debugPrint("Loading...");
    Future<String> json = _storage.read();
    json.then((value) => {
      () {
        var temp = Settings.fromJson(jsonDecode(value));
        _instance!.chosenLanguage = temp.chosenLanguage;
        _instance!.isLoggedIn = temp.isLoggedIn;
        _instance!.bookmarkUrls = temp.bookmarkUrls;
        _instance!.toggleWarnings = temp.toggleWarnings;
        debugPrint(_instance.toString());
      }.call()
    });
  }

  @override
  String toString() {
    return 'Settings{isLoggedIn: $isLoggedIn, toggleWarnings: $toggleWarnings, chosenLanguage: $chosenLanguage, bookmarkUrls: $bookmarkUrls}';
  }
}

class SettingsStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/newsPP.txt');
  }

  Future<String> read() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return "";
    }
  }

  Future<File> write(String data) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(data);
  }
}

enum Language {
  en, de, tr
}