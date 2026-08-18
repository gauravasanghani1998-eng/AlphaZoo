import 'dart:ui';

import 'letter_stroke_data.dart';
import 'native_script_data.dart';

/// Normalized (0–1) centerline stroke guides for Indic letters.
///
/// Paths follow kid-friendly writing order and stay inside the typical
/// ink of each glyph when stretched to the on-screen letter box.
/// Latin A–Z guides are never used here.
class NativeScriptStrokeData {
  NativeScriptStrokeData._();

  static List<List<Offset>> strokesFor(
    String id, {
    NativeScriptFamily family = NativeScriptFamily.devanagari,
  }) {
    final table = switch (family) {
      NativeScriptFamily.tamil => _tamil,
      NativeScriptFamily.gujarati => _gujarati,
      NativeScriptFamily.gurmukhi => _gurmukhi,
      NativeScriptFamily.devanagari => _devanagari,
    };
    return table[id] ?? _devanagari[id] ?? _devanagari['ka']!;
  }

  static List<Offset> resamplePolyline(List<Offset> points, {int segments = 24}) {
    return LetterStrokeData.resamplePolyline(points, segments: segments);
  }

  // ── Shared helpers ──────────────────────────────────────────────────────

  static List<Offset> get _shiro => const [
        Offset(0.08, 0.10),
        Offset(0.92, 0.10),
      ];

  // ── Devanagari (hi / mr) ────────────────────────────────────────────────

