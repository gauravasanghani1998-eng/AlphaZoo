enum RhymeCatalog {
  english,
  gujarati,
  hindi,
}

class RhymeItem {
  final String id;
  final String emoji;
  final String title;
  final String subtitle;
  final bool ttsOnly;
  final List<int> stanzaSizes;

  const RhymeItem({
    required this.id,
    required this.emoji,
    required this.title,
    required this.subtitle,
    this.ttsOnly = false,
    required this.stanzaSizes,
  });

  int get lineCount => stanzaSizes.fold<int>(0, (sum, size) => sum + size);
}

class RhymesData {
  RhymesData._();

  static const List<RhymeItem> _englishItems = [
    RhymeItem(
      id: 'twinkle',
      emoji: '⭐',
      title: 'Twinkle Twinkle Little Star',
      subtitle: 'A shining star in the sky',
      stanzaSizes: [4],
    ),
    RhymeItem(
      id: 'abc',
      emoji: '🔤',
      title: 'ABC Song',
      subtitle: 'Learn the alphabet',
      stanzaSizes: [4, 2],
    ),
    RhymeItem(
      id: 'wheels',
      emoji: '🚌',
      title: 'Wheels on the Bus',
      subtitle: 'Wheels, horn, wipers, and more',
      stanzaSizes: [4, 4, 4, 4, 4, 4, 4],
    ),
    RhymeItem(
      id: 'baaBaa',
      emoji: '🐑',
      title: 'Baa Baa Black Sheep',
      subtitle: 'A friendly sheep shares wool',
      stanzaSizes: [4, 4, 4, 4],
    ),
    RhymeItem(
      id: 'oldMacDonald',
      emoji: '🐄',
      title: 'Old MacDonald Had a Farm',
      subtitle: 'Duck, dog, cat, cow, and sheep',
      stanzaSizes: [5, 5, 5, 5, 5],
    ),
    RhymeItem(
      id: 'happy',
      emoji: '🖐️',
      title: "If You're Happy and You Know It",
      subtitle: 'Clap, stomp, and say ok',
      stanzaSizes: [5, 5, 5],
    ),
    RhymeItem(
      id: 'rainbow',
      emoji: '🌈',
      title: 'I Can Sing a Rainbow',
      subtitle: 'Red, yellow, pink and green',
      stanzaSizes: [4, 5],
    ),
    RhymeItem(
      id: 'number',
      emoji: '🔢',
      title: 'One Two Buckle My Shoe',
      subtitle: 'Count from one to ten',
      stanzaSizes: [5],
    ),
    RhymeItem(
      id: 'goodMorning',
      emoji: '☀️',
      title: 'Good Morning Song',
      subtitle: 'Clap, stomp, and start the day',
      stanzaSizes: [4, 3, 4, 4],
    ),
    RhymeItem(
      id: 'days',
      emoji: '📅',
      title: 'Days of the Week Song',
      subtitle: 'Monday to Sunday',
      stanzaSizes: [7],
    ),
    RhymeItem(
      id: 'bingo',
      emoji: '🐶',
      title: 'BINGO',
      subtitle: "A farmer's dog named Bingo",
      stanzaSizes: [4, 4, 4, 4, 4, 4],
    ),
    RhymeItem(
      id: 'rowBoat',
      emoji: '🚣',
      title: 'Row Row Row Your Boat',
      subtitle: 'Gently down the stream',
      stanzaSizes: [4, 4, 4],
    ),
  ];

