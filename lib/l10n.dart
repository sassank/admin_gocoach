import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('fr'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'en':
        return '🇺🇸';
      case 'fr':
        return '🇫🇷';
      default:
        return '🇺🇸';
    }
  }

  static Map<String, String> getSupportedLanguages() {
    return {
      'en': 'English',
      'fr': 'Français',
    };
  }
}