  static final Map<String, List<List<Offset>>> _devanagari = {
    // Swar
    'a': [
      [
        Offset(0.70, 0.12),
        Offset(0.42, 0.10),
        Offset(0.22, 0.22),
        Offset(0.28, 0.40),
        Offset(0.55, 0.48),
        Offset(0.28, 0.58),
        Offset(0.22, 0.78),
        Offset(0.42, 0.94),
        Offset(0.70, 0.88),
      ],
    ],
    'aa': [
      [
        Offset(0.58, 0.12),
        Offset(0.32, 0.10),
        Offset(0.16, 0.24),
        Offset(0.22, 0.42),
        Offset(0.46, 0.50),
        Offset(0.22, 0.60),
        Offset(0.16, 0.80),
        Offset(0.34, 0.94),
        Offset(0.56, 0.88),
      ],
      [Offset(0.78, 0.10), Offset(0.78, 0.94)],
    ],
    'i': [
      [Offset(0.18, 0.10), Offset(0.82, 0.10)],
      [
        Offset(0.62, 0.10),
        Offset(0.72, 0.28),
        Offset(0.62, 0.50),
        Offset(0.48, 0.72),
        Offset(0.38, 0.94),
      ],
      [Offset(0.70, 0.02), Offset(0.82, 0.14)],
    ],
    'ii': [
      [Offset(0.18, 0.10), Offset(0.82, 0.10)],
      [
        Offset(0.62, 0.10),
        Offset(0.72, 0.28),
        Offset(0.62, 0.50),
        Offset(0.48, 0.72),
        Offset(0.38, 0.94),
      ],
      [Offset(0.62, 0.02), Offset(0.72, 0.12)],
      [Offset(0.76, 0.02), Offset(0.86, 0.12)],
    ],
    'u': [
      [
        Offset(0.28, 0.12),
        Offset(0.28, 0.62),
        Offset(0.38, 0.82),
        Offset(0.58, 0.92),
        Offset(0.78, 0.78),
      ],
    ],
    'uu': [
      [
        Offset(0.28, 0.12),
        Offset(0.28, 0.58),
        Offset(0.38, 0.78),
        Offset(0.58, 0.90),
        Offset(0.78, 0.74),
      ],
      [Offset(0.48, 0.94), Offset(0.72, 0.98)],
    ],
    'ri': [
      [
        Offset(0.22, 0.12),
        Offset(0.22, 0.70),
        Offset(0.38, 0.90),
        Offset(0.62, 0.78),
      ],
      [
        Offset(0.22, 0.42),
        Offset(0.55, 0.28),
        Offset(0.78, 0.42),
        Offset(0.70, 0.62),
      ],
    ],
    'e': [
      _shiro,
      [
        Offset(0.55, 0.10),
        Offset(0.55, 0.94),
      ],
      [
        Offset(0.55, 0.42),
        Offset(0.28, 0.55),
        Offset(0.30, 0.82),
        Offset(0.52, 0.92),
      ],
    ],
    'ai': [
      _shiro,
      [Offset(0.48, 0.10), Offset(0.48, 0.94)],
      [Offset(0.68, 0.10), Offset(0.68, 0.94)],
      [
        Offset(0.48, 0.42),
        Offset(0.24, 0.55),
        Offset(0.26, 0.82),
        Offset(0.46, 0.92),
      ],
    ],
    'o': [
      _shiro,
      [
        Offset(0.30, 0.12),
        Offset(0.22, 0.28),
        Offset(0.28, 0.48),
        Offset(0.50, 0.42),
        Offset(0.50, 0.94),
      ],
      [Offset(0.72, 0.10), Offset(0.72, 0.94)],
    ],
    'au': [
      _shiro,
      [
        Offset(0.26, 0.12),
        Offset(0.18, 0.30),
        Offset(0.26, 0.50),
        Offset(0.44, 0.44),
        Offset(0.44, 0.94),
      ],
      [Offset(0.62, 0.10), Offset(0.62, 0.94)],
      [Offset(0.80, 0.10), Offset(0.80, 0.94)],
    ],
    'am': [
      [
        Offset(0.68, 0.14),
        Offset(0.40, 0.12),
        Offset(0.22, 0.26),
        Offset(0.28, 0.44),
        Offset(0.52, 0.52),
        Offset(0.28, 0.62),
        Offset(0.22, 0.80),
        Offset(0.42, 0.94),
        Offset(0.68, 0.88),
      ],
      [Offset(0.78, 0.02), Offset(0.86, 0.12)],
    ],
    'aha': [
      [
        Offset(0.62, 0.14),
        Offset(0.36, 0.12),
        Offset(0.18, 0.26),
        Offset(0.24, 0.44),
        Offset(0.48, 0.52),
        Offset(0.24, 0.62),
        Offset(0.18, 0.80),
        Offset(0.38, 0.94),
        Offset(0.62, 0.88),
      ],
      [Offset(0.78, 0.38), Offset(0.78, 0.48)],
      [Offset(0.78, 0.62), Offset(0.78, 0.72)],
    ],

    // Kakko
    'ka': [
      _shiro,
      [Offset(0.62, 0.10), Offset(0.62, 0.94)],
      [
        Offset(0.62, 0.38),
        Offset(0.38, 0.28),
        Offset(0.22, 0.42),
        Offset(0.30, 0.62),
        Offset(0.52, 0.70),
        Offset(0.38, 0.88),
      ],
    ],
    'kha': [
      _shiro,
      [Offset(0.68, 0.10), Offset(0.68, 0.94)],
      [
        Offset(0.30, 0.22),
        Offset(0.22, 0.42),
        Offset(0.34, 0.62),
        Offset(0.58, 0.52),
        Offset(0.50, 0.78),
        Offset(0.34, 0.92),
      ],
      [Offset(0.42, 0.02), Offset(0.50, 0.12)],
    ],
    'ga': [
      _shiro,
      [Offset(0.70, 0.10), Offset(0.70, 0.94)],
      [
        Offset(0.70, 0.36),
        Offset(0.42, 0.28),
        Offset(0.24, 0.42),
        Offset(0.28, 0.68),
        Offset(0.48, 0.88),
      ],
    ],
    'gha': [
      _shiro,
      [Offset(0.72, 0.10), Offset(0.72, 0.94)],
      [
        Offset(0.28, 0.22),
        Offset(0.22, 0.48),
        Offset(0.40, 0.70),
        Offset(0.62, 0.58),
      ],
      [
        Offset(0.40, 0.48),
        Offset(0.28, 0.72),
        Offset(0.42, 0.92),
      ],
    ],
    'cha': [
      _shiro,
      [
        Offset(0.28, 0.22),
        Offset(0.22, 0.48),
        Offset(0.40, 0.72),
        Offset(0.68, 0.58),
        Offset(0.72, 0.28),
        Offset(0.55, 0.18),
      ],
      [Offset(0.55, 0.48), Offset(0.55, 0.94)],
    ],
    'chha': [
      _shiro,
      [
        Offset(0.50, 0.18),
        Offset(0.28, 0.28),
        Offset(0.22, 0.52),
        Offset(0.40, 0.78),
        Offset(0.70, 0.70),
        Offset(0.78, 0.40),
        Offset(0.62, 0.22),
      ],
      [Offset(0.50, 0.48), Offset(0.42, 0.72), Offset(0.50, 0.94)],
    ],
    'ja': [
      _shiro,
      [Offset(0.55, 0.10), Offset(0.55, 0.94)],
      [
        Offset(0.28, 0.28),
        Offset(0.42, 0.48),
        Offset(0.28, 0.68),
        Offset(0.42, 0.88),
      ],
      [
        Offset(0.55, 0.36),
        Offset(0.78, 0.28),
        Offset(0.82, 0.50),
        Offset(0.68, 0.62),
      ],
    ],
    'jha': [
      _shiro,
      [Offset(0.58, 0.10), Offset(0.58, 0.94)],
      [
        Offset(0.26, 0.26),
        Offset(0.40, 0.46),
        Offset(0.26, 0.66),
        Offset(0.40, 0.88),
      ],
      [
        Offset(0.58, 0.34),
        Offset(0.80, 0.26),
        Offset(0.84, 0.48),
        Offset(0.70, 0.60),
      ],
      [Offset(0.72, 0.02), Offset(0.80, 0.12)],
    ],
    'tta': [
      _shiro,
      [
        Offset(0.55, 0.18),
        Offset(0.32, 0.28),
        Offset(0.28, 0.55),
        Offset(0.48, 0.78),
        Offset(0.72, 0.62),
        Offset(0.70, 0.32),
      ],
      [Offset(0.55, 0.55), Offset(0.55, 0.94)],
    ],
    'ttha': [
      _shiro,
      [
        Offset(0.55, 0.20),
        Offset(0.30, 0.32),
        Offset(0.28, 0.58),
        Offset(0.50, 0.80),
        Offset(0.74, 0.62),
        Offset(0.70, 0.34),
      ],
      [Offset(0.55, 0.02), Offset(0.55, 0.20)],
      [Offset(0.55, 0.55), Offset(0.55, 0.94)],
    ],
    'dda': [
      _shiro,
      [
        Offset(0.32, 0.22),
        Offset(0.28, 0.50),
        Offset(0.48, 0.78),
        Offset(0.72, 0.58),
        Offset(0.68, 0.28),
        Offset(0.48, 0.22),
      ],
      [Offset(0.55, 0.50), Offset(0.55, 0.94)],
    ],
    'ddha': [
      _shiro,
      [
        Offset(0.32, 0.24),
        Offset(0.28, 0.52),
        Offset(0.48, 0.80),
        Offset(0.72, 0.60),
        Offset(0.68, 0.30),
        Offset(0.48, 0.24),
      ],
      [Offset(0.55, 0.02), Offset(0.55, 0.22)],
      [Offset(0.55, 0.52), Offset(0.55, 0.94)],
    ],
    'nna': [
      _shiro,
      [
        Offset(0.28, 0.22),
        Offset(0.28, 0.70),
        Offset(0.45, 0.90),
        Offset(0.70, 0.78),
      ],
      [
        Offset(0.28, 0.42),
        Offset(0.55, 0.32),
        Offset(0.75, 0.48),
        Offset(0.68, 0.70),
      ],
    ],
    'ta': [
      _shiro,
      [
        Offset(0.55, 0.10),
        Offset(0.55, 0.55),
        Offset(0.35, 0.72),
        Offset(0.30, 0.90),
        Offset(0.52, 0.94),
        Offset(0.72, 0.82),
      ],
      [
        Offset(0.55, 0.28),
        Offset(0.78, 0.22),
        Offset(0.82, 0.42),
        Offset(0.68, 0.52),
      ],
    ],
    'tha': [
      _shiro,
      [
        Offset(0.50, 0.20),
        Offset(0.30, 0.32),
        Offset(0.28, 0.58),
        Offset(0.48, 0.80),
        Offset(0.72, 0.68),
        Offset(0.74, 0.38),
        Offset(0.58, 0.22),
      ],
      [Offset(0.50, 0.50), Offset(0.50, 0.94)],
    ],
    'da': [
      _shiro,
      [
        Offset(0.28, 0.18),
        Offset(0.28, 0.55),
        Offset(0.42, 0.78),
        Offset(0.68, 0.70),
        Offset(0.72, 0.40),
        Offset(0.55, 0.28),
        Offset(0.42, 0.42),
      ],
      [Offset(0.55, 0.55), Offset(0.55, 0.94)],
    ],
    'dha': [
      _shiro,
      [Offset(0.62, 0.10), Offset(0.62, 0.94)],
      [
        Offset(0.28, 0.22),
        Offset(0.22, 0.48),
        Offset(0.38, 0.70),
        Offset(0.58, 0.55),
      ],
      [Offset(0.42, 0.02), Offset(0.50, 0.12)],
    ],
    'na': [
      _shiro,
      [Offset(0.62, 0.10), Offset(0.62, 0.94)],
      [
        Offset(0.62, 0.38),
        Offset(0.35, 0.28),
        Offset(0.22, 0.48),
        Offset(0.30, 0.72),
        Offset(0.50, 0.88),
      ],
    ],
    'pa': [
      _shiro,
      [Offset(0.55, 0.10), Offset(0.55, 0.94)],
      [
        Offset(0.28, 0.28),
        Offset(0.28, 0.70),
        Offset(0.42, 0.88),
        Offset(0.55, 0.72),
      ],
    ],
    'pha': [
      _shiro,
      [Offset(0.55, 0.10), Offset(0.55, 0.94)],
      [
        Offset(0.28, 0.28),
        Offset(0.28, 0.70),
        Offset(0.42, 0.88),
        Offset(0.55, 0.72),
      ],
      [Offset(0.38, 0.02), Offset(0.46, 0.12)],
    ],
    'ba': [
      _shiro,
      [Offset(0.58, 0.10), Offset(0.58, 0.94)],
      [
        Offset(0.28, 0.28),
        Offset(0.28, 0.55),
        Offset(0.45, 0.70),
        Offset(0.58, 0.55),
      ],
      [
        Offset(0.28, 0.55),
        Offset(0.28, 0.78),
        Offset(0.45, 0.92),
        Offset(0.58, 0.78),
      ],
    ],
    'bha': [
      _shiro,
      [Offset(0.62, 0.10), Offset(0.62, 0.94)],
      [
        Offset(0.28, 0.28),
        Offset(0.28, 0.72),
        Offset(0.48, 0.88),
        Offset(0.62, 0.68),
      ],
      [
        Offset(0.28, 0.48),
        Offset(0.50, 0.38),
        Offset(0.62, 0.52),
      ],
    ],
    'ma': [
      _shiro,
      [Offset(0.55, 0.10), Offset(0.55, 0.94)],
      [
        Offset(0.28, 0.28),
        Offset(0.28, 0.70),
        Offset(0.42, 0.88),
        Offset(0.55, 0.70),
      ],
      [
        Offset(0.55, 0.28),
        Offset(0.75, 0.22),
        Offset(0.80, 0.45),
        Offset(0.65, 0.58),
      ],
    ],
    'ya': [
      _shiro,
      [
        Offset(0.28, 0.22),
        Offset(0.28, 0.70),
        Offset(0.45, 0.90),
        Offset(0.70, 0.75),
      ],
      [
        Offset(0.28, 0.42),
        Offset(0.55, 0.30),
        Offset(0.72, 0.48),
      ],
      [Offset(0.55, 0.48), Offset(0.55, 0.94)],
    ],
    'ra': [
      _shiro,
      [
        Offset(0.55, 0.10),
        Offset(0.55, 0.55),
        Offset(0.35, 0.78),
        Offset(0.48, 0.94),
      ],
    ],
    'la': [
      _shiro,
      [Offset(0.55, 0.10), Offset(0.55, 0.94)],
      [
        Offset(0.28, 0.28),
        Offset(0.28, 0.70),
        Offset(0.45, 0.88),
        Offset(0.55, 0.70),
      ],
      [
        Offset(0.28, 0.48),
        Offset(0.48, 0.38),
      ],
    ],
    'va': [
      _shiro,
      [Offset(0.58, 0.10), Offset(0.58, 0.94)],
      [
        Offset(0.30, 0.28),
        Offset(0.24, 0.52),
        Offset(0.40, 0.78),
        Offset(0.58, 0.60),
      ],
    ],
    'sha': [
      _shiro,
      [
        Offset(0.28, 0.22),
        Offset(0.28, 0.55),
        Offset(0.48, 0.72),
        Offset(0.70, 0.55),
        Offset(0.70, 0.22),
      ],
      [Offset(0.48, 0.48), Offset(0.48, 0.94)],
    ],
    'ssha': [
      _shiro,
      [Offset(0.62, 0.10), Offset(0.62, 0.94)],
      [
        Offset(0.28, 0.28),
        Offset(0.28, 0.70),
        Offset(0.45, 0.88),
        Offset(0.62, 0.70),
      ],
      [
        Offset(0.28, 0.48),
        Offset(0.50, 0.36),
      ],
    ],
    'sa': [
      _shiro,
      [Offset(0.62, 0.10), Offset(0.62, 0.94)],
      [
        Offset(0.28, 0.28),
        Offset(0.28, 0.55),
        Offset(0.45, 0.70),
        Offset(0.62, 0.55),
      ],
      [
        Offset(0.28, 0.55),
        Offset(0.28, 0.78),
        Offset(0.45, 0.92),
        Offset(0.62, 0.78),
      ],
    ],
    'ha': [
      _shiro,
      [
        Offset(0.30, 0.22),
        Offset(0.28, 0.55),
        Offset(0.48, 0.78),
        Offset(0.72, 0.58),
      ],
      [
        Offset(0.48, 0.42),
        Offset(0.55, 0.70),
        Offset(0.48, 0.94),
      ],
    ],
    'lla': [
      _shiro,
      [Offset(0.55, 0.10), Offset(0.55, 0.94)],
      [
        Offset(0.28, 0.28),
        Offset(0.28, 0.70),
        Offset(0.45, 0.88),
        Offset(0.55, 0.70),
      ],
      [
        Offset(0.28, 0.48),
        Offset(0.48, 0.38),
      ],
      [Offset(0.42, 0.92), Offset(0.58, 0.98)],
    ],
    'ksha': [
      _shiro,
      [Offset(0.58, 0.10), Offset(0.58, 0.94)],
      [
        Offset(0.58, 0.36),
        Offset(0.35, 0.26),
        Offset(0.20, 0.42),
        Offset(0.28, 0.62),
        Offset(0.48, 0.70),
      ],
      [
        Offset(0.58, 0.48),
        Offset(0.78, 0.38),
        Offset(0.82, 0.60),
        Offset(0.68, 0.74),
      ],
    ],
    'gnya': [
      _shiro,
      [Offset(0.50, 0.10), Offset(0.50, 0.94)],
      [
        Offset(0.26, 0.28),
        Offset(0.38, 0.48),
        Offset(0.26, 0.68),
        Offset(0.38, 0.88),
      ],
      [
        Offset(0.50, 0.34),
        Offset(0.72, 0.26),
        Offset(0.78, 0.48),
        Offset(0.62, 0.60),
      ],
      [
        Offset(0.62, 0.48),
        Offset(0.78, 0.70),
        Offset(0.70, 0.92),
      ],
    ],
  };

