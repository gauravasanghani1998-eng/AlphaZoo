import '../core/app_assets.dart';

class AlphabetItem {
  final String letter;
  final String id;
  final String image;
  final String sound;
  final String word;
  final List<String> moreWords;

  const AlphabetItem({
    required this.letter,
    required this.id,
    required this.image,
    required this.sound,
    required this.word,
    required this.moreWords,
  });

  String get descriptionKey => 'alphabet.letters.$id.description';

  String get funFactKey => 'alphabet.letters.$id.funFact';
}

class AlphabetData {
  AlphabetData._();

  static final List<AlphabetItem> items = [
    AlphabetItem(
      letter: 'A',
      id: 'a',
      image: AppAssets.letterImage('a'),
      sound: 'ay',
      word: 'Apple',
      moreWords: ['Ant', 'Airplane', 'Alligator'],
    ),
    AlphabetItem(
      letter: 'B',
      id: 'b',
      image: AppAssets.letterImage('b'),
      sound: 'buh',
      word: 'Ball',
      moreWords: ['Bear', 'Banana', 'Butterfly'],
    ),
    AlphabetItem(
      letter: 'C',
      id: 'c',
      image: AppAssets.letterImage('c'),
      sound: 'kuh',
      word: 'Cat',
      moreWords: ['Cake', 'Carrot', 'Castle'],
    ),
    AlphabetItem(
      letter: 'D',
      id: 'd',
      image: AppAssets.letterImage('d'),
      sound: 'duh',
      word: 'Dog',
      moreWords: ['Dolphin', 'Duck', 'Dragon'],
    ),
    AlphabetItem(
      letter: 'E',
      id: 'e',
      image: AppAssets.letterImage('e'),
      sound: 'eh',
      word: 'Elephant',
      moreWords: ['Egg', 'Eagle', 'Envelope'],
    ),
    AlphabetItem(
      letter: 'F',
      id: 'f',
      image: AppAssets.letterImage('f'),
      sound: 'fuh',
      word: 'Fish',
      moreWords: ['Frog', 'Flower', 'Fire'],
    ),
    AlphabetItem(
      letter: 'G',
      id: 'g',
      image: AppAssets.letterImage('g'),
      sound: 'guh',
      word: 'Gun',
      moreWords: ['Giraffe', 'Grapes', 'Guitar'],
    ),
    AlphabetItem(
      letter: 'H',
      id: 'h',
      image: AppAssets.letterImage('h'),
      sound: 'huh',
      word: 'House',
      moreWords: ['Hat', 'Horse', 'Helicopter'],
    ),
    AlphabetItem(
      letter: 'I',
      id: 'i',
      image: AppAssets.letterImage('i'),
      sound: 'ih',
      word: 'Ice Cream',
      moreWords: ['Igloo', 'Insect', 'Island'],
    ),
    AlphabetItem(
      letter: 'J',
      id: 'j',
      image: AppAssets.letterImage('j'),
      sound: 'juh',
      word: 'Jug',
      moreWords: ['Jar', 'Juice', 'Jacket'],
    ),
    AlphabetItem(
      letter: 'K',
      id: 'k',
      image: AppAssets.letterImage('k'),
      sound: 'kuh',
      word: 'Kite',
      moreWords: ['King', 'Kangaroo', 'Key'],
    ),
    AlphabetItem(
      letter: 'L',
      id: 'l',
      image: AppAssets.letterImage('l'),
      sound: 'luh',
      word: 'Lion',
      moreWords: ['Lemon', 'Ladybug', 'Lamp'],
    ),
    AlphabetItem(
      letter: 'M',
      id: 'm',
      image: AppAssets.letterImage('m'),
      sound: 'muh',
      word: 'Monkey',
      moreWords: ['Mouse', 'Moon', 'Mountain'],
    ),
    AlphabetItem(
      letter: 'N',
      id: 'n',
      image: AppAssets.letterImage('n'),
      sound: 'nuh',
      word: 'Nest',
      moreWords: ['Nose', 'Noodles', 'Notebook'],
    ),
    AlphabetItem(
      letter: 'O',
      id: 'o',
      image: AppAssets.letterImage('o'),
      sound: 'oh',
      word: 'Orange',
      moreWords: ['Octopus', 'Owl', 'Ocean'],
    ),
    AlphabetItem(
      letter: 'P',
      id: 'p',
      image: AppAssets.letterImage('p'),
      sound: 'puh',
      word: 'Parrot',
      moreWords: ['Panda', 'Penguin', 'Pencil'],
    ),
    AlphabetItem(
      letter: 'Q',
      id: 'q',
      image: AppAssets.letterImage('q'),
      sound: 'kwuh',
      word: 'Queen',
      moreWords: ['Quilt', 'Question', 'Quail'],
    ),
    AlphabetItem(
      letter: 'R',
      id: 'r',
      image: AppAssets.letterImage('r'),
      sound: 'ruh',
      word: 'Rabbit',
      moreWords: ['Rocket', 'Rainbow', 'River'],
    ),
    AlphabetItem(
      letter: 'S',
      id: 's',
      image: AppAssets.letterImage('s'),
      sound: 'suh',
      word: 'Sun',
      moreWords: ['Star', 'Snake', 'Sandwich'],
    ),
    AlphabetItem(
      letter: 'T',
      id: 't',
      image: AppAssets.letterImage('t'),
      sound: 'tuh',
      word: 'Tiger',
      moreWords: ['Tree', 'Turtle', 'Telephone'],
    ),
    AlphabetItem(
      letter: 'U',
      id: 'u',
      image: AppAssets.letterImage('u'),
      sound: 'uh',
      word: 'Umbrella',
      moreWords: ['Unicorn', 'Union', 'Universe'],
    ),
    AlphabetItem(
      letter: 'V',
      id: 'v',
      image: AppAssets.letterImage('v'),
      sound: 'vuh',
      word: 'Violin',
      moreWords: ['Vase', 'Vegetable', 'Volcano'],
    ),
    AlphabetItem(
      letter: 'W',
      id: 'w',
      image: AppAssets.letterImage('w'),
      sound: 'wuh',
      word: 'Watch',
      moreWords: ['Whale', 'Wolf', 'Window'],
    ),
    AlphabetItem(
      letter: 'X',
      id: 'x',
      image: AppAssets.letterImage('x'),
      sound: 'ks',
      word: 'Xmas Tree',
      moreWords: ['Xylophone', 'X-ray', 'Xbox'],
    ),
    AlphabetItem(
      letter: 'Y',
      id: 'y',
      image: AppAssets.letterImage('y'),
      sound: 'yuh',
      word: 'Yak',
      moreWords: ['Yacht', 'Yellow', 'Yogurt'],
    ),
    AlphabetItem(
      letter: 'Z',
      id: 'z',
      image: AppAssets.letterImage('z'),
      sound: 'zuh',
      word: 'Zebra',
      moreWords: ['Zoo', 'Zipper', 'Zombie'],
    ),
  ];

  static AlphabetItem getItem(int index) {
    if (index >= 0 && index < items.length) {
      return items[index];
    }
    return items[0];
  }

  static AlphabetItem? getItemByLetter(String letter) {
    try {
      return items.firstWhere(
        (item) => item.letter.toLowerCase() == letter.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  static int get count => items.length;
}
