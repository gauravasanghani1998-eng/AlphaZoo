import 'dart:ui';

import 'letter_stroke_data.dart';

/// Normalized stroke guides (0–1) for digits 0–9 handwriting order.
/// Guide keys use ASCII digits; display glyphs come from localized [numbers.glyphs].
class NumberStrokeData {
  NumberStrokeData._();

  static const Map<String, List<List<Offset>>> _strokes = {
    '0': [
      [
        Offset(0.50, 0.02),
        Offset(0.26, 0.06),
        Offset(0.12, 0.28),
        Offset(0.12, 0.72),
        Offset(0.26, 0.94),
        Offset(0.50, 0.98),
        Offset(0.74, 0.94),
        Offset(0.88, 0.72),
        Offset(0.88, 0.28),
        Offset(0.74, 0.06),
        Offset(0.50, 0.02),
      ],
    ],
    '1': [
      [Offset(0.42, 0.18), Offset(0.50, 0.02)],
      [Offset(0.50, 0.02), Offset(0.50, 0.98)],
      [Offset(0.28, 0.98), Offset(0.72, 0.98)],
    ],
    '2': [
      [
        Offset(0.18, 0.24),
        Offset(0.34, 0.04),
        Offset(0.66, 0.04),
        Offset(0.84, 0.22),
        Offset(0.84, 0.40),
        Offset(0.66, 0.56),
        Offset(0.18, 0.98),
        Offset(0.86, 0.98),
      ],
    ],
    '3': [
      [
        Offset(0.20, 0.12),
        Offset(0.42, 0.02),
        Offset(0.66, 0.02),
        Offset(0.84, 0.18),
        Offset(0.84, 0.36),
        Offset(0.66, 0.50),
        Offset(0.84, 0.64),
        Offset(0.84, 0.82),
        Offset(0.66, 0.98),
        Offset(0.42, 0.98),
        Offset(0.20, 0.88),
      ],
    ],
    '4': [
      [Offset(0.62, 0.02), Offset(0.18, 0.72)],
      [Offset(0.18, 0.72), Offset(0.86, 0.72)],
      [Offset(0.62, 0.02), Offset(0.62, 0.98)],
    ],
    '5': [
      [
        Offset(0.78, 0.02),
        Offset(0.22, 0.02),
        Offset(0.22, 0.46),
        Offset(0.62, 0.46),
        Offset(0.82, 0.62),
        Offset(0.82, 0.82),
        Offset(0.62, 0.98),
        Offset(0.30, 0.98),
        Offset(0.16, 0.84),
      ],
    ],
    '6': [
      [
        Offset(0.72, 0.14),
        Offset(0.52, 0.02),
        Offset(0.30, 0.02),
        Offset(0.14, 0.20),
        Offset(0.14, 0.78),
        Offset(0.30, 0.98),
        Offset(0.58, 0.98),
        Offset(0.80, 0.80),
        Offset(0.80, 0.60),
        Offset(0.58, 0.46),
        Offset(0.30, 0.46),
      ],
    ],
    '7': [
      [Offset(0.18, 0.02), Offset(0.82, 0.02)],
      [Offset(0.82, 0.02), Offset(0.38, 0.98)],
    ],
    '8': [
      [
        Offset(0.50, 0.50),
        Offset(0.30, 0.50),
        Offset(0.16, 0.36),
        Offset(0.16, 0.18),
        Offset(0.34, 0.02),
        Offset(0.66, 0.02),
        Offset(0.84, 0.18),
        Offset(0.84, 0.36),
        Offset(0.70, 0.50),
        Offset(0.50, 0.50),
        Offset(0.30, 0.50),
        Offset(0.16, 0.64),
        Offset(0.16, 0.82),
        Offset(0.34, 0.98),
        Offset(0.66, 0.98),
        Offset(0.84, 0.82),
        Offset(0.84, 0.64),
        Offset(0.70, 0.50),
      ],
    ],
    '9': [
      [
        Offset(0.80, 0.58),
        Offset(0.80, 0.28),
        Offset(0.62, 0.06),
        Offset(0.38, 0.06),
        Offset(0.18, 0.24),
        Offset(0.18, 0.44),
        Offset(0.38, 0.58),
        Offset(0.62, 0.58),
        Offset(0.80, 0.44),
        Offset(0.80, 0.98),
        Offset(0.52, 0.98),
      ],
    ],
  };

  static const int traceNumberCount = 100;

  static List<List<Offset>> strokesFor(String digitKey) {
    return _strokes[digitKey] ?? _strokes['0']!;
  }

  /// Compose per-digit strokes for multi-digit values (e.g. 25 → 2 then 5).
  static List<List<Offset>> strokesForValue(int value) {
    return strokesForDigits('$value'.split(''));
  }

  static List<List<Offset>> strokesForDigits(List<String> digits) {
    if (digits.isEmpty) return strokesFor('0');
    if (digits.length == 1) return strokesFor(digits.first);

    const gapFraction = 0.06;
    final slot = 1.0 / digits.length;
    final composed = <List<Offset>>[];

    for (var i = 0; i < digits.length; i++) {
      final left = i * slot;
      final innerWidth = slot * (1 - gapFraction);
      final pad = slot * gapFraction / 2;
      for (final stroke in strokesFor(digits[i])) {
        composed.add(
          stroke
              .map(
                (p) => Offset(
                  left + pad + p.dx * innerWidth,
                  p.dy,
                ),
              )
              .toList(),
        );
      }
    }
    return composed;
  }

  static List<Offset> resamplePolyline(List<Offset> points, {int segments = 24}) {
    return LetterStrokeData.resamplePolyline(points, segments: segments);
  }
}
