import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// Tap-to-hear speech in the app's selected language.
class AppSpeech {
  AppSpeech._();

  static final FlutterTts _tts = FlutterTts();
  static bool _initialized = false;
  static bool _rhymePlayback = false;
  static final Map<String, Map<String, String>> _voiceByLanguage = {};
  /// Skips slow locale/voice setup when language + rhyme mode unchanged.
  static String? _activeConfigKey;
  static String? _activeTtsCode;
  /// Bumped on [stop] / leave so in-flight [speak] calls abort.
  static int _cancelToken = 0;
  /// Latest tap wins when multiple [speak] calls overlap on one screen.
  static int _speakSeq = 0;

  /// Stops speech when any route is popped (detail screen back, etc.).
  static final NavigatorObserver stopOnPopObserver = _StopOnPopObserver();

  /// Notifies screens when another route covers them (home → section, etc.).
  static final RouteObserver<PageRoute<dynamic>> routeObserver =
      RouteObserver<PageRoute<dynamic>>();

  static const Map<String, List<String>> _languageCandidates = {
    'hi': ['hi-IN', 'hi_IN', 'hin-IN', 'hi'],
    'mr': ['mr-IN', 'mr_IN', 'mar-IN', 'mr'],
    'gu': ['gu-IN', 'gu_IN', 'guj-IN', 'gu'],
    'ta': ['ta-IN', 'ta_IN', 'tam-IN', 'ta'],
    'pa': ['pa-IN', 'pa_IN', 'pan-IN', 'pa'],
    'en': ['en-US', 'en-GB', 'en-IN', 'en'],
  };

  static String _langPrefix(String? code) {
    if (code == null || code.isEmpty) return 'en';
    return code.toLowerCase().split(RegExp(r'[-_]')).first;
  }

