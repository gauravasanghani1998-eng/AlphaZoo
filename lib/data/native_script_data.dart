/// Swar (vowels) and Kakko (consonants) for Indian scripts.
library;

import 'gujarati_alphabet_data.dart';

class NativeScriptChar {
  final String id;
  final String glyph;
  final String romanKey;

  const NativeScriptChar({
    required this.id,
    required this.glyph,
    required this.romanKey,
  });

  String get roman => romanKey; // resolved via .tr() in UI
}

enum NativeScriptFamily { gujarati, devanagari, gurmukhi, tamil }

class NativeScriptData {
  NativeScriptData._();

  static NativeScriptFamily familyFor(String languageCode) {
    switch (languageCode) {
      case 'gu':
      case 'en':
        return NativeScriptFamily.gujarati;
      case 'pa':
        return NativeScriptFamily.gurmukhi;
      case 'ta':
        return NativeScriptFamily.tamil;
      case 'hi':
      case 'mr':
        return NativeScriptFamily.devanagari;
      default:
        return NativeScriptFamily.devanagari;
    }
  }

  static List<NativeScriptChar> swarFor(String languageCode) {
    return _swar[familyFor(languageCode)]!;
  }

  static List<NativeScriptChar> kakkoFor(String languageCode) {
    return _kakko[familyFor(languageCode)]!;
  }

  /// TTS / speak phrase language (may differ from UI locale, e.g. en UI → gu).
  static String speakLocaleFor(String uiLanguageCode) {
    switch (familyFor(uiLanguageCode)) {
      case NativeScriptFamily.gujarati:
        return 'gu';
      case NativeScriptFamily.gurmukhi:
        return 'pa';
      case NativeScriptFamily.tamil:
        return 'ta';
      case NativeScriptFamily.devanagari:
        return uiLanguageCode == 'mr' ? 'mr' : 'hi';
    }
  }

  static List<NativeScriptChar> _fromGujarati(List<GujaratiLetterItem> items) {
    return [
      for (final item in items)
        NativeScriptChar(
          id: item.id,
          glyph: item.glyph,
          romanKey: item.romanKey,
        ),
    ];
  }

  static final List<NativeScriptChar> _gujaratiSwar =
      _fromGujarati(GujaratiAlphabetData.swar);

  static final List<NativeScriptChar> _gujaratiKakko =
      _fromGujarati(GujaratiAlphabetData.kakko);

  static const List<NativeScriptChar> _devanagariSwar = [
    NativeScriptChar(id: 'a', glyph: 'अ', romanKey: 'nativeScript.roman.swar.a'),
    NativeScriptChar(id: 'aa', glyph: 'आ', romanKey: 'nativeScript.roman.swar.aa'),
    NativeScriptChar(id: 'i', glyph: 'इ', romanKey: 'nativeScript.roman.swar.i'),
    NativeScriptChar(id: 'ii', glyph: 'ई', romanKey: 'nativeScript.roman.swar.ii'),
    NativeScriptChar(id: 'u', glyph: 'उ', romanKey: 'nativeScript.roman.swar.u'),
    NativeScriptChar(id: 'uu', glyph: 'ऊ', romanKey: 'nativeScript.roman.swar.uu'),
    NativeScriptChar(id: 'ri', glyph: 'ऋ', romanKey: 'nativeScript.roman.swar.ri'),
    NativeScriptChar(id: 'e', glyph: 'ए', romanKey: 'nativeScript.roman.swar.e'),
    NativeScriptChar(id: 'ai', glyph: 'ऐ', romanKey: 'nativeScript.roman.swar.ai'),
    NativeScriptChar(id: 'o', glyph: 'ओ', romanKey: 'nativeScript.roman.swar.o'),
    NativeScriptChar(id: 'au', glyph: 'औ', romanKey: 'nativeScript.roman.swar.au'),
    NativeScriptChar(id: 'am', glyph: 'अं', romanKey: 'nativeScript.roman.swar.am'),
    NativeScriptChar(id: 'aha', glyph: 'अः', romanKey: 'nativeScript.roman.swar.aha'),
  ];

