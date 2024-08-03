enum Lang {
  en,
  tr,
}

extension LangExtension on Lang {
  String get name {
    switch (this) {
      case Lang.en:
        return 'en';
      case Lang.tr:
        return 'tr';
    }
  }
}
