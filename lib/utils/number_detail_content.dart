import 'package:easy_localization/easy_localization.dart';

/// Kid-friendly copy for numbers 1–100 (per-number, band, or rotating pools).
class NumberDetailContent {
  NumberDetailContent._();

  static String _trOrEmpty(String key, Map<String, String> args) {
    final text = key.tr(namedArgs: args);
    return text == key ? '' : text;
  }

  static String _firstNonEmpty(List<String> candidates) {
    for (final c in candidates) {
      if (c.trim().isNotEmpty) return c;
    }
    return '';
  }

  static String _word(int value) => 'numbers.names.$value'.tr();

  static String _bandKey(int value) {
    if (value == 100) return 'hundred';
    if (value == 10) return 'ten';
    if (value >= 11 && value <= 19) return 'teen';
    if (value >= 20 && value % 10 == 0) return 'roundTen';
    if (value >= 21 && value <= 99) return 'compound';
    return 'single';
  }

  static Map<String, String> _args({
    required int value,
    required String digitText,
    required String word,
  }) {
    final tensValue = (value ~/ 10) * 10;
    final onesValue = value % 10;
    final prev = value > 1 ? value - 1 : null;
    final next = value < 100 ? value + 1 : null;
    return {
      'name': word,
      'value': digitText,
      'digit': digitText,
      'num': '$value',
      'tens': tensValue > 0 ? '$tensValue' : '',
      'ones': onesValue > 0 ? '$onesValue' : '',
      'tensName': tensValue >= 10 ? _word(tensValue) : '',
      'onesName': onesValue > 0 ? _word(onesValue) : '',
      'prevName': prev != null ? _word(prev) : '',
      'nextName': next != null ? _word(next) : '',
      'leftTo100': '${100 - value}',
    };
  }

  static int _poolIndex(int value, int poolSize) {
    if (poolSize <= 0) return 0;
    return (value - 1) % poolSize;
  }

  static List<String> _poolKeys(String prefix) {
    final out = <String>[];
    for (var i = 0; i < 20; i++) {
      final key = '$prefix.$i';
      if (key.tr() == key) break;
      out.add(key);
    }
    return out;
  }

  static String _poolLine(
    String prefix,
    int value,
    Map<String, String> args,
  ) {
    final keys = _poolKeys(prefix);
    if (keys.isEmpty) return '';
    return keys[_poolIndex(value, keys.length)].tr(namedArgs: args);
  }

  static String sayIt(int value, String digitText, String word) {
    final id = '$value';
    final args = _args(value: value, digitText: digitText, word: word);
    return _firstNonEmpty([
      _trOrEmpty('numbers.detail.$id.about', args),
      _trOrEmpty('numbers.detail.bands.${_bandKey(value)}.about', args),
      _trOrEmpty('numbers.detail.aboutTemplate', args),
    ]);
  }

  static String surprise(int value, String digitText, String word) {
    final id = '$value';
    final args = _args(value: value, digitText: digitText, word: word);
    return _firstNonEmpty([
      _trOrEmpty('numbers.detail.$id.funFact', args),
      _trOrEmpty('numbers.detail.bands.${_bandKey(value)}.funFact', args),
      _poolLine('numbers.detail.funFacts', value, args),
    ]);
  }

  static String play(int value, String digitText, String word) {
    final id = '$value';
    final args = _args(value: value, digitText: digitText, word: word);
    return _firstNonEmpty([
      _trOrEmpty('numbers.detail.$id.try', args),
      _trOrEmpty('numbers.detail.bands.${_bandKey(value)}.try', args),
      _poolLine('numbers.detail.tries', value, args),
      _trOrEmpty('numbers.detail.tryTemplate', args),
      'numbers.dialog.hint'.tr(),
    ]);
  }

  static bool isEven(int value) => value > 0 && value % 2 == 0;

  static bool isRoundTen(int value) =>
      value >= 20 && value < 100 && value % 10 == 0;
}