  // ── Gujarati (gu / en) — no full shirorekha; stems + bowls ──────────────

  static final Map<String, List<List<Offset>>> _gujarati = {
    'a': [
      [
        Offset(0.72, 0.14),
        Offset(0.45, 0.10),
        Offset(0.24, 0.24),
        Offset(0.30, 0.42),
        Offset(0.55, 0.50),
        Offset(0.30, 0.60),
        Offset(0.24, 0.80),
        Offset(0.45, 0.94),
        Offset(0.72, 0.86),
      ],
    ],
    'aa': [
      [
        Offset(0.58, 0.14),
        Offset(0.34, 0.10),
        Offset(0.18, 0.26),
        Offset(0.24, 0.44),
        Offset(0.48, 0.52),
        Offset(0.24, 0.62),
        Offset(0.18, 0.82),
        Offset(0.36, 0.94),
        Offset(0.56, 0.86),
      ],
      [Offset(0.78, 0.10), Offset(0.78, 0.94)],
    ],
    'i': [
      [
        Offset(0.55, 0.08),
        Offset(0.70, 0.22),
        Offset(0.62, 0.48),
        Offset(0.48, 0.72),
        Offset(0.40, 0.94),
      ],
      [Offset(0.68, 0.02), Offset(0.80, 0.14)],
    ],
    'ii': [
      [
        Offset(0.52, 0.08),
        Offset(0.68, 0.22),
        Offset(0.60, 0.48),
        Offset(0.46, 0.72),
        Offset(0.38, 0.94),
      ],
      [Offset(0.60, 0.02), Offset(0.70, 0.12)],
      [Offset(0.74, 0.02), Offset(0.84, 0.12)],
    ],
    'u': [
      [
        Offset(0.32, 0.12),
        Offset(0.32, 0.62),
        Offset(0.42, 0.82),
        Offset(0.62, 0.92),
        Offset(0.80, 0.76),
      ],
    ],
    'uu': [
      [
        Offset(0.32, 0.12),
        Offset(0.32, 0.58),
        Offset(0.42, 0.78),
        Offset(0.62, 0.90),
        Offset(0.80, 0.72),
      ],
      [Offset(0.50, 0.94), Offset(0.74, 0.98)],
    ],
    'ri': _devanagari['ri']!,
    'e': [
      [Offset(0.55, 0.10), Offset(0.55, 0.94)],
      [
        Offset(0.55, 0.40),
        Offset(0.28, 0.52),
        Offset(0.30, 0.80),
        Offset(0.52, 0.92),
      ],
    ],
    'ai': [
      [Offset(0.45, 0.10), Offset(0.45, 0.94)],
      [Offset(0.68, 0.10), Offset(0.68, 0.94)],
      [
        Offset(0.45, 0.40),
        Offset(0.22, 0.52),
        Offset(0.24, 0.80),
        Offset(0.44, 0.92),
      ],
    ],
    'o': [
      [
        Offset(0.32, 0.14),
        Offset(0.24, 0.32),
        Offset(0.32, 0.52),
        Offset(0.52, 0.44),
        Offset(0.52, 0.94),
      ],
      [Offset(0.74, 0.10), Offset(0.74, 0.94)],
    ],
    'au': [
      [
        Offset(0.26, 0.14),
        Offset(0.18, 0.32),
        Offset(0.28, 0.52),
        Offset(0.44, 0.44),
        Offset(0.44, 0.94),
      ],
      [Offset(0.62, 0.10), Offset(0.62, 0.94)],
      [Offset(0.80, 0.10), Offset(0.80, 0.94)],
    ],
    'am': [
      [
        Offset(0.72, 0.14),
        Offset(0.45, 0.10),
        Offset(0.24, 0.24),
        Offset(0.30, 0.42),
        Offset(0.55, 0.50),
        Offset(0.30, 0.60),
        Offset(0.24, 0.80),
        Offset(0.45, 0.94),
        Offset(0.72, 0.86),
      ],
      [Offset(0.80, 0.02), Offset(0.88, 0.12)],
    ],
    'aha': [
      [
        Offset(0.72, 0.14),
        Offset(0.45, 0.10),
        Offset(0.24, 0.24),
        Offset(0.30, 0.42),
        Offset(0.55, 0.50),
        Offset(0.30, 0.60),
        Offset(0.24, 0.80),
        Offset(0.45, 0.94),
        Offset(0.72, 0.86),
      ],
      [Offset(0.82, 0.38), Offset(0.82, 0.48)],
      [Offset(0.82, 0.62), Offset(0.82, 0.72)],
    ],
    'ka': [
      [Offset(0.62, 0.10), Offset(0.62, 0.94)],
      [
        Offset(0.62, 0.36),
        Offset(0.38, 0.26),
        Offset(0.22, 0.42),
        Offset(0.30, 0.64),
        Offset(0.52, 0.72),
        Offset(0.38, 0.90),
      ],
    ],
    'kha': [
      [Offset(0.68, 0.10), Offset(0.68, 0.94)],
      [
        Offset(0.30, 0.20),
        Offset(0.22, 0.42),
        Offset(0.36, 0.64),
        Offset(0.58, 0.52),
        Offset(0.50, 0.78),
        Offset(0.34, 0.92),
      ],
    ],
    'ga': [
      [Offset(0.70, 0.10), Offset(0.70, 0.94)],
      [
        Offset(0.70, 0.34),
        Offset(0.42, 0.26),
        Offset(0.24, 0.42),
        Offset(0.28, 0.70),
        Offset(0.48, 0.90),
      ],
    ],
    'gha': [
      [Offset(0.72, 0.10), Offset(0.72, 0.94)],
      [
        Offset(0.28, 0.20),
        Offset(0.22, 0.48),
        Offset(0.40, 0.72),
        Offset(0.62, 0.58),
      ],
      [Offset(0.40, 0.48), Offset(0.28, 0.72), Offset(0.42, 0.92)],
    ],
    'cha': [
      [
        Offset(0.28, 0.20),
        Offset(0.22, 0.48),
        Offset(0.40, 0.74),
        Offset(0.68, 0.58),
        Offset(0.72, 0.28),
        Offset(0.55, 0.16),
      ],
      [Offset(0.55, 0.48), Offset(0.55, 0.94)],
    ],
    'chha': [
      [
        Offset(0.50, 0.16),
        Offset(0.28, 0.28),
        Offset(0.22, 0.52),
        Offset(0.40, 0.80),
        Offset(0.70, 0.70),
        Offset(0.78, 0.40),
        Offset(0.62, 0.20),
      ],
      [Offset(0.50, 0.48), Offset(0.42, 0.72), Offset(0.50, 0.94)],
    ],
    'ja': [
      [Offset(0.55, 0.10), Offset(0.55, 0.94)],
      [
        Offset(0.28, 0.26),
        Offset(0.42, 0.48),
        Offset(0.28, 0.68),
        Offset(0.42, 0.88),
      ],
      [
        Offset(0.55, 0.34),
        Offset(0.78, 0.26),
        Offset(0.82, 0.50),
        Offset(0.68, 0.62),
      ],
    ],
    'jha': [
      [Offset(0.58, 0.10), Offset(0.58, 0.94)],
      [
        Offset(0.26, 0.24),
        Offset(0.40, 0.46),
        Offset(0.26, 0.66),
        Offset(0.40, 0.88),
      ],
      [
        Offset(0.58, 0.32),
        Offset(0.80, 0.24),
        Offset(0.84, 0.48),
        Offset(0.70, 0.60),
      ],
    ],
    'tta': [
      [
        Offset(0.55, 0.16),
        Offset(0.32, 0.28),
        Offset(0.28, 0.55),
        Offset(0.48, 0.80),
        Offset(0.72, 0.62),
        Offset(0.70, 0.30),
      ],
      [Offset(0.55, 0.55), Offset(0.55, 0.94)],
    ],
    'ttha': [
      [
        Offset(0.55, 0.18),
        Offset(0.30, 0.32),
        Offset(0.28, 0.58),
        Offset(0.50, 0.82),
        Offset(0.74, 0.62),
        Offset(0.70, 0.32),
      ],
      [Offset(0.55, 0.55), Offset(0.55, 0.94)],
    ],
    'dda': [
      [
        Offset(0.32, 0.20),
        Offset(0.28, 0.50),
        Offset(0.48, 0.80),
        Offset(0.72, 0.58),
        Offset(0.68, 0.26),
        Offset(0.48, 0.20),
      ],
      [Offset(0.55, 0.50), Offset(0.55, 0.94)],
    ],
    'ddha': [
      [
        Offset(0.32, 0.22),
        Offset(0.28, 0.52),
        Offset(0.48, 0.82),
        Offset(0.72, 0.60),
        Offset(0.68, 0.28),
        Offset(0.48, 0.22),
      ],
      [Offset(0.55, 0.52), Offset(0.55, 0.94)],
    ],
    'nna': [
      [
        Offset(0.28, 0.18),
        Offset(0.28, 0.70),
        Offset(0.45, 0.92),
        Offset(0.72, 0.78),
      ],
      [
        Offset(0.28, 0.40),
        Offset(0.55, 0.30),
        Offset(0.75, 0.48),
        Offset(0.68, 0.70),
      ],
    ],
    'ta': [
      [
        Offset(0.55, 0.10),
        Offset(0.55, 0.55),
        Offset(0.35, 0.72),
        Offset(0.30, 0.90),
        Offset(0.52, 0.94),
        Offset(0.72, 0.82),
      ],
      [
        Offset(0.55, 0.26),
        Offset(0.78, 0.20),
        Offset(0.82, 0.42),
        Offset(0.68, 0.52),
      ],
    ],
    'tha': [
      [
        Offset(0.50, 0.18),
        Offset(0.30, 0.30),
        Offset(0.28, 0.58),
        Offset(0.48, 0.82),
        Offset(0.72, 0.68),
        Offset(0.74, 0.36),
        Offset(0.58, 0.20),
      ],
      [Offset(0.50, 0.50), Offset(0.50, 0.94)],
    ],
    'da': [
      [
        Offset(0.28, 0.16),
        Offset(0.28, 0.55),
        Offset(0.42, 0.80),
        Offset(0.68, 0.70),
        Offset(0.72, 0.38),
        Offset(0.55, 0.26),
        Offset(0.42, 0.42),
      ],
      [Offset(0.55, 0.55), Offset(0.55, 0.94)],
    ],
    'dha': [
      [Offset(0.62, 0.10), Offset(0.62, 0.94)],
      [
        Offset(0.28, 0.20),
        Offset(0.22, 0.48),
        Offset(0.38, 0.72),
        Offset(0.58, 0.55),
      ],
    ],
    'na': [
      [Offset(0.62, 0.10), Offset(0.62, 0.94)],
      [
        Offset(0.62, 0.36),
        Offset(0.35, 0.26),
        Offset(0.22, 0.48),
        Offset(0.30, 0.74),
        Offset(0.50, 0.90),
      ],
    ],
    'pa': [
      [Offset(0.55, 0.10), Offset(0.55, 0.94)],
      [
        Offset(0.28, 0.26),
        Offset(0.28, 0.70),
        Offset(0.42, 0.90),
        Offset(0.55, 0.72),
      ],
    ],
    'pha': [
      [Offset(0.55, 0.10), Offset(0.55, 0.94)],
      [
        Offset(0.28, 0.26),
        Offset(0.28, 0.70),
        Offset(0.42, 0.90),
        Offset(0.55, 0.72),
      ],
      [Offset(0.38, 0.02), Offset(0.48, 0.12)],
    ],
    'ba': [
      [Offset(0.58, 0.10), Offset(0.58, 0.94)],
      [
        Offset(0.28, 0.26),
        Offset(0.28, 0.55),
        Offset(0.45, 0.70),
        Offset(0.58, 0.55),
      ],
      [
        Offset(0.28, 0.55),
        Offset(0.28, 0.78),
        Offset(0.45, 0.92),
        Offset(0.58, 0.78),
      ],
    ],
    'bha': [
      [Offset(0.62, 0.10), Offset(0.62, 0.94)],
      [
        Offset(0.28, 0.26),
        Offset(0.28, 0.72),
        Offset(0.48, 0.90),
        Offset(0.62, 0.68),
      ],
      [Offset(0.28, 0.48), Offset(0.50, 0.36), Offset(0.62, 0.52)],
    ],
    'ma': [
      [Offset(0.55, 0.10), Offset(0.55, 0.94)],
      [
        Offset(0.28, 0.26),
        Offset(0.28, 0.70),
        Offset(0.42, 0.90),
        Offset(0.55, 0.70),
      ],
      [
        Offset(0.55, 0.26),
        Offset(0.75, 0.20),
        Offset(0.80, 0.45),
        Offset(0.65, 0.58),
      ],
    ],
    'ya': [
      [
        Offset(0.28, 0.18),
        Offset(0.28, 0.70),
        Offset(0.45, 0.92),
        Offset(0.70, 0.76),
      ],
      [Offset(0.28, 0.40), Offset(0.55, 0.28), Offset(0.72, 0.48)],
      [Offset(0.55, 0.48), Offset(0.55, 0.94)],
    ],
    'ra': [
      [
        Offset(0.55, 0.10),
        Offset(0.55, 0.55),
        Offset(0.35, 0.78),
        Offset(0.48, 0.94),
      ],
    ],
    'la': [
      [Offset(0.55, 0.10), Offset(0.55, 0.94)],
      [
        Offset(0.28, 0.26),
        Offset(0.28, 0.70),
        Offset(0.45, 0.90),
        Offset(0.55, 0.70),
      ],
      [Offset(0.28, 0.48), Offset(0.48, 0.36)],
    ],
    'va': [
      [Offset(0.58, 0.10), Offset(0.58, 0.94)],
      [
        Offset(0.30, 0.26),
        Offset(0.24, 0.52),
        Offset(0.40, 0.80),
        Offset(0.58, 0.60),
      ],
    ],
    'sha': [
      [
        Offset(0.28, 0.18),
        Offset(0.28, 0.55),
        Offset(0.48, 0.74),
        Offset(0.70, 0.55),
        Offset(0.70, 0.18),
      ],
      [Offset(0.48, 0.48), Offset(0.48, 0.94)],
    ],
    'ssha': [
      [Offset(0.62, 0.10), Offset(0.62, 0.94)],
      [
        Offset(0.28, 0.26),
        Offset(0.28, 0.70),
        Offset(0.45, 0.90),
        Offset(0.62, 0.70),
      ],
      [Offset(0.28, 0.48), Offset(0.50, 0.34)],
    ],
    'sa': [
      [Offset(0.62, 0.10), Offset(0.62, 0.94)],
      [
        Offset(0.28, 0.26),
        Offset(0.28, 0.55),
        Offset(0.45, 0.70),
        Offset(0.62, 0.55),
      ],
      [
        Offset(0.28, 0.55),
        Offset(0.28, 0.78),
        Offset(0.45, 0.92),
        Offset(0.62, 0.78),
      ],
    ],
    'ha': [
      [
        Offset(0.30, 0.18),
        Offset(0.28, 0.55),
        Offset(0.48, 0.80),
        Offset(0.72, 0.58),
      ],
      [Offset(0.48, 0.40), Offset(0.55, 0.70), Offset(0.48, 0.94)],
    ],
    'lla': [
      [Offset(0.55, 0.10), Offset(0.55, 0.94)],
      [
        Offset(0.28, 0.26),
        Offset(0.28, 0.70),
        Offset(0.45, 0.90),
        Offset(0.55, 0.70),
      ],
      [Offset(0.28, 0.48), Offset(0.48, 0.36)],
    ],
    'ksha': [
      [Offset(0.58, 0.10), Offset(0.58, 0.94)],
      [
        Offset(0.58, 0.34),
        Offset(0.35, 0.24),
        Offset(0.20, 0.42),
        Offset(0.28, 0.64),
        Offset(0.48, 0.72),
      ],
      [
        Offset(0.58, 0.48),
        Offset(0.78, 0.36),
        Offset(0.82, 0.60),
        Offset(0.68, 0.76),
      ],
    ],
    'gnya': [
      [Offset(0.50, 0.10), Offset(0.50, 0.94)],
      [
        Offset(0.26, 0.26),
        Offset(0.38, 0.48),
        Offset(0.26, 0.68),
        Offset(0.38, 0.88),
      ],
      [
        Offset(0.50, 0.32),
        Offset(0.72, 0.24),
        Offset(0.78, 0.48),
        Offset(0.62, 0.60),
      ],
    ],
  };