  static const List<NativeScriptChar> _devanagariKakko = [
    NativeScriptChar(id: 'ka', glyph: 'क', romanKey: 'nativeScript.roman.kakko.ka'),
    NativeScriptChar(id: 'kha', glyph: 'ख', romanKey: 'nativeScript.roman.kakko.kha'),
    NativeScriptChar(id: 'ga', glyph: 'ग', romanKey: 'nativeScript.roman.kakko.ga'),
    NativeScriptChar(id: 'gha', glyph: 'घ', romanKey: 'nativeScript.roman.kakko.gha'),
    NativeScriptChar(id: 'cha', glyph: 'च', romanKey: 'nativeScript.roman.kakko.cha'),
    NativeScriptChar(id: 'chha', glyph: 'छ', romanKey: 'nativeScript.roman.kakko.chha'),
    NativeScriptChar(id: 'ja', glyph: 'ज', romanKey: 'nativeScript.roman.kakko.ja'),
    NativeScriptChar(id: 'jha', glyph: 'झ', romanKey: 'nativeScript.roman.kakko.jha'),
    NativeScriptChar(id: 'tta', glyph: 'ट', romanKey: 'nativeScript.roman.kakko.tta'),
    NativeScriptChar(id: 'ttha', glyph: 'ठ', romanKey: 'nativeScript.roman.kakko.ttha'),
    NativeScriptChar(id: 'dda', glyph: 'ड', romanKey: 'nativeScript.roman.kakko.dda'),
    NativeScriptChar(id: 'ddha', glyph: 'ढ', romanKey: 'nativeScript.roman.kakko.ddha'),
    NativeScriptChar(id: 'nna', glyph: 'ण', romanKey: 'nativeScript.roman.kakko.nna'),
    NativeScriptChar(id: 'ta', glyph: 'त', romanKey: 'nativeScript.roman.kakko.ta'),
    NativeScriptChar(id: 'tha', glyph: 'थ', romanKey: 'nativeScript.roman.kakko.tha'),
    NativeScriptChar(id: 'da', glyph: 'द', romanKey: 'nativeScript.roman.kakko.da'),
    NativeScriptChar(id: 'dha', glyph: 'ध', romanKey: 'nativeScript.roman.kakko.dha'),
    NativeScriptChar(id: 'na', glyph: 'न', romanKey: 'nativeScript.roman.kakko.na'),
    NativeScriptChar(id: 'pa', glyph: 'प', romanKey: 'nativeScript.roman.kakko.pa'),
    NativeScriptChar(id: 'pha', glyph: 'फ', romanKey: 'nativeScript.roman.kakko.pha'),
    NativeScriptChar(id: 'ba', glyph: 'ब', romanKey: 'nativeScript.roman.kakko.ba'),
    NativeScriptChar(id: 'bha', glyph: 'भ', romanKey: 'nativeScript.roman.kakko.bha'),
    NativeScriptChar(id: 'ma', glyph: 'म', romanKey: 'nativeScript.roman.kakko.ma'),
    NativeScriptChar(id: 'ya', glyph: 'य', romanKey: 'nativeScript.roman.kakko.ya'),
    NativeScriptChar(id: 'ra', glyph: 'र', romanKey: 'nativeScript.roman.kakko.ra'),
    NativeScriptChar(id: 'la', glyph: 'ल', romanKey: 'nativeScript.roman.kakko.la'),
    NativeScriptChar(id: 'va', glyph: 'व', romanKey: 'nativeScript.roman.kakko.va'),
    NativeScriptChar(id: 'sha', glyph: 'श', romanKey: 'nativeScript.roman.kakko.sha'),
    NativeScriptChar(id: 'ssha', glyph: 'ष', romanKey: 'nativeScript.roman.kakko.ssha'),
    NativeScriptChar(id: 'sa', glyph: 'स', romanKey: 'nativeScript.roman.kakko.sa'),
    NativeScriptChar(id: 'ha', glyph: 'ह', romanKey: 'nativeScript.roman.kakko.ha'),
    NativeScriptChar(id: 'lla', glyph: 'ळ', romanKey: 'nativeScript.roman.kakko.lla'),
    NativeScriptChar(id: 'ksha', glyph: 'क्ष', romanKey: 'nativeScript.roman.kakko.ksha'),
    NativeScriptChar(id: 'gnya', glyph: 'ज्ञ', romanKey: 'nativeScript.roman.kakko.gnya'),
  ];

