class NumberItem {
  final int value;
  final String nameKey;

  const NumberItem({
    required this.value,
    required this.nameKey,
  });
}

class NumbersData {
  NumbersData._();

  static const glyphsKey = 'numbers.glyphs';

  static String formatDigits(int value, String glyphs) {
    if (glyphs.length != 10) return '$value';
    final buffer = StringBuffer();
    for (final char in '$value'.split('')) {
      buffer.write(glyphs[int.parse(char)]);
    }
    return buffer.toString();
  }

  static String formatDigitRange(int start, int end, String glyphs) {
    return '${formatDigits(start, glyphs)}–${formatDigits(end, glyphs)}';
  }

  static final List<NumberItem> items = List<NumberItem>.unmodifiable(
    List<NumberItem>.generate(
      100,
      (index) {
        final value = index + 1;
        return NumberItem(
          value: value,
          nameKey: 'numbers.names.$value',
        );
      },
    ),
  );

  static List<NumberItem> range(int start, int end) {
    assert(start >= 1 && end <= 100 && start <= end);
    return items.where((n) => n.value >= start && n.value <= end).toList();
  }
}