  // Gurmukhi is close enough to Devanagari proportions in a unit box.
  static final Map<String, List<List<Offset>>> _gurmukhi = Map.unmodifiable({
    ..._devanagari,
  });

  // ── Tamil — distinct round forms ────────────────────────────────────────

  static final Map<String, List<List<Offset>>> _tamil = {
    'a': [
      [
        Offset(0.55, 0.08),
        Offset(0.28, 0.18),
        Offset(0.22, 0.48),
        Offset(0.40, 0.78),
        Offset(0.70, 0.70),
        Offset(0.78, 0.40),
        Offset(0.62, 0.22),
        Offset(0.48, 0.40),
      ],
    ],
    'aa': [
      [
        Offset(0.42, 0.10),
        Offset(0.22, 0.22),
        Offset(0.18, 0.50),
        Offset(0.35, 0.80),
        Offset(0.58, 0.72),
        Offset(0.62, 0.40),
        Offset(0.48, 0.24),
      ],
      [Offset(0.78, 0.12), Offset(0.78, 0.92)],
    ],
    'i': [
      [
        Offset(0.35, 0.20),
        Offset(0.28, 0.48),
        Offset(0.45, 0.78),
        Offset(0.70, 0.62),
        Offset(0.72, 0.32),
        Offset(0.55, 0.18),
      ],
      [Offset(0.55, 0.48), Offset(0.55, 0.94)],
    ],
    'ii': [
      [
        Offset(0.32, 0.22),
        Offset(0.26, 0.50),
        Offset(0.42, 0.80),
        Offset(0.68, 0.64),
        Offset(0.70, 0.34),
        Offset(0.52, 0.20),
      ],
      [Offset(0.52, 0.50), Offset(0.52, 0.94)],
      [Offset(0.72, 0.08), Offset(0.84, 0.20)],
    ],
    'u': [
      [
        Offset(0.35, 0.12),
        Offset(0.28, 0.40),
        Offset(0.40, 0.72),
        Offset(0.65, 0.82),
        Offset(0.80, 0.58),
        Offset(0.70, 0.28),
      ],
    ],
    'uu': [
      [
        Offset(0.32, 0.12),
        Offset(0.26, 0.40),
        Offset(0.38, 0.72),
        Offset(0.62, 0.84),
        Offset(0.80, 0.60),
        Offset(0.72, 0.28),
      ],
      [Offset(0.55, 0.88), Offset(0.78, 0.96)],
    ],
    'e': [
      [
        Offset(0.70, 0.18),
        Offset(0.45, 0.10),
        Offset(0.25, 0.28),
        Offset(0.30, 0.55),
        Offset(0.55, 0.72),
        Offset(0.75, 0.55),
      ],
      [Offset(0.55, 0.55), Offset(0.55, 0.94)],
    ],
    'ee': [
      [
        Offset(0.68, 0.16),
        Offset(0.42, 0.10),
        Offset(0.22, 0.28),
        Offset(0.28, 0.55),
        Offset(0.52, 0.74),
        Offset(0.74, 0.52),
      ],
      [Offset(0.52, 0.52), Offset(0.52, 0.94)],
      [Offset(0.78, 0.10), Offset(0.78, 0.92)],
    ],
    'ai': [
      [
        Offset(0.28, 0.20),
        Offset(0.45, 0.10),
        Offset(0.65, 0.22),
        Offset(0.70, 0.48),
        Offset(0.50, 0.70),
        Offset(0.30, 0.55),
      ],
      [Offset(0.50, 0.55), Offset(0.42, 0.78), Offset(0.55, 0.94)],
    ],
    'o': [
      [
        Offset(0.55, 0.10),
        Offset(0.30, 0.22),
        Offset(0.25, 0.50),
        Offset(0.42, 0.78),
        Offset(0.70, 0.68),
        Offset(0.75, 0.38),
        Offset(0.58, 0.22),
      ],
      [Offset(0.55, 0.48), Offset(0.55, 0.94)],
    ],
    'oo': [
      [
        Offset(0.50, 0.10),
        Offset(0.28, 0.22),
        Offset(0.22, 0.50),
        Offset(0.40, 0.78),
        Offset(0.68, 0.68),
        Offset(0.72, 0.38),
        Offset(0.55, 0.22),
      ],
      [Offset(0.50, 0.48), Offset(0.50, 0.94)],
      [Offset(0.80, 0.10), Offset(0.80, 0.92)],
    ],
    'au': [
      // ஔ left hook + rounded body (must follow the full curve)
      [
        Offset(0.52, 0.08),
        Offset(0.34, 0.10),
        Offset(0.18, 0.22),
        Offset(0.14, 0.40),
        Offset(0.18, 0.58),
        Offset(0.30, 0.72),
        Offset(0.46, 0.80),
        Offset(0.58, 0.70),
        Offset(0.60, 0.52),
        Offset(0.50, 0.40),
        Offset(0.36, 0.36),
        Offset(0.34, 0.24),
        Offset(0.48, 0.18),
        Offset(0.58, 0.28),
      ],
      // Middle stem down through the body
      [
        Offset(0.58, 0.32),
        Offset(0.56, 0.48),
        Offset(0.54, 0.64),
        Offset(0.56, 0.80),
        Offset(0.58, 0.94),
      ],
      // Right vertical of ஔ
      [
        Offset(0.76, 0.08),
        Offset(0.76, 0.28),
        Offset(0.76, 0.50),
        Offset(0.76, 0.72),
        Offset(0.76, 0.94),
      ],
    ],
    // அம் — base அ shape + anusvara dot (not a lone mark).
    'am': [
      [
        Offset(0.50, 0.10),
        Offset(0.26, 0.20),
        Offset(0.20, 0.48),
        Offset(0.38, 0.78),
        Offset(0.66, 0.70),
        Offset(0.74, 0.40),
        Offset(0.58, 0.24),
        Offset(0.44, 0.42),
      ],
      [Offset(0.82, 0.18), Offset(0.88, 0.28)],
    ],
    'aha': [
      [
        Offset(0.40, 0.20),
        Offset(0.55, 0.12),
        Offset(0.68, 0.28),
        Offset(0.55, 0.48),
        Offset(0.40, 0.40),
      ],
      [Offset(0.55, 0.48), Offset(0.55, 0.90)],
    ],
    // Unique Tamil mei + Grantha — one path per visible letter.
    'ka': _tamilKa,
    'nga': [
      [
        Offset(0.28, 0.22),
        Offset(0.28, 0.68),
        Offset(0.48, 0.88),
        Offset(0.72, 0.68),
        Offset(0.72, 0.28),
      ],
      [Offset(0.28, 0.48), Offset(0.72, 0.48)],
      [Offset(0.50, 0.48), Offset(0.50, 0.94)],
    ],
    'cha': _tamilCha,
    'gnya': [
      [
        Offset(0.32, 0.16),
        Offset(0.26, 0.45),
        Offset(0.42, 0.78),
        Offset(0.70, 0.62),
        Offset(0.72, 0.28),
        Offset(0.52, 0.16),
      ],
      [Offset(0.52, 0.45), Offset(0.52, 0.94)],
      [Offset(0.52, 0.55), Offset(0.78, 0.72)],
    ],
    'tta': _tamilTta,
    'nna': [
      [
        Offset(0.30, 0.18),
        Offset(0.28, 0.50),
        Offset(0.45, 0.80),
        Offset(0.72, 0.65),
        Offset(0.70, 0.30),
        Offset(0.50, 0.18),
      ],
      [Offset(0.50, 0.48), Offset(0.50, 0.94)],
    ],
    'ta': _tamilTa,
    'na': [
      [
        Offset(0.28, 0.20),
        Offset(0.28, 0.70),
        Offset(0.48, 0.90),
        Offset(0.72, 0.70),
        Offset(0.72, 0.28),
        Offset(0.50, 0.18),
      ],
    ],
    'pa': _tamilPa,
    'ma': [
      [
        Offset(0.28, 0.22),
        Offset(0.28, 0.70),
        Offset(0.48, 0.90),
        Offset(0.70, 0.70),
        Offset(0.70, 0.28),
      ],
      [Offset(0.28, 0.48), Offset(0.70, 0.48)],
      [Offset(0.48, 0.48), Offset(0.48, 0.94)],
    ],
    'ya': [
      [
        Offset(0.30, 0.18),
        Offset(0.28, 0.55),
        Offset(0.48, 0.82),
        Offset(0.72, 0.60),
      ],
      [Offset(0.48, 0.40), Offset(0.48, 0.94)],
      [Offset(0.28, 0.40), Offset(0.70, 0.28)],
    ],
    'ra': [
      [
        Offset(0.55, 0.12),
        Offset(0.55, 0.55),
        Offset(0.38, 0.78),
        Offset(0.55, 0.94),
      ],
      [Offset(0.55, 0.35), Offset(0.78, 0.28)],
    ],
    'la': [
      [
        Offset(0.32, 0.18),
        Offset(0.28, 0.50),
        Offset(0.42, 0.80),
        Offset(0.68, 0.70),
        Offset(0.72, 0.35),
        Offset(0.55, 0.18),
      ],
      [Offset(0.55, 0.48), Offset(0.55, 0.94)],
    ],
    'va': [
      [
        Offset(0.30, 0.20),
        Offset(0.28, 0.55),
        Offset(0.48, 0.82),
        Offset(0.72, 0.60),
        Offset(0.70, 0.28),
        Offset(0.50, 0.18),
      ],
      [Offset(0.50, 0.48), Offset(0.50, 0.94)],
    ],
    'zha': [
      [
        Offset(0.30, 0.18),
        Offset(0.28, 0.50),
        Offset(0.45, 0.80),
        Offset(0.70, 0.62),
        Offset(0.68, 0.28),
        Offset(0.48, 0.16),
      ],
      [Offset(0.48, 0.45), Offset(0.48, 0.94)],
      [Offset(0.48, 0.55), Offset(0.78, 0.78)],
    ],
    'lla': [
      [
        Offset(0.32, 0.18),
        Offset(0.28, 0.50),
        Offset(0.45, 0.82),
        Offset(0.70, 0.68),
        Offset(0.72, 0.32),
        Offset(0.55, 0.18),
      ],
      [Offset(0.55, 0.50), Offset(0.55, 0.94)],
    ],
    'rra': [
      [
        Offset(0.52, 0.12),
        Offset(0.52, 0.55),
        Offset(0.35, 0.80),
        Offset(0.55, 0.94),
      ],
      [Offset(0.52, 0.32), Offset(0.78, 0.22)],
      [Offset(0.52, 0.48), Offset(0.78, 0.58)],
    ],
    'nnna': [
      [
        Offset(0.28, 0.20),
        Offset(0.28, 0.68),
        Offset(0.48, 0.88),
        Offset(0.72, 0.68),
        Offset(0.72, 0.28),
        Offset(0.50, 0.18),
      ],
      [Offset(0.50, 0.48), Offset(0.50, 0.94)],
    ],
    'ja': [
      [
        Offset(0.35, 0.18),
        Offset(0.28, 0.45),
        Offset(0.45, 0.75),
        Offset(0.70, 0.60),
        Offset(0.72, 0.30),
        Offset(0.55, 0.18),
      ],
      [Offset(0.55, 0.45), Offset(0.55, 0.94)],
      [Offset(0.55, 0.55), Offset(0.78, 0.70)],
    ],
    'ssha': [
      [
        Offset(0.30, 0.20),
        Offset(0.28, 0.55),
        Offset(0.50, 0.80),
        Offset(0.72, 0.55),
        Offset(0.70, 0.22),
      ],
      [Offset(0.50, 0.48), Offset(0.50, 0.94)],
    ],
    'sa': [
      [
        Offset(0.32, 0.18),
        Offset(0.28, 0.48),
        Offset(0.45, 0.78),
        Offset(0.70, 0.62),
        Offset(0.72, 0.30),
        Offset(0.55, 0.16),
      ],
      [Offset(0.55, 0.48), Offset(0.55, 0.94)],
    ],
    'ha': [
      [
        Offset(0.30, 0.18),
        Offset(0.28, 0.55),
        Offset(0.50, 0.82),
        Offset(0.75, 0.58),
      ],
      [Offset(0.50, 0.42), Offset(0.55, 0.70), Offset(0.48, 0.94)],
    ],
    'ksha': [
      [
        Offset(0.28, 0.20),
        Offset(0.28, 0.60),
        Offset(0.48, 0.85),
        Offset(0.70, 0.65),
      ],
      [Offset(0.48, 0.35), Offset(0.48, 0.94)],
      [Offset(0.48, 0.45), Offset(0.75, 0.35), Offset(0.78, 0.60)],
    ],
  };