  static const List<RhymeItem> _gujaratiItems = [
    RhymeItem(
      id: 'tametu_lal_lal',
      emoji: '🍅',
      title: 'ટામેટું લાલ લાલ',
      subtitle: 'રંગ શીખવતી મસ્ત કવિતા',
      stanzaSizes: [4, 4],
    ),
    RhymeItem(
      id: 'adko_dadko',
      emoji: '👏',
      title: 'અડકો દડકો દહી દડકો',
      subtitle: 'મીઠી લયવાળી કવિતા',
      stanzaSizes: [3, 3, 4, 3, 3, 3],
    ),
    RhymeItem(
      id: 'chakiben_chakiben',
      emoji: '🐦',
      title: 'ચકીબેન ચકીબેન',
      subtitle: 'ચકલી સાથે રમવાની કવિતા',
      stanzaSizes: [4, 4, 4, 3],
    ),
    RhymeItem(
      id: 'ek_biladi_jaddi',
      emoji: '🐱',
      title: 'એક બિલાડી જાડી',
      subtitle: 'બિલાડીની મજેદાર કવિતા',
      stanzaSizes: [4, 4, 4, 3],
    ),
    RhymeItem(
      id: 'gadi_aavi_chhuk_chhuk',
      emoji: '🚂',
      title: 'ગાડી આવી છુક છુક',
      subtitle: 'ટ્રેનની રમૂજી કવિતા',
      stanzaSizes: [3, 2, 2, 2, 2],
    ),
    RhymeItem(
      id: 'aav_re_varsad',
      emoji: '🌧️',
      title: 'આવ રે વરસાદ',
      subtitle: 'વરસાદની મીઠી કવિતા',
      stanzaSizes: [3, 4, 4],
    ),
    RhymeItem(
      id: 'gujarati_kakko',
      emoji: '📖',
      title: 'ગુજરાતી કક્કો',
      subtitle: 'અક્ષરો શીખવતું ગીત',
      stanzaSizes: [5, 4, 3],
    ),
    RhymeItem(
      id: 'mari_hodi',
      emoji: '⛵',
      title: 'મારી હોડી',
      subtitle: 'હોડી હોડી રમવાની કવિતા',
      stanzaSizes: [2, 2, 2, 2, 2, 2],
    ),
  ];

  static const List<RhymeItem> _hindiItems = [
    RhymeItem(
      id: 'machli_jal_ki_rani',
      emoji: '🐟',
      title: 'मछली जल की रानी है',
      subtitle: 'पानी में रहने वाली मछली',
      stanzaSizes: [6, 6],
    ),
    RhymeItem(
      id: 'chanda_mama_door_ke',
      emoji: '🌙',
      title: 'चंदा मामा दूर के',
      subtitle: 'चाँद और प्यारे खाने की कविता',
      stanzaSizes: [4, 4, 4],
    ),
    RhymeItem(
      id: 'lakdi_ki_kathi',
      emoji: '🐴',
      title: 'लकड़ी की काठी',
      subtitle: 'काठी पर घोड़ा दौड़ता है',
      stanzaSizes: [2, 2, 2, 2],
    ),
    RhymeItem(
      id: 'nani_teri_morni',
      emoji: '🦚',
      title: 'नानी तेरी मोरनी',
      subtitle: 'मोरनी और चोर की कहानी',
      stanzaSizes: [4, 4, 4, 2],
    ),
    RhymeItem(
      id: 'aloo_kachalu',
      emoji: '🥔',
      title: 'आलू कचालू',
      subtitle: 'आलू कहाँ गए थे?',
      stanzaSizes: [4, 4],
    ),
    RhymeItem(
      id: 'chuk_chuk_rail',
      emoji: '🚂',
      title: 'छुक छुक रेलगाड़ी',
      subtitle: 'रेलगाड़ी सबको सैर कराती है',
      stanzaSizes: [2, 3, 2, 3, 2],
    ),
  ];

  static RhymeCatalog catalogForLocale(String languageCode) {
    switch (languageCode) {
      case 'gu':
        return RhymeCatalog.gujarati;
      case 'hi':
        return RhymeCatalog.hindi;
      default:
        return RhymeCatalog.english;
    }
  }

  static String headerKeyForLocale(String languageCode) {
    switch (catalogForLocale(languageCode)) {
      case RhymeCatalog.gujarati:
        return 'rhymes.headerGujarati';
      case RhymeCatalog.hindi:
        return 'rhymes.headerHindi';
      case RhymeCatalog.english:
        return 'rhymes.headerEnglish';
    }
  }

  static bool showEnglishLocaleNote(String languageCode) {
    return languageCode == 'mr' || languageCode == 'pa' || languageCode == 'ta';
  }

  static List<RhymeItem> itemsForLocale(String languageCode) {
    switch (catalogForLocale(languageCode)) {
      case RhymeCatalog.gujarati:
        return _gujaratiItems;
      case RhymeCatalog.hindi:
        return _hindiItems;
      case RhymeCatalog.english:
        return _englishItems;
    }
  }
}
