/// Kids-friendly Indic → Latin for single-pass English TTS.
///
/// Used when UI is English but Swar/Kakko sentences still contain Gujarati
/// (or other Indic) glyphs. Romanizing keeps one continuous utterance
/// instead of pausing on every language switch.
class IndicRomanizer {
  IndicRomanizer._();

  static final RegExp _indicRun = RegExp(
    r'[\u0900-\u097F\u0A00-\u0A7F\u0A80-\u0AFF\u0B80-\u0BFF]+',
  );

  /// Replaces each Indic run with a spaced roman form; leaves Latin as-is.
  static String forTts(String text) {
    return text.replaceAllMapped(_indicRun, (m) {
      final roman = _romanizeCluster(m.group(0)!).trim();
      if (roman.isEmpty) return m.group(0)!;
      // Capitalize so English TTS treats it like a clear word ("Ghar", "Anar").
      return '${roman[0].toUpperCase()}${roman.substring(1)}';
    });
  }

  static bool containsIndic(String text) => _indicRun.hasMatch(text);

  static String _romanizeCluster(String cluster) {
    // Prefer Gujarati / Devanagari / Gurmukhi / Tamil by first char.
    final code = cluster.runes.first;
    if (code >= 0x0A80 && code <= 0x0AFF) {
      return _romanizeGujarati(cluster);
    }
    if (code >= 0x0900 && code <= 0x097F) {
      return _romanizeDevanagari(cluster);
    }
    if (code >= 0x0A00 && code <= 0x0A7F) {
      return _romanizeGurmukhi(cluster);
    }
    if (code >= 0x0B80 && code <= 0x0BFF) {
      return _romanizeTamil(cluster);
    }
    return cluster;
  }

  // ── Gujarati ────────────────────────────────────────────────────────────

  static const _guVowels = <int, String>{
    0x0A85: 'a',
    0x0A86: 'aa',
    0x0A87: 'i',
    0x0A88: 'ee',
    0x0A89: 'u',
    0x0A8A: 'oo',
    0x0A8B: 'ri',
    0x0A8F: 'e',
    0x0A90: 'ai',
    0x0A93: 'o',
    0x0A94: 'au',
  };

  static const _guMatras = <int, String>{
    0x0ABE: 'aa',
    0x0ABF: 'i',
    0x0AC0: 'ee',
    0x0AC1: 'u',
    0x0AC2: 'oo',
    0x0AC3: 'ri',
    0x0AC7: 'e',
    0x0AC8: 'ai',
    0x0ACB: 'o',
    0x0ACC: 'au',
  };

  static const _guConsonants = <int, String>{
    0x0A95: 'k',
    0x0A96: 'kh',
    0x0A97: 'g',
    0x0A98: 'gh',
    0x0A99: 'ng',
    0x0A9A: 'ch',
    0x0A9B: 'chh',
    0x0A9C: 'j',
    0x0A9D: 'jh',
    0x0A9E: 'ny',
    0x0A9F: 't',
    0x0AA0: 'th',
    0x0AA1: 'd',
    0x0AA2: 'dh',
    0x0AA3: 'n',
    0x0AA4: 't',
    0x0AA5: 'th',
    0x0AA6: 'd',
    0x0AA7: 'dh',
    0x0AA8: 'n',
    0x0AAA: 'p',
    0x0AAB: 'ph',
    0x0AAC: 'b',
    0x0AAD: 'bh',
    0x0AAE: 'm',
    0x0AAF: 'y',
    0x0AB0: 'r',
    0x0AB2: 'l',
    0x0AB3: 'l',
    0x0AB5: 'v',
    0x0AB6: 'sh',
    0x0AB7: 'sh',
    0x0AB8: 's',
    0x0AB9: 'h',
  };

  static const _guVirama = 0x0ACD;
  static const _guAnusvara = 0x0A82;
  static const _guVisarga = 0x0A83;

  static String _romanizeGujarati(String text) => _romanizeBrahmic(
        text,
        vowels: _guVowels,
        matras: _guMatras,
        consonants: _guConsonants,
        virama: _guVirama,
        anusvara: _guAnusvara,
        visarga: _guVisarga,
      );

  // ── Devanagari ──────────────────────────────────────────────────────────

  static const _dvVowels = <int, String>{
    0x0905: 'a',
    0x0906: 'aa',
    0x0907: 'i',
    0x0908: 'ee',
    0x0909: 'u',
    0x090A: 'oo',
    0x090B: 'ri',
    0x090F: 'e',
    0x0910: 'ai',
    0x0913: 'o',
    0x0914: 'au',
  };

  static const _dvMatras = <int, String>{
    0x093E: 'aa',
    0x093F: 'i',
    0x0940: 'ee',
    0x0941: 'u',
    0x0942: 'oo',
    0x0943: 'ri',
    0x0947: 'e',
    0x0948: 'ai',
    0x094B: 'o',
    0x094C: 'au',
  };

  static const _dvConsonants = <int, String>{
    0x0915: 'k',
    0x0916: 'kh',
    0x0917: 'g',
    0x0918: 'gh',
    0x0919: 'ng',
    0x091A: 'ch',
    0x091B: 'chh',
    0x091C: 'j',
    0x091D: 'jh',
    0x091E: 'ny',
    0x091F: 't',
    0x0920: 'th',
    0x0921: 'd',
    0x0922: 'dh',
    0x0923: 'n',
    0x0924: 't',
    0x0925: 'th',
    0x0926: 'd',
    0x0927: 'dh',
    0x0928: 'n',
    0x092A: 'p',
    0x092B: 'ph',
    0x092C: 'b',
    0x092D: 'bh',
    0x092E: 'm',
    0x092F: 'y',
    0x0930: 'r',
    0x0932: 'l',
    0x0933: 'l',
    0x0935: 'v',
    0x0936: 'sh',
    0x0937: 'sh',
    0x0938: 's',
    0x0939: 'h',
  };

