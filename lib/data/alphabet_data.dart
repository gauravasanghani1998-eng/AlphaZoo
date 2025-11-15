import '../core/app_assets.dart';

/// Model class for alphabet items
class AlphabetItem {
  final String letter;
  final String image;
  final String word;
  final String description;
  final String funFact;
  final String sound;

  const AlphabetItem({
    required this.letter,
    required this.image,
    required this.word,
    required this.description,
    required this.funFact,
    required this.sound,
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
      funFact: 'Apples come in many colors: red, green, and yellow!',
      sound: 'ay',
    ),
    AlphabetItem(
      letter: 'B',
      image: AppAssets.letterImage('b'),
      word: 'Ball',
      description: 'B is for Ball, round and bouncy, perfect for playing!',
      funFact: 'Balls can bounce high when you throw them down!',
      sound: 'buh',
    ),
    AlphabetItem(
      letter: 'C',
      image: AppAssets.letterImage('c'),
      word: 'Cat',
      description: 'C is for Cat, a soft and furry friend with whiskers!',
      funFact: 'Cats love to purr when they are happy and comfortable!',
      sound: 'kuh',
    ),
    AlphabetItem(
      letter: 'D',
      image: AppAssets.letterImage('d'),
      word: 'Dolphin',
      description: 'D is for Dolphin, a smart and playful creature of the sea!',
      funFact: 'Dolphins can jump high out of the water and do flips!',
      sound: 'duh',
    ),
    AlphabetItem(
      letter: 'E',
      image: AppAssets.letterImage('e'),
      word: 'Elephant',
      description: 'E is for Elephant, the biggest land animal with a long trunk!',
      funFact: 'Elephants use their trunks to drink water and pick up things!',
      sound: 'eh',
    ),
    AlphabetItem(
      letter: 'F',
      image: AppAssets.letterImage('f'),
      word: 'Fish',
      description: 'F is for Fish, colorful swimmers that live underwater!',
      funFact: 'Fish breathe through gills and can swim very fast!',
      sound: 'fuh',
    ),
    AlphabetItem(
      letter: 'G',
      image: AppAssets.letterImage('g'),
      word: 'Giraffe',
      description: 'G is for Giraffe, with a long neck to reach the tallest trees!',
      funFact: 'Giraffes are the tallest animals in the world!',
      sound: 'guh',
    ),
    AlphabetItem(
      letter: 'H',
      image: AppAssets.letterImage('h'),
      word: 'House',
      description: 'H is for House, a cozy place where families live together!',
      funFact: 'Every house is special and different, just like you!',
      sound: 'huh',
    ),
    AlphabetItem(
      letter: 'I',
      image: AppAssets.letterImage('i'),
      word: 'Ice Cream',
      description: 'I is for Ice Cream, a cold and sweet treat on a hot day!',
      funFact: 'Ice cream comes in so many yummy flavors!',
      sound: 'ih',
    ),
    AlphabetItem(
      letter: 'J',
      image: AppAssets.letterImage('j'),
      word: 'Jar',
      description: 'J is for Jar, a container that can hold yummy treats!',
      funFact: 'You can store cookies, candies, or jam in a jar!',
      sound: 'juh',
    ),
    AlphabetItem(
      letter: 'K',
      image: AppAssets.letterImage('k'),
      word: 'Kite',
      description: 'K is for Kite, flying high in the sky on a windy day!',
      funFact: 'Kites need wind to fly up into the sky!',
      sound: 'kuh',
    ),
    AlphabetItem(
      letter: 'L',
      image: AppAssets.letterImage('l'),
      word: 'Lion',
      description: 'L is for Lion, the brave king of the jungle with a big mane!',
      funFact: 'Lions live in groups called prides!',
      sound: 'luh',
    ),
    AlphabetItem(
      letter: 'M',
      image: AppAssets.letterImage('m'),
      word: 'Monkey',
      description: 'M is for Monkey, swinging through trees and eating bananas!',
      funFact: 'Monkeys love to play and are very good climbers!',
      sound: 'muh',
    ),
    AlphabetItem(
      letter: 'N',
      image: AppAssets.letterImage('n'),
      word: 'Nest',
      description: 'N is for Nest, a cozy home where birds lay their eggs!',
      funFact: 'Birds build nests with twigs and leaves!',
      sound: 'nuh',
    ),
    AlphabetItem(
      letter: 'O',
      image: AppAssets.letterImage('o'),
      word: 'Orange',
      description: 'O is for Orange, a juicy fruit full of vitamin C!',
      funFact: 'Oranges are both a fruit and a color!',
      sound: 'oh',
    ),
    AlphabetItem(
      letter: 'P',
      image: AppAssets.letterImage('p'),
      word: 'Panda',
      description: 'P is for Panda, a cuddly black and white bear that loves bamboo!',
      funFact: 'Pandas spend most of their day eating bamboo!',
      sound: 'puh',
    ),
    AlphabetItem(
      letter: 'Q',
      image: AppAssets.letterImage('q'),
      word: 'Queen',
      description: 'Q is for Queen, a royal leader who wears a beautiful crown!',
      funFact: 'Queens live in palaces and wear fancy dresses!',
      sound: 'kwuh',
    ),
    AlphabetItem(
      letter: 'R',
      image: AppAssets.letterImage('r'),
      word: 'Rocket',
      description: 'R is for Rocket, zooming through space to explore the stars!',
      funFact: 'Rockets can travel to the moon and beyond!',
      sound: 'ruh',
    ),
    AlphabetItem(
      letter: 'S',
      image: AppAssets.letterImage('s'),
      word: 'Sun',
      description: 'S is for Sun, shining bright and keeping us warm every day!',
      funFact: 'The sun is a big star that gives us light and warmth!',
      sound: 'suh',
    ),
    AlphabetItem(
      letter: 'T',
      image: AppAssets.letterImage('t'),
      word: 'Tree',
      description: 'T is for Tree, tall and strong with leaves and branches!',
      funFact: 'Trees give us fresh air and shade on sunny days!',
      sound: 'tuh',
    ),
    AlphabetItem(
      letter: 'U',
      image: AppAssets.letterImage('u'),
      word: 'Umbrella',
      description: 'U is for Umbrella, keeping us dry when it rains!',
      funFact: 'Umbrellas come in many colors and patterns!',
      sound: 'uh',
    ),
    AlphabetItem(
      letter: 'V',
      image: AppAssets.letterImage('v'),
      word: 'Violin',
      description: 'V is for Violin, a musical instrument that makes beautiful sounds!',
      funFact: 'You play the violin with a bow and make lovely music!',
      sound: 'vuh',
    ),
    AlphabetItem(
      letter: 'W',
      image: AppAssets.letterImage('w'),
      word: 'Whale',
      description: 'W is for Whale, the largest animal swimming in the ocean!',
      funFact: 'Whales can sing songs under the water!',
      sound: 'wuh',
    ),
    AlphabetItem(
      letter: 'X',
      image: AppAssets.letterImage('x'),
      word: 'Xylophone',
      description: 'X is for Xylophone, a colorful instrument you play with mallets!',
      funFact: 'Each bar on a xylophone makes a different musical note!',
      sound: 'ks',
    ),
    AlphabetItem(
      letter: 'Y',
      image: AppAssets.letterImage('y'),
      word: 'Yacht',
      description: 'Y is for Yacht, a fancy boat that sails on the water!',
      funFact: 'Yachts have big sails to catch the wind!',
      sound: 'yuh',
    ),
    AlphabetItem(
      letter: 'Z',
      image: AppAssets.letterImage('z'),
      word: 'Zebra',
      description: 'Z is for Zebra, a striped animal that looks like a horse!',
      funFact: 'Every zebra has its own unique stripe pattern!',
      sound: 'zuh',
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
