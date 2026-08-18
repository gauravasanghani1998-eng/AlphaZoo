import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/app_text_styles.dart';
import '../data/native_script_data.dart';
import '../ui/models/learning_detail_page.dart';
import 'number_detail_content.dart';

/// Builds [LearningDetailPage] text from translation keys.
class LearningDetailContent {
  LearningDetailContent._();

  static final Map<String, Map<String, dynamic>> _translationRoots = {};
  static bool _translationsReady = false;

  /// Loads JSON translations for cross-locale speak (e.g. English UI + Gujarati speak).
  static Future<void> preloadScriptTranslations() async {
    if (_translationsReady) return;

    const codes = ['en', 'hi', 'mr', 'gu', 'pa', 'ta'];
    for (final code in codes) {
      final raw =
          await rootBundle.loadString('assets/translations/$code.json');
      _translationRoots[code] = jsonDecode(raw) as Map<String, dynamic>;
    }
    _translationsReady = true;
  }

  static String _trInLocale(
    String localeCode,
    String key, {
    Map<String, String>? namedArgs,
  }) {
    if (!_translationsReady) return '';

    dynamic node = _translationRoots[localeCode];
    for (final part in key.split('.')) {
      if (node is! Map) return '';
      node = node[part];
    }
    if (node is! String) return '';

    var result = node;
    namedArgs?.forEach((name, value) {
      result = result.replaceAll('{$name}', value);
    });
    return result;
  }

  /// Traditional teaching phrase: ક કમળનો ક
  static String _formatScriptSpeak(String glyph, String phrase) {
    final trimmed = phrase.trim();
    if (trimmed.isEmpty) return glyph;

    final tokens = trimmed.split(RegExp(r'\s+'));
    if (tokens.isNotEmpty && tokens.first == glyph) return trimmed;
    if (tokens.isNotEmpty && tokens.last == glyph) {
      return '$glyph $trimmed';
    }
    return '$glyph $trimmed';
  }

  static String _trOrEmpty(String key, {Map<String, String>? args}) {
    final text = args == null ? key.tr() : key.tr(namedArgs: args);
    return text == key ? '' : text;
  }

  static String _firstNonEmpty(List<String> candidates) {
    for (final c in candidates) {
      if (c.trim().isNotEmpty) return c;
    }
    return '';
  }

  static String _itemIdFromNameKey(String nameKey) {
    final parts = nameKey.split('.');
    return parts.isNotEmpty ? parts.last : nameKey;
  }

  /// Spelling tiles — per-word detail keys (every word has about/funFact/try).
  static LearningDetailPage spellingItem({
    required String emoji,
    required String nameKey,
    required String category,
  }) {
    final name = nameKey.tr();
    final id = _itemIdFromNameKey(nameKey);
    final args = {'name': name, 'category': category};

    return LearningDetailPage(
      emoji: emoji,
      title: name,
      speakText: name,
      about: _trOrEmpty('spelling.$category.detail.$id.about', args: args),
      funFact: _trOrEmpty('spelling.$category.detail.$id.funFact', args: args),
      tryThis: _trOrEmpty('spelling.$category.detail.$id.try', args: args),
    );
  }

