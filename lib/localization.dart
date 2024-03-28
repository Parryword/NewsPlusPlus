import 'dart:collection';

import 'package:se_380/settings.dart';

class Localization {
  static final Localization _instance = Localization._internal();
  final Settings settings = Settings();

  factory Localization() {
    return _instance;
  }

  Localization._internal();

  final Map<Language, String> _viewBookmarks = {
    Language.en: "View bookmarks",
    Language.de: "Leseziechen anzeigen",
    Language.tr: "Sayfa işaretlerini göster"
  };

  final Map<Language, String> _toggleWarnings = {
    Language.en: "Toggle warnings",
    Language.de: "Warnungen umschalten",
    Language.tr: "Uyarıları aç/kapa"
  };

  final Map<Language, String> _language = {
    Language.en: "Language",
    Language.de: "Sprache",
    Language.tr: "Dil"
  };

  final Map<Language, String> _english = {
    Language.en: "English",
    Language.de: "Englisch",
    Language.tr: "İngilizce"
  };

  final Map<Language, String> _german = {
    Language.en: "German",
    Language.de: "Deutsch",
    Language.tr: "Almanca"
  };

  final Map<Language, String> _turkish = {
    Language.en: "Turkish",
    Language.de: "Türkisch",
    Language.tr: "Türkçe"
  };

  final Map<Language, String> _exportSettings = {
    Language.en: "Export settings",
    Language.de: "Exporteinstellungen",
    Language.tr: "Ayarları dışa aktar"
  };

  final Map<Language, String> _importSettings = {
    Language.en: "Import settings",
    Language.de: "Importeinstellungen",
    Language.tr: "Ayarları içe aktar"
  };

  final Map<Language, String> _accountSettings = {
    Language.en: "Account settings",
    Language.de: "Kontoeinstellungen",
    Language.tr: "Hesap ayarları"
  };

  final Map<Language, String> _clearData = {
    Language.en: "Clear data",
    Language.de: "Daten löschen",
    Language.tr: "Verileri temizle"
  };

  final Map<Language, String> _bookmarks = {
    Language.en: "Bookmarks",
    Language.de: "Leseziechen",
    Language.tr: "Sayfa işaretleri"
  };

  final Map<Language, String> _bookmark = {
    Language.en: "Bookmark",
    Language.de: "Lesezeichen setzen",
    Language.tr: "Sayfayı işaretle"
  };

  final Map<Language, String> _copyLink = {
    Language.en: "Copy link",
    Language.de: "Link kopieren",
    Language.tr: "Linki kopyala"
  };

  final Map<Language, String> _open = {
    Language.en: "Open",
    Language.de: "Öffnen",
    Language.tr: "Aç"
  };

  final Map<Language, String> _factorySettings = {
    Language.en: "Factory settings",
    Language.de: "Werkseinstellung",
    Language.tr: "Fabrika ayarları"
  };

  String get viewBookmarks {
    switch(settings.chosenLanguage) {
      case Language.en: return _viewBookmarks[Language.en]!;
      case Language.de: return _viewBookmarks[Language.de]!;
      case Language.tr: return _viewBookmarks[Language.tr]!;
    }
  }

  String get toggleWarnings {
    switch(settings.chosenLanguage) {
      case Language.en: return _toggleWarnings[Language.en]!;
      case Language.de: return _toggleWarnings[Language.de]!;
      case Language.tr: return _toggleWarnings[Language.tr]!;
    }
  }

  String get language {
    switch(settings.chosenLanguage) {
      case Language.en: return _language[Language.en]!;
      case Language.de: return _language[Language.de]!;
      case Language.tr: return _language[Language.tr]!;
    }
  }

  String get exportSettings {
    switch(settings.chosenLanguage) {
      case Language.en: return _exportSettings[Language.en]!;
      case Language.de: return _exportSettings[Language.de]!;
      case Language.tr: return _exportSettings[Language.tr]!;
    }
  }

  String get importSettings {
    switch(settings.chosenLanguage) {
      case Language.en: return _importSettings[Language.en]!;
      case Language.de: return _importSettings[Language.de]!;
      case Language.tr: return _importSettings[Language.tr]!;
    }
  }

  String get accountSettings {
    switch(settings.chosenLanguage) {
      case Language.en: return _accountSettings[Language.en]!;
      case Language.de: return _accountSettings[Language.de]!;
      case Language.tr: return _accountSettings[Language.tr]!;
    }
  }

  String get clearData {
    switch(settings.chosenLanguage) {
      case Language.en: return _clearData[Language.en]!;
      case Language.de: return _clearData[Language.de]!;
      case Language.tr: return _clearData[Language.tr]!;
    }
  }

  String get english {
    switch(settings.chosenLanguage) {
      case Language.en: return _english[Language.en]!;
      case Language.de: return _english[Language.de]!;
      case Language.tr: return _english[Language.tr]!;
    }
  }

  String get german {
    switch(settings.chosenLanguage) {
      case Language.en: return _german[Language.en]!;
      case Language.de: return _german[Language.de]!;
      case Language.tr: return _german[Language.tr]!;
    }
  }

  String get turkish {
    switch(settings.chosenLanguage) {
      case Language.en: return _turkish[Language.en]!;
      case Language.de: return _turkish[Language.de]!;
      case Language.tr: return _turkish[Language.tr]!;
    }
  }

  String get bookmarks {
    switch(settings.chosenLanguage) {
      case Language.en: return _bookmarks[Language.en]!;
      case Language.de: return _bookmarks[Language.de]!;
      case Language.tr: return _bookmarks[Language.tr]!;
    }
  }

  String get bookmark {
    switch(settings.chosenLanguage) {
      case Language.en: return _bookmark[Language.en]!;
      case Language.de: return _bookmark[Language.de]!;
      case Language.tr: return _bookmark[Language.tr]!;
    }
  }

  String get copyLink {
    switch(settings.chosenLanguage) {
      case Language.en: return _copyLink[Language.en]!;
      case Language.de: return _copyLink[Language.de]!;
      case Language.tr: return _copyLink[Language.tr]!;
    }
  }

  String get open {
    switch(settings.chosenLanguage) {
      case Language.en: return _open[Language.en]!;
      case Language.de: return _open[Language.de]!;
      case Language.tr: return _open[Language.tr]!;
    }
  }

  String get factorySettings {
    switch(settings.chosenLanguage) {
      case Language.en: return _factorySettings[Language.en]!;
      case Language.de: return _factorySettings[Language.de]!;
      case Language.tr: return _factorySettings[Language.tr]!;
    }
  }
}
