import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// Simple wrapper around FlutterTts for tap‑to‑hear.
class AppSpeech {
  AppSpeech._();

  static final FlutterTts _tts = FlutterTts();
  static bool _initialized = false;

  static Future<void> _ensureInitialized(Locale locale) async {
    if (!_initialized) {
      await _tts.setSpeechRate(0.4);
      await _tts.setPitch(1.0);
      _initialized = true;
    }
    await _setLanguageForLocale(locale);
  }

  /// Speaks the given [text] using the current app locale.
  static Future<void> speak(BuildContext context, String text) async {
    if (text.trim().isEmpty) return;

    final locale = Localizations.localeOf(context);
    await _ensureInitialized(locale);

    // Stop anything currently speaking before starting again.
    await _tts.stop();
    await _tts.speak(text);
  }

  static Future<void> stop() async {
    await _tts.stop();
  }

  static Future<void> _setLanguageForLocale(Locale locale) async {
    final code = switch (locale.languageCode) {
      'hi' => 'hi-IN',
      'gu' => 'gu-IN',
      'mr' => 'mr-IN',
      'ta' => 'ta-IN',
      'pa' => 'pa-IN',
      'te' => 'te-IN',
      'bn' => 'bn-IN',
      'en' => 'en-US',
      _ => 'en-US',
    };
    await _tts.setLanguage(code);
  }
}

