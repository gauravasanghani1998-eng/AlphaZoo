class SpellingItem {
  final String emoji;
  final String nameKey;
  final String category;

  const SpellingItem({
    required this.emoji,
    required this.nameKey,
    required this.category,
  });
}

class SpellingData {
  SpellingData._();

  static const List<String> categories = [
    'animals',
    'birds',
    'seaAnimals',
    'fruits',
    'vegetables',
    'flowers',
    'nature',
  ];

  static final List<SpellingItem> items = [
    SpellingItem(
        emoji: '🐶',
        nameKey: 'spelling.animals.names.dog',
        category: 'animals'),
    SpellingItem(
        emoji: '🐱',
        nameKey: 'spelling.animals.names.cat',
        category: 'animals'),
    SpellingItem(
        emoji: '🦁',
        nameKey: 'spelling.animals.names.lion',
        category: 'animals'),
    SpellingItem(
        emoji: '🐘',
        nameKey: 'spelling.animals.names.elephant',
        category: 'animals'),
    SpellingItem(
        emoji: '🐼',
        nameKey: 'spelling.animals.names.panda',
        category: 'animals'),
    SpellingItem(
        emoji: '🐵',
        nameKey: 'spelling.animals.names.monkey',
        category: 'animals'),
    SpellingItem(
        emoji: '🦊',
        nameKey: 'spelling.animals.names.fox',
        category: 'animals'),
    SpellingItem(
        emoji: '🐰',
        nameKey: 'spelling.animals.names.rabbit',
        category: 'animals'),
    SpellingItem(
        emoji: '🐯',
        nameKey: 'spelling.animals.names.tiger',
        category: 'animals'),
    SpellingItem(
        emoji: '🐻',
        nameKey: 'spelling.animals.names.bear',
        category: 'animals'),
    SpellingItem(
        emoji: '🦓',
        nameKey: 'spelling.animals.names.zebra',
        category: 'animals'),
    SpellingItem(
        emoji: '🦒',
        nameKey: 'spelling.animals.names.giraffe',
        category: 'animals'),
    SpellingItem(
        emoji: '🐷',
        nameKey: 'spelling.animals.names.pig',
        category: 'animals'),
    SpellingItem(
        emoji: '🐄',
        nameKey: 'spelling.animals.names.cow',
        category: 'animals'),
    SpellingItem(
        emoji: '🐴',
        nameKey: 'spelling.animals.names.horse',
        category: 'animals'),
    SpellingItem(
        emoji: '🐑',
        nameKey: 'spelling.animals.names.sheep',
        category: 'animals'),
    SpellingItem(
        emoji: '🐐',
        nameKey: 'spelling.animals.names.goat',
        category: 'animals'),
    SpellingItem(
        emoji: '🦌',
        nameKey: 'spelling.animals.names.deer',
        category: 'animals'),
    SpellingItem(
        emoji: '🐫',
        nameKey: 'spelling.animals.names.camel',
        category: 'animals'),
    SpellingItem(
        emoji: '🐺',
        nameKey: 'spelling.animals.names.wolf',
        category: 'animals'),
    SpellingItem(
        emoji: '🦘',
        nameKey: 'spelling.animals.names.kangaroo',
        category: 'animals'),
    SpellingItem(
        emoji: '🦍',
        nameKey: 'spelling.animals.names.gorilla',
        category: 'animals'),
    SpellingItem(
        emoji: '🦛',
        nameKey: 'spelling.animals.names.hippo',
        category: 'animals'),
    SpellingItem(
        emoji: '🦏',
        nameKey: 'spelling.animals.names.rhino',
        category: 'animals'),
    SpellingItem(
        emoji: '🐆',
        nameKey: 'spelling.animals.names.leopard',
        category: 'animals'),
    SpellingItem(
        emoji: '🐿️',
        nameKey: 'spelling.animals.names.squirrel',
        category: 'animals'),
    SpellingItem(
        emoji: '🦔',
        nameKey: 'spelling.animals.names.hedgehog',
        category: 'animals'),
    SpellingItem(
        emoji: '🐭',
        nameKey: 'spelling.animals.names.mouse',
        category: 'animals'),
    SpellingItem(
        emoji: '🐹',
        nameKey: 'spelling.animals.names.hamster',
        category: 'animals'),
    SpellingItem(
        emoji: '🦇',
        nameKey: 'spelling.animals.names.bat',
        category: 'animals'),
    SpellingItem(
        emoji: '🐍',
        nameKey: 'spelling.animals.names.snake',
        category: 'animals'),
    SpellingItem(
        emoji: '🦎',
        nameKey: 'spelling.animals.names.lizard',
        category: 'animals'),
    SpellingItem(
        emoji: '🐸',
        nameKey: 'spelling.animals.names.frog',
        category: 'animals'),
    SpellingItem(
        emoji: '🐜',
        nameKey: 'spelling.animals.names.ant',
        category: 'animals'),
    SpellingItem(
        emoji: '🐝',
        nameKey: 'spelling.animals.names.bee',
        category: 'animals'),
    SpellingItem(
        emoji: '🐞',
        nameKey: 'spelling.animals.names.ladybug',
        category: 'animals'),
    SpellingItem(
        emoji: '🦋',
        nameKey: 'spelling.animals.names.butterfly',
        category: 'animals'),
    SpellingItem(
        emoji: '🦂',
        nameKey: 'spelling.animals.names.scorpion',
        category: 'animals'),
    SpellingItem(
        emoji: '🕷️',
        nameKey: 'spelling.animals.names.spider',
        category: 'animals'),
    SpellingItem(
        emoji: '🦝',
        nameKey: 'spelling.animals.names.raccoon',
        category: 'animals'),
    SpellingItem(
        emoji: '🦨',
        nameKey: 'spelling.animals.names.skunk',
        category: 'animals'),
    SpellingItem(
        emoji: '🦫',
        nameKey: 'spelling.animals.names.beaver',
        category: 'animals'),
    SpellingItem(
        emoji: '🦬',
        nameKey: 'spelling.animals.names.bison',
        category: 'animals'),
    SpellingItem(
        emoji: '🐗',
        nameKey: 'spelling.animals.names.boar',
        category: 'animals'),
    SpellingItem(
        emoji: '🦡',
        nameKey: 'spelling.animals.names.badger',
        category: 'animals'),
    SpellingItem(
        emoji: '🐊',
        nameKey: 'spelling.animals.names.crocodile',
        category: 'animals'),
    SpellingItem(
        emoji: '🦧',
        nameKey: 'spelling.animals.names.orangutan',
        category: 'animals'),

    // Birds
    SpellingItem(
        emoji: '🦅', nameKey: 'spelling.birds.names.eagle', category: 'birds'),
    SpellingItem(
        emoji: '🦆', nameKey: 'spelling.birds.names.duck', category: 'birds'),
    SpellingItem(
        emoji: '🦉', nameKey: 'spelling.birds.names.owl', category: 'birds'),
    SpellingItem(
        emoji: '🕊️', nameKey: 'spelling.birds.names.dove', category: 'birds'),
    SpellingItem(
        emoji: '🦢', nameKey: 'spelling.birds.names.swan', category: 'birds'),
    SpellingItem(
        emoji: '🦜', nameKey: 'spelling.birds.names.parrot', category: 'birds'),
    SpellingItem(
        emoji: '🐔', nameKey: 'spelling.birds.names.hen', category: 'birds'),
    SpellingItem(
        emoji: '🦩',
        nameKey: 'spelling.birds.names.flamingo',
        category: 'birds'),
    SpellingItem(
        emoji: '🐣', nameKey: 'spelling.birds.names.chick', category: 'birds'),
    SpellingItem(
        emoji: '🐧',
        nameKey: 'spelling.birds.names.penguin',
        category: 'birds'),
    SpellingItem(
        emoji: '🐓',
        nameKey: 'spelling.birds.names.rooster',
        category: 'birds'),
    SpellingItem(
        emoji: '🦚',
        nameKey: 'spelling.birds.names.peacock',
        category: 'birds'),
    SpellingItem(
        emoji: '🦃', nameKey: 'spelling.birds.names.turkey', category: 'birds'),
    SpellingItem(
        emoji: '🐤',
        nameKey: 'spelling.birds.names.babyChick',
        category: 'birds'),
    SpellingItem(
        emoji: '🐦', nameKey: 'spelling.birds.names.bird', category: 'birds'),

    // Sea animals
    SpellingItem(
        emoji: '🐟',
        nameKey: 'spelling.seaAnimals.names.fish',
        category: 'seaAnimals'),
    SpellingItem(
        emoji: '🐬',
        nameKey: 'spelling.seaAnimals.names.dolphin',
        category: 'seaAnimals'),
    SpellingItem(
        emoji: '🐳',
        nameKey: 'spelling.seaAnimals.names.whale',
        category: 'seaAnimals'),
    SpellingItem(
        emoji: '🦈',
        nameKey: 'spelling.seaAnimals.names.shark',
        category: 'seaAnimals'),
    SpellingItem(
        emoji: '🐙',
        nameKey: 'spelling.seaAnimals.names.octopus',
        category: 'seaAnimals'),
    SpellingItem(
        emoji: '🦀',
        nameKey: 'spelling.seaAnimals.names.crab',
        category: 'seaAnimals'),
    SpellingItem(
        emoji: '🦞',
        nameKey: 'spelling.seaAnimals.names.lobster',
        category: 'seaAnimals'),
    SpellingItem(
        emoji: '🐡',
        nameKey: 'spelling.seaAnimals.names.pufferfish',
        category: 'seaAnimals'),
    SpellingItem(
        emoji: '🦭',
        nameKey: 'spelling.seaAnimals.names.seal',
        category: 'seaAnimals'),
    SpellingItem(
        emoji: '🐠',
        nameKey: 'spelling.seaAnimals.names.tropicalFish',
        category: 'seaAnimals'),
    SpellingItem(
        emoji: '🐚',
        nameKey: 'spelling.seaAnimals.names.seashell',
        category: 'seaAnimals'),
    SpellingItem(
        emoji: '🐢',
        nameKey: 'spelling.seaAnimals.names.seaTurtle',
        category: 'seaAnimals'),
    SpellingItem(
        emoji: '🦐',
        nameKey: 'spelling.seaAnimals.names.shrimp',
        category: 'seaAnimals'),
    SpellingItem(
        emoji: '🦑',
        nameKey: 'spelling.seaAnimals.names.squid',
        category: 'seaAnimals'),

    // Fruits
    SpellingItem(
        emoji: '🍎',
        nameKey: 'spelling.fruits.names.apple',
        category: 'fruits'),
    SpellingItem(
        emoji: '🍌',
        nameKey: 'spelling.fruits.names.banana',
        category: 'fruits'),
    SpellingItem(
        emoji: '🍏',
        nameKey: 'spelling.fruits.names.greenApple',
        category: 'fruits'),
    SpellingItem(
        emoji: '🍇',
        nameKey: 'spelling.fruits.names.grapes',
        category: 'fruits'),
    SpellingItem(
        emoji: '🍊',
        nameKey: 'spelling.fruits.names.orange',
        category: 'fruits'),
    SpellingItem(
        emoji: '🍋',
        nameKey: 'spelling.fruits.names.lemon',
        category: 'fruits'),
    SpellingItem(
        emoji: '🍉',
        nameKey: 'spelling.fruits.names.watermelon',
        category: 'fruits'),
    SpellingItem(
        emoji: '🍓',
        nameKey: 'spelling.fruits.names.strawberry',
        category: 'fruits'),
    SpellingItem(
        emoji: '🍒',
        nameKey: 'spelling.fruits.names.cherry',
        category: 'fruits'),
    SpellingItem(
        emoji: '🍑',
        nameKey: 'spelling.fruits.names.peach',
        category: 'fruits'),
    SpellingItem(
        emoji: '🥭',
        nameKey: 'spelling.fruits.names.mango',
        category: 'fruits'),
    SpellingItem(
        emoji: '🍍',
        nameKey: 'spelling.fruits.names.pineapple',
        category: 'fruits'),
    SpellingItem(
        emoji: '🥥',
        nameKey: 'spelling.fruits.names.coconut',
        category: 'fruits'),
    SpellingItem(
        emoji: '🥝', nameKey: 'spelling.fruits.names.kiwi', category: 'fruits'),
    SpellingItem(
        emoji: '🍐', nameKey: 'spelling.fruits.names.pear', category: 'fruits'),
    SpellingItem(
        emoji: '🍈',
        nameKey: 'spelling.fruits.names.melon',
        category: 'fruits'),
    SpellingItem(
        emoji: '🥑',
        nameKey: 'spelling.fruits.names.avocado',
        category: 'fruits'),

    // Vegetables
    SpellingItem(
        emoji: '🥕',
        nameKey: 'spelling.vegetables.names.carrot',
        category: 'vegetables'),
    SpellingItem(
        emoji: '🥔',
        nameKey: 'spelling.vegetables.names.potato',
        category: 'vegetables'),
    SpellingItem(
        emoji: '🧅',
        nameKey: 'spelling.vegetables.names.onion',
        category: 'vegetables'),
    SpellingItem(
        emoji: '🧄',
        nameKey: 'spelling.vegetables.names.garlic',
        category: 'vegetables'),
    SpellingItem(
        emoji: '🥦',
        nameKey: 'spelling.vegetables.names.broccoli',
        category: 'vegetables'),
    SpellingItem(
        emoji: '🥬',
        nameKey: 'spelling.vegetables.names.lettuce',
        category: 'vegetables'),
    SpellingItem(
        emoji: '🥒',
        nameKey: 'spelling.vegetables.names.cucumber',
        category: 'vegetables'),
    SpellingItem(
        emoji: '🌽',
        nameKey: 'spelling.vegetables.names.corn',
        category: 'vegetables'),
    SpellingItem(
        emoji: '🎃',
        nameKey: 'spelling.vegetables.names.pumpkin',
        category: 'vegetables'),
    SpellingItem(
        emoji: '🍆',
        nameKey: 'spelling.vegetables.names.eggplant',
        category: 'vegetables'),
    SpellingItem(
        emoji: '🍄',
        nameKey: 'spelling.vegetables.names.mushroom',
        category: 'vegetables'),
    SpellingItem(
        emoji: '🌶️',
        nameKey: 'spelling.vegetables.names.chili',
        category: 'vegetables'),
    SpellingItem(
        emoji: '🥜',
        nameKey: 'spelling.vegetables.names.peanut',
        category: 'vegetables'),
    SpellingItem(
        emoji: '🍅',
        nameKey: 'spelling.vegetables.names.tomato',
        category: 'vegetables'),
    SpellingItem(
        emoji: '🍠',
        nameKey: 'spelling.vegetables.names.sweetPotato',
        category: 'vegetables'),

    // Flowers
    SpellingItem(
        emoji: '🌹',
        nameKey: 'spelling.flowers.names.rose',
        category: 'flowers'),
    SpellingItem(
        emoji: '🌷',
        nameKey: 'spelling.flowers.names.tulip',
        category: 'flowers'),
    SpellingItem(
        emoji: '🌼',
        nameKey: 'spelling.flowers.names.daisy',
        category: 'flowers'),
    SpellingItem(
        emoji: '🌻',
        nameKey: 'spelling.flowers.names.sunflower',
        category: 'flowers'),
    SpellingItem(
        emoji: '🌸',
        nameKey: 'spelling.flowers.names.blossom',
        category: 'flowers'),
    SpellingItem(
        emoji: '🌺',
        nameKey: 'spelling.flowers.names.hibiscus',
        category: 'flowers'),
    SpellingItem(
        emoji: '🥀',
        nameKey: 'spelling.flowers.names.dryFlower',
        category: 'flowers'),
    SpellingItem(
        emoji: '💐',
        nameKey: 'spelling.flowers.names.bouquet',
        category: 'flowers'),

    // Earth & nature
    SpellingItem(
        emoji: '🌍',
        nameKey: 'spelling.nature.names.earth',
        category: 'nature'),
    SpellingItem(
        emoji: '🏔️',
        nameKey: 'spelling.nature.names.snowMountain',
        category: 'nature'),

    SpellingItem(
        emoji: '⛰️',
        nameKey: 'spelling.nature.names.mountain',
        category: 'nature'),
    SpellingItem(
        emoji: '🌳', nameKey: 'spelling.nature.names.tree', category: 'nature'),
    SpellingItem(
        emoji: '🌋',
        nameKey: 'spelling.nature.names.volcano',
        category: 'nature'),
    SpellingItem(
        emoji: '🏜️',
        nameKey: 'spelling.nature.names.desert',
        category: 'nature'),
    SpellingItem(
        emoji: '🏝️',
        nameKey: 'spelling.nature.names.island',
        category: 'nature'),
    SpellingItem(
        emoji: '🏖️',
        nameKey: 'spelling.nature.names.beach',
        category: 'nature'),
    SpellingItem(
        emoji: '🏞️',
        nameKey: 'spelling.nature.names.valley',
        category: 'nature'),
    SpellingItem(
        emoji: '🪨', nameKey: 'spelling.nature.names.rock', category: 'nature'),
    SpellingItem(
        emoji: '🪵', nameKey: 'spelling.nature.names.wood', category: 'nature'),
    SpellingItem(
        emoji: '🍃', nameKey: 'spelling.nature.names.leaf', category: 'nature'),

    SpellingItem(
        emoji: '🌿', nameKey: 'spelling.nature.names.herb', category: 'nature'),
    SpellingItem(
        emoji: '🌾',
        nameKey: 'spelling.nature.names.wheatField',
        category: 'nature'),
    SpellingItem(
        emoji: '🌱',
        nameKey: 'spelling.nature.names.seedling',
        category: 'nature'),
    SpellingItem(
        emoji: '🪴',
        nameKey: 'spelling.nature.names.plant',
        category: 'nature'),
    SpellingItem(
        emoji: '🌉',
        nameKey: 'spelling.nature.names.bridge',
        category: 'nature'),
    SpellingItem(
        emoji: '🏕️',
        nameKey: 'spelling.nature.names.camping',
        category: 'nature'),
    SpellingItem(
        emoji: '🛖', nameKey: 'spelling.nature.names.hut', category: 'nature'),
    SpellingItem(
        emoji: '⛺', nameKey: 'spelling.nature.names.tent', category: 'nature'),
    SpellingItem(
        emoji: '🗻',
        nameKey: 'spelling.nature.names.mountFuji',
        category: 'nature'),
    SpellingItem(
        emoji: '☀️', nameKey: 'spelling.nature.names.sun', category: 'nature'),
    SpellingItem(
        emoji: '🌙', nameKey: 'spelling.nature.names.moon', category: 'nature'),
    SpellingItem(
        emoji: '⭐', nameKey: 'spelling.nature.names.star', category: 'nature'),
    SpellingItem(
        emoji: '🪐',
        nameKey: 'spelling.nature.names.saturn',
        category: 'nature'),
    SpellingItem(
        emoji: '💫',
        nameKey: 'spelling.nature.names.sparkle',
        category: 'nature'),
    SpellingItem(
        emoji: '🌌',
        nameKey: 'spelling.nature.names.nightSky',
        category: 'nature'),
  ];

  static List<SpellingItem> byCategory(String category) {
    return items
        .where((item) => item.category.toLowerCase() == category.toLowerCase())
        .toList();
  }
}