  static const List<NativeScriptChar> _gurmukhiSwar = [
    NativeScriptChar(id: 'a', glyph: 'ਅ', romanKey: 'nativeScript.roman.swar.a'),
    NativeScriptChar(id: 'aa', glyph: 'ਆ', romanKey: 'nativeScript.roman.swar.aa'),
    NativeScriptChar(id: 'i', glyph: 'ਇ', romanKey: 'nativeScript.roman.swar.i'),
    NativeScriptChar(id: 'ii', glyph: 'ਈ', romanKey: 'nativeScript.roman.swar.ii'),
    NativeScriptChar(id: 'u', glyph: 'ਉ', romanKey: 'nativeScript.roman.swar.u'),
    NativeScriptChar(id: 'uu', glyph: 'ਊ', romanKey: 'nativeScript.roman.swar.uu'),
    NativeScriptChar(id: 'ri', glyph: 'ੲ', romanKey: 'nativeScript.roman.swar.ri'),
    NativeScriptChar(id: 'e', glyph: 'ਏ', romanKey: 'nativeScript.roman.swar.e'),
    NativeScriptChar(id: 'ai', glyph: 'ਐ', romanKey: 'nativeScript.roman.swar.ai'),
    NativeScriptChar(id: 'o', glyph: 'ਓ', romanKey: 'nativeScript.roman.swar.o'),
    NativeScriptChar(id: 'au', glyph: 'ਔ', romanKey: 'nativeScript.roman.swar.au'),
    NativeScriptChar(id: 'am', glyph: 'ਅੰ', romanKey: 'nativeScript.roman.swar.am'),
    NativeScriptChar(id: 'aha', glyph: 'ੳ', romanKey: 'nativeScript.roman.swar.aha'),
  ];

  static const List<NativeScriptChar> _gurmukhiKakko = [
    NativeScriptChar(id: 'ka', glyph: 'ਕ', romanKey: 'nativeScript.roman.kakko.ka'),
    NativeScriptChar(id: 'kha', glyph: 'ਖ', romanKey: 'nativeScript.roman.kakko.kha'),
    NativeScriptChar(id: 'ga', glyph: 'ਗ', romanKey: 'nativeScript.roman.kakko.ga'),
    NativeScriptChar(id: 'gha', glyph: 'ਘ', romanKey: 'nativeScript.roman.kakko.gha'),
    NativeScriptChar(id: 'cha', glyph: 'ਚ', romanKey: 'nativeScript.roman.kakko.cha'),
    NativeScriptChar(id: 'chha', glyph: 'ਛ', romanKey: 'nativeScript.roman.kakko.chha'),
    NativeScriptChar(id: 'ja', glyph: 'ਜ', romanKey: 'nativeScript.roman.kakko.ja'),
    NativeScriptChar(id: 'jha', glyph: 'ਝ', romanKey: 'nativeScript.roman.kakko.jha'),
    NativeScriptChar(id: 'tta', glyph: 'ਟ', romanKey: 'nativeScript.roman.kakko.tta'),
    NativeScriptChar(id: 'ttha', glyph: 'ਠ', romanKey: 'nativeScript.roman.kakko.ttha'),
    NativeScriptChar(id: 'dda', glyph: 'ਡ', romanKey: 'nativeScript.roman.kakko.dda'),
    NativeScriptChar(id: 'ddha', glyph: 'ਢ', romanKey: 'nativeScript.roman.kakko.ddha'),
    NativeScriptChar(id: 'nna', glyph: 'ਣ', romanKey: 'nativeScript.roman.kakko.nna'),
    NativeScriptChar(id: 'ta', glyph: 'ਤ', romanKey: 'nativeScript.roman.kakko.ta'),
    NativeScriptChar(id: 'tha', glyph: 'ਥ', romanKey: 'nativeScript.roman.kakko.tha'),
    NativeScriptChar(id: 'da', glyph: 'ਦ', romanKey: 'nativeScript.roman.kakko.da'),
    NativeScriptChar(id: 'dha', glyph: 'ਧ', romanKey: 'nativeScript.roman.kakko.dha'),
    NativeScriptChar(id: 'na', glyph: 'ਨ', romanKey: 'nativeScript.roman.kakko.na'),
    NativeScriptChar(id: 'pa', glyph: 'ਪ', romanKey: 'nativeScript.roman.kakko.pa'),
    NativeScriptChar(id: 'pha', glyph: 'ਫ', romanKey: 'nativeScript.roman.kakko.pha'),
    NativeScriptChar(id: 'ba', glyph: 'ਬ', romanKey: 'nativeScript.roman.kakko.ba'),
    NativeScriptChar(id: 'bha', glyph: 'ਭ', romanKey: 'nativeScript.roman.kakko.bha'),
    NativeScriptChar(id: 'ma', glyph: 'ਮ', romanKey: 'nativeScript.roman.kakko.ma'),
    NativeScriptChar(id: 'ya', glyph: 'ਯ', romanKey: 'nativeScript.roman.kakko.ya'),
    NativeScriptChar(id: 'ra', glyph: 'ਰ', romanKey: 'nativeScript.roman.kakko.ra'),
    NativeScriptChar(id: 'la', glyph: 'ਲ', romanKey: 'nativeScript.roman.kakko.la'),
    NativeScriptChar(id: 'va', glyph: 'ਵ', romanKey: 'nativeScript.roman.kakko.va'),
    NativeScriptChar(id: 'sha', glyph: 'ਸ਼', romanKey: 'nativeScript.roman.kakko.sha'),
    NativeScriptChar(id: 'ssha', glyph: 'ਸ਼', romanKey: 'nativeScript.roman.kakko.ssha'),
    NativeScriptChar(id: 'sa', glyph: 'ਸ', romanKey: 'nativeScript.roman.kakko.sa'),
    NativeScriptChar(id: 'ha', glyph: 'ਹ', romanKey: 'nativeScript.roman.kakko.ha'),
    NativeScriptChar(id: 'lla', glyph: 'ਲ਼', romanKey: 'nativeScript.roman.kakko.lla'),
    NativeScriptChar(id: 'ksha', glyph: 'ਕ੍ਸ਼', romanKey: 'nativeScript.roman.kakko.ksha'),
    NativeScriptChar(id: 'gnya', glyph: 'ਗਿਆ', romanKey: 'nativeScript.roman.kakko.gnya'),
  ];