  /// Emoji tile modules (body, emotions, vehicles, family, …).
  static LearningDetailPage emojiItem({
    required String emoji,
    required String nameKey,
    required String module,
    String? imageAsset,
    String? subtitleKey,
    Map<String, String> extraArgs = const {},
  }) {
    final name = nameKey.tr();
    final id = _itemIdFromNameKey(nameKey);
    final args = {'name': name, ...extraArgs};

    final subtitleDisplay =
        subtitleKey != null ? _trOrEmpty(subtitleKey, args: args) : null;

    final hasImage = imageAsset != null && imageAsset.isNotEmpty;

    return LearningDetailPage(
      emoji: hasImage ? null : emoji,
      title: name,
      subtitle: subtitleDisplay != null &&
              subtitleDisplay.isNotEmpty &&
              subtitleDisplay != name
          ? subtitleDisplay
          : null,
      speakText: name,
      hero: hasImage
          ? ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                imageAsset,
                width: 168,
                height: 168,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Text(
                  emoji,
                  style: const TextStyle(fontSize: 72),
                ),
              ),
            )
          : null,
      about: _trOrEmpty('$module.detail.$id.about', args: args),
      funFact: _trOrEmpty('$module.detail.$id.funFact', args: args),
      tryThis: _trOrEmpty('$module.detail.$id.try', args: args),
    );
  }

  static LearningDetailPage numberItem({
    required int value,
    required String digitText,
    required String word,
    required Color accentColor,
    double heroFontSize = 72,
    List<Widget>? extraSections,
  }) {
    return LearningDetailPage(
      title: word,
      subtitle: digitText,
      speakText: word,
      hero: numberHero(digitText, accentColor, heroFontSize),
      about: NumberDetailContent.sayIt(value, digitText, word),
      funFact: NumberDetailContent.surprise(value, digitText, word),
      tryThis: NumberDetailContent.play(value, digitText, word),
      aboutTitle: 'numbers.detail.labels.sayIt',
      funFactTitle: 'numbers.detail.labels.surprise',
      tryTitle: 'numbers.detail.labels.play',
      extraSections: extraSections,
    );
  }

  static LearningDetailPage oppositePair({
    required String leftEmoji,
    required String rightEmoji,
    required String leftKey,
    required String rightKey,
    required String pairId,
  }) {
    final left = leftKey.tr();
    final right = rightKey.tr();
    final args = {'first': left, 'second': right, 'left': left, 'right': right};

    return LearningDetailPage(
      title: left,
      subtitle: right,
      speakText: '$left. $right.',
      heroInCircle: false,
      oppositePairLayout: true,
      about: _trOrEmpty('opposites.detail.$pairId.about', args: args),
      funFact: _trOrEmpty('opposites.detail.$pairId.funFact', args: args),
      tryThis: _trOrEmpty('opposites.detail.$pairId.try', args: args),
    );
  }

  /// Digit glyph only — outer ring comes from [KidAlphabetStyleDetail.circleHero].
  static Widget numberHero(String digitText, Color color, double fontSize) {
    return Text(
      digitText,
      style: AppTextStyles.detailLetter.copyWith(
        fontSize: fontSize,
        color: Colors.white,
        shadows: [
          Shadow(
            color: Colors.black.withValues(alpha: 0.2),
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }

  static Widget colorHero(Color color) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: color.computeLuminance() > 0.85
              ? Colors.grey.shade400
              : Colors.white,
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
    );
  }

  /// Punjabi/Tamil labels and "vs" text are longer — use a tighter hero row.
  static bool compactOppositesLayout(String languageCode) {
    final lang = languageCode.toLowerCase();
    return lang == 'pa' || lang == 'ta';
  }

  static bool compactOppositesLayoutFrom(BuildContext context) {
    return compactOppositesLayout(Localizations.localeOf(context).languageCode);
  }

  static double oppositeHeroEmojiSize(double screenWidth, String languageCode) {
    final base = (screenWidth * 0.18).clamp(56.0, 78.0);
    if (compactOppositesLayout(languageCode)) {
      return (base * 0.86).clamp(50.0, 66.0);
    }
    return base;
  }

  /// Two big emoji circles + vs badge — not wrapped in one outer circle.
  static Widget oppositeHero({
    required String leftEmoji,
    required String rightEmoji,
    required Color color,
    required double emojiSize,
    bool compact = false,
  }) {
    final bubblePad = compact ? 9.0 : 12.0;
    final bubble = emojiSize + (compact ? 30.0 : 40.0);
    final vsHPad = compact ? 10.0 : 14.0;
    final vsBadgeH = compact ? 12.0 : 16.0;
    final vsBadgeV = compact ? 7.0 : 10.0;
    final vsFont = compact ? 15.0 : 18.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Center(
              child: _emojiBubble(
                leftEmoji,
                color,
                emojiSize,
                bubble,
                padding: bubblePad,
                compact: compact,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: vsHPad),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: vsBadgeH,
                vertical: vsBadgeV,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(compact ? 16 : 22),
                border: Border.all(
                  color: color.withValues(alpha: 0.5),
                  width: compact ? 2 : 2.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.22),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'opposites.vs'.tr(),
                  style: AppTextStyles.bodyBold.copyWith(
                    fontSize: vsFont,
                    color: color,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Center(
              child: _emojiBubble(
                rightEmoji,
                color,
                emojiSize,
                bubble,
                padding: bubblePad,
                compact: compact,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _emojiBubble(
    String emoji,
    Color color,
    double emojiFontSize,
    double diameter, {
    double padding = 12,
    bool compact = false,
  }) {
    return SizedBox(
      width: diameter,
      height: diameter,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color, color.withValues(alpha: 0.75)],
          ),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: compact ? 2.5 : 3,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: compact ? 12 : 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(emoji, style: TextStyle(fontSize: emojiFontSize)),
          ),
        ),
      ),
    );
  }

  static List<Widget> spellingLetterSection(String word, Color color) {
    final letters =
        word.characters.where((c) => c.trim().isNotEmpty).toList();
    return [
      const SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: letters
              .map(
                (letter) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: color.withValues(alpha: 0.65),
                      width: 2,
                    ),
                  ),
                  child: Text(
                    letter,
                    style: AppTextStyles.heading2.copyWith(color: color),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ];
  }

  static List<String> _scriptExampleWords(String id) {
    final words = <String>[];
    for (final slot in const ['w1', 'w2', 'w3']) {
      final word = _trOrEmpty('nativeScript.exampleWords.$id.$slot');
      if (word.trim().isNotEmpty) words.add(word);
    }
    if (words.isNotEmpty) return words;

    final legacy = _trOrEmpty('nativeScript.examples.$id');
    if (legacy.trim().isNotEmpty) words.add(legacy);
    return words;
  }

  static String _scriptSpeakPhrase({
    required String category,
    required String id,
    required String glyph,
    required String uiLanguageCode,
    required Map<String, String> args,
  }) {
    final speakLocale = NativeScriptData.speakLocaleFor(uiLanguageCode);
    final key = 'nativeScript.detail.$category.$id.speak';

    final fromSpeakLocale = _trInLocale(
      speakLocale,
      key,
      namedArgs: args,
    );
    if (fromSpeakLocale.trim().isNotEmpty) {
      return fromSpeakLocale;
    }

    if (uiLanguageCode == speakLocale) {
      final fromUi = _trOrEmpty(key, args: args);
      if (fromUi.trim().isNotEmpty) return fromUi;
    }

    return '';
  }

  /// Teaching phrase for TTS (e.g. ક કમળનો ક) in the script's speak locale.
  static String nativeScriptSpeakPhrase({
    required String category,
    required String id,
    required String glyph,
    required String uiLanguageCode,
  }) {
    final args = {
      'name': glyph,
      'glyph': glyph,
      'roman': '',
      'w1': '',
      'w2': '',
      'w3': '',
    };
    return _firstNonEmpty([
      _scriptSpeakPhrase(
        category: category,
        id: id,
        glyph: glyph,
        uiLanguageCode: uiLanguageCode,
        args: args,
      ),
      glyph,
    ]);
  }

  static LearningDetailPage scriptChar({
    required String id,
    required String glyph,
    required String roman,
    required String category,
    required Color accentColor,
    required String uiLanguageCode,
    double heroFontSize = 72,
  }) {
    final exampleWords = _scriptExampleWords(id);
    final args = {
      'name': glyph,
      'glyph': glyph,
      'roman': roman,
      'w1': exampleWords.isNotEmpty ? exampleWords[0] : '',
      'w2': exampleWords.length > 1 ? exampleWords[1] : '',
      'w3': exampleWords.length > 2 ? exampleWords[2] : '',
    };

    final about =
        _trOrEmpty('nativeScript.detail.$category.$id.about', args: args);
    final funFact =
        _trOrEmpty('nativeScript.detail.$category.$id.funFact', args: args);

    final tryThis = '';

    final speakLocale = NativeScriptData.speakLocaleFor(uiLanguageCode);
    final speakPhrase = _firstNonEmpty([
      _scriptSpeakPhrase(
        category: category,
        id: id,
        glyph: glyph,
        uiLanguageCode: uiLanguageCode,
        args: args,
      ),
      glyph,
    ]);
    final speak = _formatScriptSpeak(glyph, speakPhrase);

    return LearningDetailPage(
      title: glyph,
      subtitle: roman,
      speakText: speak,
      speakLanguageCode: speakLocale,
      hero: numberHero(glyph, accentColor, heroFontSize),
      about: about,
      funFact: funFact,
      tryThis: tryThis,
      exampleWords: exampleWords.isNotEmpty ? exampleWords : null,
      exampleWordsTitle: 'nativeScript.exampleWordsTitle'
          .tr(namedArgs: {'name': glyph}),
    );
  }

  static LearningDetailPage wordLabel({
    required String label,
    required String module,
    required String itemId,
    String emoji = '📅',
    String? imageAsset,
    String dialogHintKey = '',
  }) {
    final args = {'name': label};
    return LearningDetailPage(
      emoji: imageAsset == null ? emoji : null,
      hero: imageAsset != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                imageAsset,
                width: 168,
                height: 168,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Text(
                  emoji,
                  style: const TextStyle(fontSize: 72),
                ),
              ),
            )
          : null,
      heroInCircle: imageAsset == null,
      title: label,
      speakText: label,
      about: _firstNonEmpty([
        _trOrEmpty('$module.detail.$itemId.about', args: args),
        // Regional months (Hindu/Tamil) use templates — no per-item keys.
        _trOrEmpty('$module.detail.aboutTemplate', args: args),
        if (dialogHintKey.isNotEmpty) _trOrEmpty(dialogHintKey, args: args),
      ]),
      funFact: _firstNonEmpty([
        _trOrEmpty('$module.detail.$itemId.funFact', args: args),
        _trOrEmpty('$module.detail.funFactTemplate', args: args),
      ]),
      tryThis: _firstNonEmpty([
        _trOrEmpty('$module.detail.$itemId.try', args: args),
        _trOrEmpty('$module.detail.tryTemplate', args: args),
        _trOrEmpty('$module.readTogether', args: args),
      ]),
    );
  }
}

/// Helper to derive stable pair ids from translation keys.
class OppositePairKeys {
  final String leftKey;
  final String rightKey;

  const OppositePairKeys(this.leftKey, this.rightKey);

  String get id {
    final leftPart = leftKey.split('.');
    if (leftPart.length >= 3) return leftPart[2];
    return leftKey;
  }
}