  static const List<List<Offset>> _tamilKa = [
    [
      Offset(0.30, 0.18),
      Offset(0.28, 0.55),
      Offset(0.48, 0.82),
      Offset(0.72, 0.60),
      Offset(0.70, 0.28),
      Offset(0.50, 0.16),
    ],
    [Offset(0.50, 0.48), Offset(0.50, 0.94)],
  ];

  static const List<List<Offset>> _tamilCha = [
    [
      Offset(0.55, 0.12),
      Offset(0.30, 0.22),
      Offset(0.25, 0.50),
      Offset(0.42, 0.78),
      Offset(0.70, 0.68),
      Offset(0.75, 0.38),
      Offset(0.58, 0.22),
    ],
    [Offset(0.55, 0.48), Offset(0.55, 0.94)],
  ];

  static const List<List<Offset>> _tamilTta = [
    [
      Offset(0.50, 0.14),
      Offset(0.28, 0.28),
      Offset(0.28, 0.60),
      Offset(0.50, 0.82),
      Offset(0.72, 0.60),
      Offset(0.72, 0.28),
      Offset(0.50, 0.14),
    ],
    [Offset(0.50, 0.48), Offset(0.50, 0.94)],
  ];

  static const List<List<Offset>> _tamilTa = [
    [
      Offset(0.32, 0.16),
      Offset(0.28, 0.48),
      Offset(0.45, 0.80),
      Offset(0.72, 0.62),
      Offset(0.70, 0.28),
      Offset(0.52, 0.16),
    ],
    [Offset(0.52, 0.48), Offset(0.52, 0.94)],
  ];

  static const List<List<Offset>> _tamilPa = [
    [
      Offset(0.30, 0.18),
      Offset(0.28, 0.70),
      Offset(0.48, 0.90),
      Offset(0.70, 0.70),
      Offset(0.70, 0.28),
      Offset(0.50, 0.16),
    ],
    [Offset(0.50, 0.48), Offset(0.50, 0.94)],
  ];
}
