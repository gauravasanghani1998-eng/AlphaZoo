import '../core/app_assets.dart';

/// Model class for alphabet items
class AlphabetItem {
  final String letter;
  final String image;
  final String word;
  final String description;

  const AlphabetItem({
    required this.letter,
    required this.image,
    required this.word,
    required this.description,
  });
}

/// Static data source for all 26 letters
class AlphabetData {
  AlphabetData._();

  static final List<AlphabetItem> items = [
    AlphabetItem(
      letter: 'A',
      image: AppAssets.letterImage('a'),
      word: 'Apple',
      description: 'A is for Apple, a sweet and crunchy fruit that grows on trees!',
    ),
    AlphabetItem(
      letter: 'B',
      image: AppAssets.letterImage('b'),
      word: 'Ball',
      description: 'B is for Ball, round and bouncy, perfect for playing!',
    ),
    AlphabetItem(
      letter: 'C',
      image: AppAssets.letterImage('c'),
      word: 'Cat',
      description: 'C is for Cat, a soft and furry friend with whiskers!',
    ),
    AlphabetItem(
      letter: 'D',
      image: AppAssets.letterImage('d'),
      word: 'Dolphin',
      description: 'D is for Dolphin, a smart and playful creature of the sea!',
    ),
    AlphabetItem(
      letter: 'E',
      image: AppAssets.letterImage('e'),
      word: 'Elephant',
      description: 'E is for Elephant, the biggest land animal with a long trunk!',
    ),
    AlphabetItem(
      letter: 'F',
      image: AppAssets.letterImage('f'),
      word: 'Fish',
      description: 'F is for Fish, colorful swimmers that live underwater!',
    ),
    AlphabetItem(
      letter: 'G',
      image: AppAssets.letterImage('g'),
      word: 'Giraffe',
      description: 'G is for Giraffe, with a long neck to reach the tallest trees!',
    ),
    AlphabetItem(
      letter: 'H',
      image: AppAssets.letterImage('h'),
      word: 'House',
      description: 'H is for House, a cozy place where families live together!',
    ),
    AlphabetItem(
      letter: 'I',
      image: AppAssets.letterImage('i'),
      word: 'Ice Cream',
      description: 'I is for Ice Cream, a cold and sweet treat on a hot day!',
    ),
    AlphabetItem(
      letter: 'J',
      image: AppAssets.letterImage('j'),
      word: 'Jar',
      description: 'J is for Jar, a container that can hold yummy treats!',
    ),
    AlphabetItem(
      letter: 'K',
      image: AppAssets.letterImage('k'),
      word: 'Kite',
      description: 'K is for Kite, flying high in the sky on a windy day!',
    ),
    AlphabetItem(
      letter: 'L',
      image: AppAssets.letterImage('l'),
      word: 'Lion',
      description: 'L is for Lion, the brave king of the jungle with a big mane!',
    ),
    AlphabetItem(
      letter: 'M',
      image: AppAssets.letterImage('m'),
      word: 'Monkey',
      description: 'M is for Monkey, swinging through trees and eating bananas!',
    ),
    AlphabetItem(
      letter: 'N',
      image: AppAssets.letterImage('n'),
      word: 'Nest',
      description: 'N is for Nest, a cozy home where birds lay their eggs!',
    ),
    AlphabetItem(
      letter: 'O',
      image: AppAssets.letterImage('o'),
      word: 'Orange',
      description: 'O is for Orange, a juicy fruit full of vitamin C!',
    ),
    AlphabetItem(
      letter: 'P',
      image: AppAssets.letterImage('p'),
      word: 'Panda',
      description: 'P is for Panda, a cuddly black and white bear that loves bamboo!',
    ),
    AlphabetItem(
      letter: 'Q',
      image: AppAssets.letterImage('q'),
      word: 'Queen',
      description: 'Q is for Queen, a royal leader who wears a beautiful crown!',
    ),
    AlphabetItem(
      letter: 'R',
      image: AppAssets.letterImage('r'),
      word: 'Rocket',
      description: 'R is for Rocket, zooming through space to explore the stars!',
    ),
    AlphabetItem(
      letter: 'S',
      image: AppAssets.letterImage('s'),
      word: 'Sun',
      description: 'S is for Sun, shining bright and keeping us warm every day!',
    ),
    AlphabetItem(
      letter: 'T',
      image: AppAssets.letterImage('t'),
      word: 'Tree',
      description: 'T is for Tree, tall and strong with leaves and branches!',
    ),
    AlphabetItem(
      letter: 'U',
      image: AppAssets.letterImage('u'),
      word: 'Umbrella',
      description: 'U is for Umbrella, keeping us dry when it rains!',
    ),
    AlphabetItem(
      letter: 'V',
      image: AppAssets.letterImage('v'),
      word: 'Violin',
      description: 'V is for Violin, a musical instrument that makes beautiful sounds!',
    ),
    AlphabetItem(
      letter: 'W',
      image: AppAssets.letterImage('w'),
      word: 'Whale',
      description: 'W is for Whale, the largest animal swimming in the ocean!',
    ),
    AlphabetItem(
      letter: 'X',
      image: AppAssets.letterImage('x'),
      word: 'Xylophone',
      description: 'X is for Xylophone, a colorful instrument you play with mallets!',
    ),
    AlphabetItem(
      letter: 'Y',
      image: AppAssets.letterImage('y'),
      word: 'Yacht',
      description: 'Y is for Yacht, a fancy boat that sails on the water!',
    ),
    AlphabetItem(
      letter: 'Z',
      image: AppAssets.letterImage('z'),
      word: 'Zebra',
      description: 'Z is for Zebra, a striped animal that looks like a horse!',
    ),
  ];

  /// Get a specific letter item by index
  static AlphabetItem getItem(int index) {
    if (index >= 0 && index < items.length) {
      return items[index];
    }
    return items[0];
  }

  /// Get a specific letter item by letter
  static AlphabetItem? getItemByLetter(String letter) {
    try {
      return items.firstWhere(
        (item) => item.letter.toLowerCase() == letter.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Total count of alphabet items
  static int get count => items.length;
}