  static const List<NativeScriptChar> _tamilSwar = [
    NativeScriptChar(id: 'a', glyph: 'அ', romanKey: 'nativeScript.roman.swar.a'),
    NativeScriptChar(id: 'aa', glyph: 'ஆ', romanKey: 'nativeScript.roman.swar.aa'),
    NativeScriptChar(id: 'i', glyph: 'இ', romanKey: 'nativeScript.roman.swar.i'),
    NativeScriptChar(id: 'ii', glyph: 'ஈ', romanKey: 'nativeScript.roman.swar.ii'),
    NativeScriptChar(id: 'u', glyph: 'உ', romanKey: 'nativeScript.roman.swar.u'),
    NativeScriptChar(id: 'uu', glyph: 'ஊ', romanKey: 'nativeScript.roman.swar.uu'),
    NativeScriptChar(id: 'e', glyph: 'எ', romanKey: 'nativeScript.roman.swar.e'),
    NativeScriptChar(id: 'ai', glyph: 'ஐ', romanKey: 'nativeScript.roman.swar.ai'),
    NativeScriptChar(id: 'o', glyph: 'ஒ', romanKey: 'nativeScript.roman.swar.o'),
    NativeScriptChar(id: 'au', glyph: 'ஔ', romanKey: 'nativeScript.roman.swar.au'),
    NativeScriptChar(id: 'am', glyph: '\u0B82', romanKey: 'nativeScript.roman.swar.am'),
    NativeScriptChar(id: 'aha', glyph: 'ஃ', romanKey: 'nativeScript.roman.swar.aha'),
  ];