  /// Google TTS voices interpret [setSpeechRate] differently per language.
  /// Hindi/Gujarati feel right at the base rate; others need a slower value.
  static double _normalSpeechRate(String? languageCode) {
    final lang = _langPrefix(languageCode);
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return switch (lang) {
        'hi' || 'gu' => 0.32,
        'mr' || 'ta' || 'pa' => 0.26,
        _ => 0.28,
      };
    }
    return switch (lang) {
      'hi' || 'gu' => 0.50,
      'mr' || 'ta' || 'pa' => 0.40,
      _ => 0.38,
    };
  }

  static double _rhymeSpeechRate(String? languageCode) {
    final lang = _langPrefix(languageCode);
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return switch (lang) {
        'hi' || 'gu' => 0.32,
        'mr' || 'ta' || 'pa' => 0.26,
        _ => 0.28,
      };
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      return switch (lang) {
        'hi' || 'gu' => 0.52,
        'mr' || 'ta' || 'pa' => 0.42,
        _ => 0.40,
      };
    }
    return switch (lang) {
      'hi' || 'gu' => 0.40,
      _ => 0.34,
    };
  }

  /// Normal learning cards — slower pace so kids can follow (tap-to-hear).
  static Future<void> _applyNormalVoice({String? languageCode}) async {
    await _tts.setSpeechRate(_normalSpeechRate(languageCode));
    await _tts.setPitch(1.0);
    await _tts.setVolume(1.0);
  }

  /// Nursery rhymes — slower, slightly higher pitch, smoother flow.
  static Future<void> _applyRhymeVoice({String? languageCode}) async {
    await _tts.setSpeechRate(_rhymeSpeechRate(languageCode));
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await _tts.setPitch(1.18);
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      await _tts.setPitch(1.12);
    } else {
      await _tts.setPitch(1.15);
    }
    await _tts.setVolume(1.0);
  }

  static Future<void> _ensureInitialized() async {
    if (_initialized) return;
    await _tts.awaitSpeakCompletion(true);
    if (defaultTargetPlatform == TargetPlatform.android) {
      await _tts.setQueueMode(1);
      try {
        await _tts.setEngine('com.google.android.tts');
      } catch (_) {}
    }
    _initialized = true;
  }

  static bool _languageSetOk(dynamic result) {
    return result == 1 || result == true;
  }

  static Future<bool> _isLanguageAvailable(String code) async {
    try {
      final available = await _tts.isLanguageAvailable(code);
      return available == true || available == 1;
    } catch (_) {
      return true;
    }
  }

  /// Picks an installed TTS language for [locale]. Returns the code that worked.
  static Future<String?> _configureForLocale(Locale locale) async {
    final lang = locale.languageCode.toLowerCase();
    final candidates = _languageCandidates[lang] ?? _languageCandidates['en']!;

    for (final code in candidates) {
      try {
        if (!await _isLanguageAvailable(code)) continue;
        final result = await _tts.setLanguage(code);
        if (_languageSetOk(result)) {
          return code;
        }
      } catch (e) {
        debugPrint('AppSpeech setLanguage($code) failed: $e');
      }
    }

    for (final code in _languageCandidates['en']!) {
      try {
        if (!await _isLanguageAvailable(code)) continue;
        final result = await _tts.setLanguage(code);
        if (_languageSetOk(result)) {
          return code;
        }
      } catch (_) {}
    }
    return null;
  }

  /// Call when the user changes app language so the next speak reconfigures TTS.
  static void resetLanguageCache() {
    _voiceByLanguage.clear();
    _activeConfigKey = null;
    _activeTtsCode = null;
  }

  /// Pre-loads voice once so the first card tap speaks immediately.
  static Future<void> warmUp(Locale locale) async {
    await _prepareForLocale(locale, rhyme: false);
  }

  static Future<void> _prepareForLocale(Locale locale, {required bool rhyme}) async {
    await _ensureInitialized();
    _rhymePlayback = rhyme;

    final configKey = '${locale.languageCode.toLowerCase()}-$rhyme';
    if (_activeConfigKey != configKey) {
      _activeTtsCode = await _configureForLocale(locale);
      _activeConfigKey = configKey;
      if (_activeTtsCode != null) {
        await _pickBestVoiceForLanguage(_activeTtsCode!);
      }
    }

    final langCode = _activeTtsCode ?? locale.languageCode;
    if (rhyme) {
      await _applyRhymeVoice(languageCode: langCode);
    } else {
      await _applyNormalVoice(languageCode: langCode);
    }

    // Android resets voice after rate/pitch — instant re-apply from cache.
    final ttsCode = _activeTtsCode;
    if (ttsCode != null) {
      final cacheKey = ttsCode.toLowerCase().replaceAll('_', '-');
      final cached = _voiceByLanguage[cacheKey];
      if (cached != null) {
        await _tts.setVoice(cached);
      }
    }
  }

  /// Speaks [text]. Use [languageCode] when the phrase is in another language
  /// (e.g. Gujarati script while UI is English).
  static Future<void> speak(
    BuildContext context,
    String text, {
    String? languageCode,
  }) async {
    if (text.trim().isEmpty) return;

    final seq = ++_speakSeq;
    final locale = languageCode != null
        ? Locale(languageCode)
        : Localizations.localeOf(context);
    await _tts.stop();
    final cancel = _cancelToken;
    await _prepareForLocale(locale, rhyme: false);
    if (cancel != _cancelToken || seq != _speakSeq) return;
    await _tts.speak(text);
  }

  /// Stops audio only — does not cancel the next card's pending speech.
  static Future<void> interruptPlayback() async {
    await _tts.stop();
  }

  static Future<void> stop() async {
    _cancelToken++;
    _speakSeq++;
    await _tts.stop();
    if (_rhymePlayback) {
      _rhymePlayback = false;
      await _applyNormalVoice(languageCode: _activeTtsCode);
    }
  }

  /// Sing-along poem: reads by verse with rhythm — not choppy word-by-word.
  static Future<void> speakRhyme(
    BuildContext context, {
    required List<String> lines,
    required List<int> stanzaSizes,
    required bool Function() shouldStop,
    void Function(int lineIndex)? onLineStart,
  }) async {
    if (lines.isEmpty) return;

    final speakGen = _cancelToken;
    final locale = Localizations.localeOf(context);
    await _prepareForLocale(locale, rhyme: true);
    if (speakGen != _cancelToken) return;
    await _tts.awaitSpeakCompletion(true);
    await _tts.stop();
    if (speakGen != _cancelToken) return;

    try {
      var globalLine = 0;

      for (var s = 0; s < stanzaSizes.length; s++) {
        if (shouldStop() || speakGen != _cancelToken) break;

        final stanzaSize = stanzaSizes[s];
        final stanzaEnd = globalLine + stanzaSize;

        for (var i = globalLine; i < stanzaEnd && i < lines.length; i++) {
          if (shouldStop() || speakGen != _cancelToken) break;

          final isLastInStanza = i == stanzaEnd - 1;
          onLineStart?.call(i);

          final phrase = _phraseForRhymeLine(
            lines[i],
            isLastInStanza: isLastInStanza,
          );

          await _tts.speak(phrase);
          // Some Android engines report completion too early for Hindi/Gujarati.
          // Keep a minimum speaking window so lines don't finish instantly.
          final minSpeakMs = (phrase.length * 45).clamp(550, 2600);
          await Future.delayed(Duration(milliseconds: minSpeakMs));

          if (shouldStop() || speakGen != _cancelToken) break;

          if (!isLastInStanza) {
            await Future.delayed(const Duration(milliseconds: 220));
          }
        }

        globalLine = stanzaEnd;

        if (!shouldStop() && speakGen == _cancelToken && s < stanzaSizes.length - 1) {
          await Future.delayed(const Duration(milliseconds: 750));
        }
      }
    } finally {
      _rhymePlayback = false;
      await _applyNormalVoice(languageCode: _activeTtsCode);
    }
  }

  static String _phraseForRhymeLine(String line, {required bool isLastInStanza}) {
    var text = line.trim();
    if (text.isEmpty) return text;

    if (!isLastInStanza) {
      if (text.endsWith('.')) {
        text = '${text.substring(0, text.length - 1)},';
      } else if (text.endsWith('!')) {
        text = '${text.substring(0, text.length - 1)}!';
      } else if (!text.endsWith(',') &&
          !text.endsWith('?') &&
          !text.endsWith(';')) {
        text = '$text,';
      }
    }

    return text;
  }

  /// female | male | unknown — used to always skip male voices on the device.
  static String _voiceGenderBucket(Map<String, dynamic> voice) {
    final gender = '${voice['gender']}'.toLowerCase();
    if (gender == 'female') return 'female';
    if (gender == 'male') return 'male';

    final name = '${voice['name']}'.toLowerCase();
    if (name.contains('female') ||
        name.contains('woman') ||
        name.contains('#female')) {
      return 'female';
    }
    if (name.contains('male') || name.contains('#male')) {
      return 'male';
    }

    // Google Android TTS voice id pattern: …-x-abc-… (engine code, not a person).
    final engineCode = RegExp(r'x-([a-z]{3})').firstMatch(name)?.group(1);
    if (engineCode != null) {
      const femaleCodes = {
        'enc', 'ena', 'enb', 'afb', 'aft', 'sfg', 'aub', 'gba', 'hia', 'hfb',
        'guf', 'gua', 'taf', 'tac', 'mrf', 'mra', 'paf', 'paa',
      };
      const maleCodes = {
        'end', 'iob', 'iom', 'iod', 'ecc', 'dma', 'hic', 'koc', 'hcd', 'hid',
        'gum', 'gub', 'tam', 'mrm', 'pam', 'pab',
      };
      if (femaleCodes.contains(engineCode)) return 'female';
      if (maleCodes.contains(engineCode)) return 'male';
    }

    return 'unknown';
  }

  static Future<void> _pickBestVoiceForLanguage(String languageCode) async {
    final cacheKey = languageCode.toLowerCase().replaceAll('_', '-');

    final cached = _voiceByLanguage[cacheKey];
    if (cached != null) {
      await _tts.setVoice(cached);
      return;
    }

    try {
      final voices = await _tts.getVoices;
      if (voices is! List || voices.isEmpty) return;

      final prefix = cacheKey;
      final langPrefix = prefix.split('-').first;
      final forLanguage = <Map<String, dynamic>>[];

      for (final raw in voices) {
        if (raw is! Map) continue;
        final map = Map<String, dynamic>.from(raw);
        final voiceLocale =
            '${map['locale']}'.toLowerCase().replaceAll('_', '-');
        if (!voiceLocale.startsWith(langPrefix)) continue;
        forLanguage.add(map);
      }

      if (forLanguage.isEmpty) return;

      final femaleVoices = forLanguage
          .where((v) => _voiceGenderBucket(v) == 'female')
          .toList();
      // Never pick a male voice — female only (no unknown fallback; unknown may sound male).
      if (femaleVoices.isEmpty) return;

      int score(Map<String, dynamic> v) {
        final name = '${v['name']}'.toLowerCase();
        final locale = '${v['locale']}'.toLowerCase().replaceAll('_', '-');
        var s = 0;
        if (_voiceGenderBucket(v) == 'female') s += 100;
        if (locale.startsWith(prefix)) s += 8;
        if (locale.contains('in')) s += 2;
        if (name.contains('local')) s += 3;
        if (name.contains('india')) s += 2;
        return s;
      }

      femaleVoices.sort((a, b) => score(b).compareTo(score(a)));
      final best = femaleVoices.first;
      final voice = {
        'name': '${best['name']}',
        'locale': '${best['locale']}',
      };
      await _tts.setVoice(voice);
      _voiceByLanguage[cacheKey] = voice;
    } catch (e) {
      debugPrint('AppSpeech voice pick failed: $e');
    }
  }
}

class _StopOnPopObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    AppSpeech.stop();
    super.didPop(route, previousRoute);
  }
}
