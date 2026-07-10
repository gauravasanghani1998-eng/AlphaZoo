class WordItem {
  final String text;
  final String? nameKey;
  final String? imageAsset;

  const WordItem({
    required this.text,
    this.nameKey,
    this.imageAsset,
  });
}

class EverydayWordsData {
  EverydayWordsData._();

  static const _monthJan = 'assets/images/months/gregorian/january.png';
  static const _monthFeb = 'assets/images/months/gregorian/february.png';
  static const _monthMar = 'assets/images/months/gregorian/march.png';
  static const _monthApr = 'assets/images/months/gregorian/april.png';
  static const _monthMay = 'assets/images/months/gregorian/may.png';
  static const _monthJun = 'assets/images/months/gregorian/june.png';
  static const _monthJul = 'assets/images/months/gregorian/july.png';
  static const _monthAug = 'assets/images/months/gregorian/august.png';
  static const _monthSep = 'assets/images/months/gregorian/september.png';
  static const _monthOct = 'assets/images/months/gregorian/october.png';
  static const _monthNov = 'assets/images/months/gregorian/november.png';
  static const _monthDec = 'assets/images/months/gregorian/december.png';

  static const List<WordItem> days = [
    WordItem(
      text: 'Monday',
      nameKey: 'days.names.monday',
      imageAsset: 'assets/images/days/monday.png',
    ),
    WordItem(
      text: 'Tuesday',
      nameKey: 'days.names.tuesday',
      imageAsset: 'assets/images/days/tuesday.png',
    ),
    WordItem(
      text: 'Wednesday',
      nameKey: 'days.names.wednesday',
      imageAsset: 'assets/images/days/wednesday.png',
    ),
    WordItem(
      text: 'Thursday',
      nameKey: 'days.names.thursday',
      imageAsset: 'assets/images/days/thursday.png',
    ),
    WordItem(
      text: 'Friday',
      nameKey: 'days.names.friday',
      imageAsset: 'assets/images/days/friday.png',
    ),
    WordItem(
      text: 'Saturday',
      nameKey: 'days.names.saturday',
      imageAsset: 'assets/images/days/saturday.png',
    ),
    WordItem(
      text: 'Sunday',
      nameKey: 'days.names.sunday',
      imageAsset: 'assets/images/days/sunday.png',
    ),
  ];

  static const List<WordItem> _gregorianMonths = [
    WordItem(
      text: 'January',
      nameKey: 'months.names.january',
      imageAsset: _monthJan,
    ),
    WordItem(
      text: 'February',
      nameKey: 'months.names.february',
      imageAsset: _monthFeb,
    ),
    WordItem(
      text: 'March',
      nameKey: 'months.names.march',
      imageAsset: _monthMar,
    ),
    WordItem(
      text: 'April',
      nameKey: 'months.names.april',
      imageAsset: _monthApr,
    ),
    WordItem(
      text: 'May',
      nameKey: 'months.names.may',
      imageAsset: _monthMay,
    ),
    WordItem(
      text: 'June',
      nameKey: 'months.names.june',
      imageAsset: _monthJun,
    ),
    WordItem(
      text: 'July',
      nameKey: 'months.names.july',
      imageAsset: _monthJul,
    ),
    WordItem(
      text: 'August',
      nameKey: 'months.names.august',
      imageAsset: _monthAug,
    ),
    WordItem(
      text: 'September',
      nameKey: 'months.names.september',
      imageAsset: _monthSep,
    ),
    WordItem(
      text: 'October',
      nameKey: 'months.names.october',
      imageAsset: _monthOct,
    ),
    WordItem(
      text: 'November',
      nameKey: 'months.names.november',
      imageAsset: _monthNov,
    ),
    WordItem(
      text: 'December',
      nameKey: 'months.names.december',
      imageAsset: _monthDec,
    ),
  ];

  static const List<WordItem> _hinduMonths = [
    WordItem(
      text: 'Kartak',
      nameKey: 'months.names.kartak',
      imageAsset: _monthJan,
    ),
    WordItem(
      text: 'Magshar',
      nameKey: 'months.names.magshar',
      imageAsset: _monthFeb,
    ),
    WordItem(
      text: 'Posh',
      nameKey: 'months.names.posh',
      imageAsset: _monthMar,
    ),
    WordItem(
      text: 'Maha',
      nameKey: 'months.names.maha',
      imageAsset: _monthApr,
    ),
    WordItem(
      text: 'Phagan',
      nameKey: 'months.names.phagan',
      imageAsset: _monthMay,
    ),
    WordItem(
      text: 'Chaitra',
      nameKey: 'months.names.chaitra',
      imageAsset: _monthJun,
    ),
    WordItem(
      text: 'Vaishakh',
      nameKey: 'months.names.vaishakh',
      imageAsset: _monthJul,
    ),
    WordItem(
      text: 'Jeth',
      nameKey: 'months.names.jeth',
      imageAsset: _monthAug,
    ),
    WordItem(
      text: 'Ashadh',
      nameKey: 'months.names.ashadh',
      imageAsset: _monthSep,
    ),
    WordItem(
      text: 'Shravan',
      nameKey: 'months.names.shravan',
      imageAsset: _monthOct,
    ),
    WordItem(
      text: 'Bhadarvo',
      nameKey: 'months.names.bhadarvo',
      imageAsset: _monthNov,
    ),
    WordItem(
      text: 'Aaso',
      nameKey: 'months.names.aaso',
      imageAsset: _monthDec,
    ),
  ];

  static const List<WordItem> _tamilMonths = [
    WordItem(
      text: 'Chithirai',
      nameKey: 'months.names.chithirai',
      imageAsset: _monthJan,
    ),
    WordItem(
      text: 'Vaikasi',
      nameKey: 'months.names.vaikasi',
      imageAsset: _monthFeb,
    ),
    WordItem(
      text: 'Aani',
      nameKey: 'months.names.aani',
      imageAsset: _monthMar,
    ),
    WordItem(
      text: 'Aadi',
      nameKey: 'months.names.aadi',
      imageAsset: _monthApr,
    ),
    WordItem(
      text: 'Aavani',
      nameKey: 'months.names.aavani',
      imageAsset: _monthMay,
    ),
    WordItem(
      text: 'Purattasi',
      nameKey: 'months.names.purattasi',
      imageAsset: _monthJun,
    ),
    WordItem(
      text: 'Aippasi',
      nameKey: 'months.names.aippasi',
      imageAsset: _monthJul,
    ),
    WordItem(
      text: 'Karthigai',
      nameKey: 'months.names.karthigai',
      imageAsset: _monthAug,
    ),
    WordItem(
      text: 'Margazhi',
      nameKey: 'months.names.margazhi',
      imageAsset: _monthSep,
    ),
    WordItem(
      text: 'Thai',
      nameKey: 'months.names.thai',
      imageAsset: _monthOct,
    ),
    WordItem(
      text: 'Maasi',
      nameKey: 'months.names.maasi',
      imageAsset: _monthNov,
    ),
    WordItem(
      text: 'Panguni',
      nameKey: 'months.names.panguni',
      imageAsset: _monthDec,
    ),
  ];

  static List<WordItem> monthsForLocale(String languageCode) {
    switch (languageCode) {
      case 'gu':
      case 'hi':
      case 'mr':
      case 'pa':
        return _hinduMonths;
      case 'ta':
        return _tamilMonths;
      default:
        return _gregorianMonths;
    }
  }

  static List<WordItem> get months => _gregorianMonths;
}