  static const List<NativeScriptChar> _tamilKakko = [
    NativeScriptChar(id: 'ka', glyph: 'க', romanKey: 'nativeScript.roman.kakko.ka'),
    NativeScriptChar(id: 'kha', glyph: 'க', romanKey: 'nativeScript.roman.kakko.kha'),
    NativeScriptChar(id: 'ga', glyph: 'க', romanKey: 'nativeScript.roman.kakko.ga'),
    NativeScriptChar(id: 'gha', glyph: 'க', romanKey: 'nativeScript.roman.kakko.gha'),
    NativeScriptChar(id: 'cha', glyph: 'ச', romanKey: 'nativeScript.roman.kakko.cha'),
    NativeScriptChar(id: 'chha', glyph: 'ச', romanKey: 'nativeScript.roman.kakko.chha'),
    NativeScriptChar(id: 'ja', glyph: 'ஜ', romanKey: 'nativeScript.roman.kakko.ja'),
    NativeScriptChar(id: 'jha', glyph: 'ஜ', romanKey: 'nativeScript.roman.kakko.jha'),
    NativeScriptChar(id: 'tta', glyph: 'ட', romanKey: 'nativeScript.roman.kakko.tta'),
    NativeScriptChar(id: 'ttha', glyph: 'ட', romanKey: 'nativeScript.roman.kakko.ttha'),
    NativeScriptChar(id: 'dda', glyph: 'ட', romanKey: 'nativeScript.roman.kakko.dda'),
    NativeScriptChar(id: 'ddha', glyph: 'ட', romanKey: 'nativeScript.roman.kakko.ddha'),
    NativeScriptChar(id: 'nna', glyph: 'ண', romanKey: 'nativeScript.roman.kakko.nna'),
    NativeScriptChar(id: 'ta', glyph: 'த', romanKey: 'nativeScript.roman.kakko.ta'),
    NativeScriptChar(id: 'tha', glyph: 'த', romanKey: 'nativeScript.roman.kakko.tha'),
    NativeScriptChar(id: 'da', glyph: 'த', romanKey: 'nativeScript.roman.kakko.da'),
    NativeScriptChar(id: 'dha', glyph: 'த', romanKey: 'nativeScript.roman.kakko.dha'),
    NativeScriptChar(id: 'na', glyph: 'ந', romanKey: 'nativeScript.roman.kakko.na'),
    NativeScriptChar(id: 'pa', glyph: 'ப', romanKey: 'nativeScript.roman.kakko.pa'),
    NativeScriptChar(id: 'pha', glyph: 'ப', romanKey: 'nativeScript.roman.kakko.pha'),
    NativeScriptChar(id: 'ba', glyph: 'ப', romanKey: 'nativeScript.roman.kakko.ba'),
    NativeScriptChar(id: 'bha', glyph: 'ப', romanKey: 'nativeScript.roman.kakko.bha'),
    NativeScriptChar(id: 'ma', glyph: 'ம', romanKey: 'nativeScript.roman.kakko.ma'),
    NativeScriptChar(id: 'ya', glyph: 'ய', romanKey: 'nativeScript.roman.kakko.ya'),
    NativeScriptChar(id: 'ra', glyph: 'ர', romanKey: 'nativeScript.roman.kakko.ra'),
    NativeScriptChar(id: 'la', glyph: 'ல', romanKey: 'nativeScript.roman.kakko.la'),
    NativeScriptChar(id: 'va', glyph: 'வ', romanKey: 'nativeScript.roman.kakko.va'),
    NativeScriptChar(id: 'sha', glyph: 'ஷ', romanKey: 'nativeScript.roman.kakko.sha'),
    NativeScriptChar(id: 'ssha', glyph: 'ஷ', romanKey: 'nativeScript.roman.kakko.ssha'),
    NativeScriptChar(id: 'sa', glyph: 'ஸ', romanKey: 'nativeScript.roman.kakko.sa'),
    NativeScriptChar(id: 'ha', glyph: 'ஹ', romanKey: 'nativeScript.roman.kakko.ha'),
    NativeScriptChar(id: 'lla', glyph: 'ள', romanKey: 'nativeScript.roman.kakko.lla'),
    NativeScriptChar(id: 'ksha', glyph: 'க்ஷ', romanKey: 'nativeScript.roman.kakko.ksha'),
    NativeScriptChar(id: 'gnya', glyph: 'ஞ', romanKey: 'nativeScript.roman.kakko.gnya'),
  ];

  static final Map<NativeScriptFamily, List<NativeScriptChar>> _swar = {
    NativeScriptFamily.gujarati: _gujaratiSwar,
    NativeScriptFamily.devanagari: _devanagariSwar,
    NativeScriptFamily.gurmukhi: _gurmukhiSwar,
    NativeScriptFamily.tamil: _tamilSwar,
  };

  static final Map<NativeScriptFamily, List<NativeScriptChar>> _kakko = {
    NativeScriptFamily.gujarati: _gujaratiKakko,
    NativeScriptFamily.devanagari: _devanagariKakko,
    NativeScriptFamily.gurmukhi: _gurmukhiKakko,
    NativeScriptFamily.tamil: _tamilKakko,
  };
}