  static String _romanizeDevanagari(String text) => _romanizeBrahmic(
        text,
        vowels: _dvVowels,
        matras: _dvMatras,
        consonants: _dvConsonants,
        virama: 0x094D,
        anusvara: 0x0902,
        visarga: 0x0903,
      );

  // ── Gurmukhi (approx) ───────────────────────────────────────────────────

  static const _paVowels = <int, String>{
    0x0A05: 'a',
    0x0A06: 'aa',
    0x0A07: 'i',
    0x0A08: 'ee',
    0x0A09: 'u',
    0x0A0A: 'oo',
    0x0A0F: 'e',
    0x0A10: 'ai',
    0x0A13: 'o',
    0x0A14: 'au',
  };

  static const _paMatras = <int, String>{
    0x0A3E: 'aa',
    0x0A3F: 'i',
    0x0A40: 'ee',
    0x0A41: 'u',
    0x0A42: 'oo',
    0x0A47: 'e',
    0x0A48: 'ai',
    0x0A4B: 'o',
    0x0A4C: 'au',
  };

  static const _paConsonants = <int, String>{
    0x0A15: 'k',
    0x0A16: 'kh',
    0x0A17: 'g',
    0x0A18: 'gh',
    0x0A1A: 'ch',
    0x0A1B: 'chh',
    0x0A1C: 'j',
    0x0A1D: 'jh',
    0x0A1F: 't',
    0x0A20: 'th',
    0x0A21: 'd',
    0x0A22: 'dh',
    0x0A23: 'n',
    0x0A24: 't',
    0x0A25: 'th',
    0x0A26: 'd',
    0x0A27: 'dh',
    0x0A28: 'n',
    0x0A2A: 'p',
    0x0A2B: 'ph',
    0x0A2C: 'b',
    0x0A2D: 'bh',
    0x0A2E: 'm',
    0x0A2F: 'y',
    0x0A30: 'r',
    0x0A32: 'l',
    0x0A35: 'v',
    0x0A38: 's',
    0x0A39: 'h',
  };

  static String _romanizeGurmukhi(String text) => _romanizeBrahmic(
        text,
        vowels: _paVowels,
        matras: _paMatras,
        consonants: _paConsonants,
        virama: 0x0A4D,
        anusvara: 0x0A02,
        visarga: 0x0A03,
      );

  // ── Tamil (approx, kids TTS) ────────────────────────────────────────────

  static const _taVowels = <int, String>{
    0x0B85: 'a',
    0x0B86: 'aa',
    0x0B87: 'i',
    0x0B88: 'ee',
    0x0B89: 'u',
    0x0B8A: 'oo',
    0x0B8E: 'e',
    0x0B8F: 'ae',
    0x0B90: 'ai',
    0x0B92: 'o',
    0x0B93: 'oa',
    0x0B94: 'au',
  };

  static const _taMatras = <int, String>{
    0x0BBE: 'aa',
    0x0BBF: 'i',
    0x0BC0: 'ee',
    0x0BC1: 'u',
    0x0BC2: 'oo',
    0x0BC6: 'e',
    0x0BC7: 'ae',
    0x0BC8: 'ai',
    0x0BCA: 'o',
    0x0BCB: 'oa',
    0x0BCC: 'au',
  };

  static const _taConsonants = <int, String>{
    0x0B95: 'k',
    0x0B99: 'ng',
    0x0B9A: 'ch',
    0x0B9C: 'j',
    0x0B9E: 'ny',
    0x0B9F: 't',
    0x0BA3: 'n',
    0x0BA4: 'th',
    0x0BA8: 'n',
    0x0BA9: 'n',
    0x0BAA: 'p',
    0x0BAE: 'm',
    0x0BAF: 'y',
    0x0BB0: 'r',
    0x0BB1: 'r',
    0x0BB2: 'l',
    0x0BB3: 'l',
    0x0BB4: 'zh',
    0x0BB5: 'v',
    0x0BB7: 'sh',
    0x0BB8: 's',
    0x0BB9: 'h',
  };

  static String _romanizeTamil(String text) => _romanizeBrahmic(
        text,
        vowels: _taVowels,
        matras: _taMatras,
        consonants: _taConsonants,
        virama: 0x0BCD,
        anusvara: 0x0B82,
        visarga: 0x0B83,
      );

  /// Brahmic abugida → kids roman (consonant + inherent a, matra replaces a).
  static String _romanizeBrahmic(
    String text, {
    required Map<int, String> vowels,
    required Map<int, String> matras,
    required Map<int, String> consonants,
    required int virama,
    required int anusvara,
    required int visarga,
  }) {
    final out = StringBuffer();
    var pendingInherentA = false;

    void flushInherent() {
      if (pendingInherentA) {
        out.write('a');
        pendingInherentA = false;
      }
    }

    for (final code in text.runes) {
      if (vowels.containsKey(code)) {
        flushInherent();
        out.write(vowels[code]);
        continue;
      }
      if (consonants.containsKey(code)) {
        flushInherent();
        out.write(consonants[code]);
        pendingInherentA = true;
        continue;
      }
      if (matras.containsKey(code)) {
        pendingInherentA = false;
        out.write(matras[code]);
        continue;
      }
      if (code == virama) {
        pendingInherentA = false;
        continue;
      }
      if (code == anusvara) {
        flushInherent();
        out.write('n');
        continue;
      }
      if (code == visarga) {
        flushInherent();
        out.write('h');
        continue;
      }
      flushInherent();
    }
    flushInherent();
    return out.toString();
  }
}
