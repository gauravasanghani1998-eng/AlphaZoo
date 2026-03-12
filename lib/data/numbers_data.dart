/// Model class for number items (1–100)
class NumberItem {
  final int value;
  final String word;

  const NumberItem({
    required this.value,
    required this.word,
  });
}

/// Static data + helpers for numbers 1–100
class NumbersData {
  NumbersData._();

  /// List of numbers from 1 to 100 with their English words.
  static final List<NumberItem> items = List<NumberItem>.unmodifiable(
    List<NumberItem>.generate(
      100,
      (index) {
        final value = index + 1;
        return NumberItem(
          value: value,
          word: _numberToWords(value),
        );
      },
    ),
  );

  /// Get items within an inclusive range (e.g. 1–26).
  static List<NumberItem> range(int start, int end) {
    assert(start >= 1 && end <= 100 && start <= end);
    return items.where((n) => n.value >= start && n.value <= end).toList();
  }

  /// Convert a number to its English word representation (1–100).
  static String _numberToWords(int n) {
    if (n < 1 || n > 100) {
      throw ArgumentError('Supported range is 1–100. Got $n');
    }

    const ones = <int, String>{
      1: 'One',
      2: 'Two',
      3: 'Three',
      4: 'Four',
      5: 'Five',
      6: 'Six',
      7: 'Seven',
      8: 'Eight',
      9: 'Nine',
      10: 'Ten',
      11: 'Eleven',
      12: 'Twelve',
      13: 'Thirteen',
      14: 'Fourteen',
      15: 'Fifteen',
      16: 'Sixteen',
      17: 'Seventeen',
      18: 'Eighteen',
      19: 'Nineteen',
    };

    const tensWords = <int, String>{
      20: 'Twenty',
      30: 'Thirty',
      40: 'Forty',
      50: 'Fifty',
      60: 'Sixty',
      70: 'Seventy',
      80: 'Eighty',
      90: 'Ninety',
      100: 'One Hundred',
    };

    if (ones.containsKey(n)) return ones[n]!;
    if (tensWords.containsKey(n)) return tensWords[n]!;

    if (n < 100) {
      final ten = (n ~/ 10) * 10;
      final unit = n % 10;
      return '${tensWords[ten]}-${ones[unit]}';
    }

    // Only remaining supported value is 100.
    return tensWords[100]!;
  }
}

