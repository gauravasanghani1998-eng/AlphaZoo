import 'dart:ui';

/// Normalized stroke guides (0–1) for capital A–Z handwriting order.
class LetterStrokeData {
  LetterStrokeData._();

  static const Map<String, List<List<Offset>>> _strokes = {
    'A': [
      [Offset(0.50, 0.02), Offset(0.14, 0.98)],
      [Offset(0.50, 0.02), Offset(0.86, 0.98)],
      [Offset(0.28, 0.58), Offset(0.72, 0.58)],
    ],
    'B': [
      [Offset(0.22, 0.02), Offset(0.22, 0.98)],
      [Offset(0.22, 0.02), Offset(0.62, 0.02), Offset(0.78, 0.18), Offset(0.78, 0.38), Offset(0.62, 0.50), Offset(0.22, 0.50)],
      [Offset(0.22, 0.50), Offset(0.66, 0.50), Offset(0.82, 0.66), Offset(0.82, 0.84), Offset(0.66, 0.98), Offset(0.22, 0.98)],
    ],
    'C': [
      [Offset(0.82, 0.18), Offset(0.58, 0.02), Offset(0.30, 0.02), Offset(0.12, 0.22), Offset(0.12, 0.78), Offset(0.30, 0.98), Offset(0.58, 0.98), Offset(0.82, 0.82)],
    ],
    'D': [
      [Offset(0.22, 0.02), Offset(0.22, 0.98)],
      [Offset(0.22, 0.02), Offset(0.58, 0.02), Offset(0.82, 0.28), Offset(0.82, 0.72), Offset(0.58, 0.98), Offset(0.22, 0.98)],
    ],
    'E': [
      [Offset(0.78, 0.02), Offset(0.22, 0.02), Offset(0.22, 0.98)],
      [Offset(0.22, 0.02), Offset(0.72, 0.02)],
      [Offset(0.22, 0.50), Offset(0.62, 0.50)],
      [Offset(0.22, 0.98), Offset(0.72, 0.98)],
    ],
    'F': [
      [Offset(0.78, 0.02), Offset(0.22, 0.02), Offset(0.22, 0.98)],
      [Offset(0.22, 0.02), Offset(0.72, 0.02)],
      [Offset(0.22, 0.50), Offset(0.62, 0.50)],
    ],
    'G': [
      [Offset(0.82, 0.18), Offset(0.58, 0.02), Offset(0.30, 0.02), Offset(0.12, 0.22), Offset(0.12, 0.78), Offset(0.30, 0.98), Offset(0.62, 0.98), Offset(0.86, 0.78), Offset(0.86, 0.56), Offset(0.58, 0.56)],
    ],
    'H': [
      [Offset(0.22, 0.02), Offset(0.22, 0.98)],
      [Offset(0.22, 0.50), Offset(0.78, 0.50)],
      [Offset(0.78, 0.02), Offset(0.78, 0.98)],
    ],
    'I': [
      [Offset(0.50, 0.02), Offset(0.50, 0.98)],
    ],
    'J': [
      [Offset(0.72, 0.02), Offset(0.72, 0.78), Offset(0.52, 0.98), Offset(0.28, 0.88)],
    ],
    'K': [
      [Offset(0.22, 0.02), Offset(0.22, 0.98)],
      [Offset(0.78, 0.02), Offset(0.22, 0.50)],
      [Offset(0.32, 0.58), Offset(0.82, 0.98)],
    ],
    'L': [
      [Offset(0.22, 0.02), Offset(0.22, 0.98), Offset(0.78, 0.98)],
    ],
    'M': [
      [Offset(0.16, 0.98), Offset(0.16, 0.02), Offset(0.50, 0.52), Offset(0.84, 0.02), Offset(0.84, 0.98)],
    ],
    'N': [
      [Offset(0.22, 0.98), Offset(0.22, 0.02), Offset(0.78, 0.98), Offset(0.78, 0.02)],
    ],
    'O': [
      [Offset(0.50, 0.02), Offset(0.26, 0.06), Offset(0.12, 0.28), Offset(0.12, 0.72), Offset(0.26, 0.94), Offset(0.50, 0.98), Offset(0.74, 0.94), Offset(0.88, 0.72), Offset(0.88, 0.28), Offset(0.74, 0.06), Offset(0.50, 0.02)],
    ],
    'P': [
      [Offset(0.22, 0.02), Offset(0.22, 0.98)],
      [Offset(0.22, 0.02), Offset(0.62, 0.02), Offset(0.80, 0.18), Offset(0.80, 0.38), Offset(0.62, 0.52), Offset(0.22, 0.52)],
    ],
    'Q': [
      [Offset(0.50, 0.02), Offset(0.26, 0.06), Offset(0.12, 0.28), Offset(0.12, 0.72), Offset(0.26, 0.94), Offset(0.50, 0.98), Offset(0.74, 0.94), Offset(0.88, 0.72), Offset(0.88, 0.28), Offset(0.74, 0.06), Offset(0.50, 0.02)],
      [Offset(0.58, 0.68), Offset(0.88, 0.98)],
    ],
    'R': [
      [Offset(0.22, 0.02), Offset(0.22, 0.98)],
      [Offset(0.22, 0.02), Offset(0.62, 0.02), Offset(0.80, 0.18), Offset(0.80, 0.38), Offset(0.62, 0.52), Offset(0.22, 0.52)],
      [Offset(0.42, 0.52), Offset(0.82, 0.98)],
    ],
    'S': [
      [Offset(0.78, 0.16), Offset(0.58, 0.02), Offset(0.34, 0.02), Offset(0.16, 0.18), Offset(0.34, 0.36), Offset(0.66, 0.44), Offset(0.84, 0.62), Offset(0.66, 0.82), Offset(0.38, 0.98), Offset(0.18, 0.84)],
    ],
    'T': [
      [Offset(0.16, 0.02), Offset(0.84, 0.02)],
      [Offset(0.50, 0.02), Offset(0.50, 0.98)],
    ],
    'U': [
      [Offset(0.22, 0.02), Offset(0.22, 0.78), Offset(0.38, 0.98), Offset(0.62, 0.98), Offset(0.78, 0.78), Offset(0.78, 0.02)],
    ],
    'V': [
      [Offset(0.14, 0.02), Offset(0.50, 0.98), Offset(0.86, 0.02)],
    ],
    'W': [
      [Offset(0.08, 0.02), Offset(0.28, 0.98), Offset(0.50, 0.42), Offset(0.72, 0.98), Offset(0.92, 0.02)],
    ],
    'X': [
      [Offset(0.18, 0.02), Offset(0.82, 0.98)],
      [Offset(0.82, 0.02), Offset(0.18, 0.98)],
    ],
    'Y': [
      [Offset(0.18, 0.02), Offset(0.50, 0.48)],
      [Offset(0.82, 0.02), Offset(0.50, 0.48)],
      [Offset(0.50, 0.48), Offset(0.50, 0.98)],
    ],
    'Z': [
      [Offset(0.18, 0.02), Offset(0.82, 0.02)],
      [Offset(0.82, 0.02), Offset(0.18, 0.98)],
      [Offset(0.18, 0.98), Offset(0.82, 0.98)],
    ],
  };

  static List<List<Offset>> strokesFor(String letter) {
    return _strokes[letter.toUpperCase()] ?? _strokes['A']!;
  }

  static int strokeCount(String letter) => strokesFor(letter).length;

  /// Resample a polyline into evenly spaced checkpoints for progress tracking.
  static List<Offset> resamplePolyline(List<Offset> points, {int segments = 24}) {
    if (points.length < 2) return List<Offset>.from(points);
    final sampled = <Offset>[];
    var totalLength = 0.0;
    final lengths = <double>[];
    for (var i = 0; i < points.length - 1; i++) {
      final len = (points[i + 1] - points[i]).distance;
      lengths.add(len);
      totalLength += len;
    }
    if (totalLength == 0) return [points.first];
    final step = totalLength / segments;
    var seg = 0;
    var segStart = 0.0;
    for (var i = 0; i <= segments; i++) {
      final target = i * step;
      while (seg < lengths.length && segStart + lengths[seg] < target) {
        segStart += lengths[seg];
        seg++;
      }
      if (seg >= lengths.length) {
        sampled.add(points.last);
        break;
      }
      final t = (target - segStart) / lengths[seg];
      sampled.add(Offset.lerp(points[seg], points[seg + 1], t)!);
    }
    return sampled;
  }
}
