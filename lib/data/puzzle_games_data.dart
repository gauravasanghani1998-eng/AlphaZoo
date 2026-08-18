import 'dart:math';

import 'emotions_data.dart';
import 'opposites_data.dart';
import 'shapes_colors_data.dart';
import 'spelling_data.dart';
import 'vehicles_data.dart';

enum PuzzleGameId {
  memoryMatch,
  oppositesMatch,
  pictureWord,
  listenFind,
  sortBoxes,
  oddOneOut,
}

enum MemoryThemeId { animals, fruits, emotions, vehicles, shapes }

enum PuzzleDifficulty { easy, medium, hard }

enum SortModeId { fruitVeg, animalVehicle, emotionShape, fruitAnimal }

class PuzzleGameInfo {
  final PuzzleGameId id;
  final String emoji;
  final String titleKey;
  final String subtitleKey;
  final String badgeKey;

  const PuzzleGameInfo({
    required this.id,
    required this.emoji,
    required this.titleKey,
    required this.subtitleKey,
    required this.badgeKey,
  });
}

class MemoryThemeInfo {
  final MemoryThemeId id;
  final String emoji;
  final String titleKey;

  const MemoryThemeInfo({
    required this.id,
    required this.emoji,
    required this.titleKey,
  });
}

class MemoryCardFace {
  final String pairId;
  final String emoji;
  final String? labelKey;

  const MemoryCardFace({
    required this.pairId,
    required this.emoji,
    this.labelKey,
  });
}

class PuzzleContentItem {
  final String id;
  final String emoji;
  final String nameKey;
  final String group;

  const PuzzleContentItem({
    required this.id,
    required this.emoji,
    required this.nameKey,
    required this.group,
  });
}

class PictureWordRound {
  final PuzzleContentItem correct;
  final List<PuzzleContentItem> options;

  const PictureWordRound({
    required this.correct,
    required this.options,
  });
}

class ListenFindRound {
  final PuzzleContentItem correct;
  final List<PuzzleContentItem> options;

  const ListenFindRound({
    required this.correct,
    required this.options,
  });
}

class OddOneOutRound {
  final List<PuzzleContentItem> options;
  final int oddIndex;

  const OddOneOutRound({
    required this.options,
    required this.oddIndex,
  });
}

class SortModeInfo {
  final SortModeId id;
  final String titleKey;
  final String leftBoxKey;
  final String rightBoxKey;
  final String leftGroup;
  final String rightGroup;
  final String emoji;

  const SortModeInfo({
    required this.id,
    required this.titleKey,
    required this.leftBoxKey,
    required this.rightBoxKey,
    required this.leftGroup,
    required this.rightGroup,
    required this.emoji,
  });
}

class PuzzleGamesData {
  PuzzleGamesData._();

  static const List<PuzzleGameInfo> games = [
    PuzzleGameInfo(
      id: PuzzleGameId.memoryMatch,
      emoji: '🎴',
      titleKey: 'puzzleGames.memory.title',
      subtitleKey: 'puzzleGames.memory.subtitle',
      badgeKey: 'puzzleGames.memory.badge',
    ),
    PuzzleGameInfo(
      id: PuzzleGameId.oppositesMatch,
      emoji: '⚖️',
      titleKey: 'puzzleGames.opposites.title',
      subtitleKey: 'puzzleGames.opposites.subtitle',
      badgeKey: 'puzzleGames.opposites.badge',
    ),
    PuzzleGameInfo(
      id: PuzzleGameId.pictureWord,
      emoji: '🖼️',
      titleKey: 'puzzleGames.pictureWord.title',
      subtitleKey: 'puzzleGames.pictureWord.subtitle',
      badgeKey: 'puzzleGames.pictureWord.badge',
    ),
    PuzzleGameInfo(
      id: PuzzleGameId.listenFind,
      emoji: '👂',
      titleKey: 'puzzleGames.listenFind.title',
      subtitleKey: 'puzzleGames.listenFind.subtitle',
      badgeKey: 'puzzleGames.listenFind.badge',
    ),
    PuzzleGameInfo(
      id: PuzzleGameId.sortBoxes,
      emoji: '📦',
      titleKey: 'puzzleGames.sortBoxes.title',
      subtitleKey: 'puzzleGames.sortBoxes.subtitle',
      badgeKey: 'puzzleGames.sortBoxes.badge',
    ),
    PuzzleGameInfo(
      id: PuzzleGameId.oddOneOut,
      emoji: '🔎',
      titleKey: 'puzzleGames.oddOneOut.title',
      subtitleKey: 'puzzleGames.oddOneOut.subtitle',
      badgeKey: 'puzzleGames.oddOneOut.badge',
    ),
  ];

  static const List<MemoryThemeInfo> memoryThemes = [
    MemoryThemeInfo(
      id: MemoryThemeId.animals,
      emoji: '🦁',
      titleKey: 'puzzleGames.memory.themes.animals',
    ),
    MemoryThemeInfo(
      id: MemoryThemeId.fruits,
      emoji: '🍎',
      titleKey: 'puzzleGames.memory.themes.fruits',
    ),
    MemoryThemeInfo(
      id: MemoryThemeId.emotions,
      emoji: '😊',
      titleKey: 'puzzleGames.memory.themes.emotions',
    ),
    MemoryThemeInfo(
      id: MemoryThemeId.vehicles,
      emoji: '🚗',
      titleKey: 'puzzleGames.memory.themes.vehicles',
    ),
    MemoryThemeInfo(
      id: MemoryThemeId.shapes,
      emoji: '⭐',
      titleKey: 'puzzleGames.memory.themes.shapes',
    ),
  ];

  static const List<SortModeInfo> sortModes = [
    SortModeInfo(
      id: SortModeId.fruitVeg,
      titleKey: 'puzzleGames.sortBoxes.modeFruitVeg',
      leftBoxKey: 'puzzleGames.sortBoxes.boxFruits',
      rightBoxKey: 'puzzleGames.sortBoxes.boxVegetables',
      leftGroup: 'fruits',
      rightGroup: 'vegetables',
      emoji: '🥗',
    ),
    SortModeInfo(
      id: SortModeId.animalVehicle,
      titleKey: 'puzzleGames.sortBoxes.modeAnimalVehicle',
      leftBoxKey: 'puzzleGames.sortBoxes.boxAnimals',
      rightBoxKey: 'puzzleGames.sortBoxes.boxVehicles',
      leftGroup: 'animals',
      rightGroup: 'vehicles',
      emoji: '🚗',
    ),
    SortModeInfo(
      id: SortModeId.emotionShape,
      titleKey: 'puzzleGames.sortBoxes.modeEmotionShape',
      leftBoxKey: 'puzzleGames.sortBoxes.boxEmotions',
      rightBoxKey: 'puzzleGames.sortBoxes.boxShapes',
      leftGroup: 'emotions',
      rightGroup: 'shapes',
      emoji: '😊',
    ),
    SortModeInfo(
      id: SortModeId.fruitAnimal,
      titleKey: 'puzzleGames.sortBoxes.modeFruitAnimal',
      leftBoxKey: 'puzzleGames.sortBoxes.boxFruits',
      rightBoxKey: 'puzzleGames.sortBoxes.boxAnimals',
      leftGroup: 'fruits',
      rightGroup: 'animals',
      emoji: '🍎',
    ),
  ];

  static const PuzzleDifficulty defaultDifficulty = PuzzleDifficulty.hard;

  static int quizRoundCount(PuzzleDifficulty difficulty) {
    return switch (difficulty) {
      PuzzleDifficulty.easy => 6,
      PuzzleDifficulty.medium => 8,
      PuzzleDifficulty.hard => 10,
    };
  }

  static int pairCountFor(PuzzleDifficulty difficulty) {
    return switch (difficulty) {
      PuzzleDifficulty.easy => 4,
      PuzzleDifficulty.medium => 6,
      PuzzleDifficulty.hard => 8,
    };
  }

  static int gridColumnsFor(PuzzleDifficulty difficulty) {
    return switch (difficulty) {
      PuzzleDifficulty.easy => 4,
      PuzzleDifficulty.medium => 3,
      PuzzleDifficulty.hard => 4,
    };
  }

  static int oppositesPairCountFor(PuzzleDifficulty difficulty) {
    return switch (difficulty) {
      PuzzleDifficulty.easy => 4,
      PuzzleDifficulty.medium => 5,
      PuzzleDifficulty.hard => 6,
    };
  }

  static int sortItemCount(PuzzleDifficulty difficulty) {
    return switch (difficulty) {
      PuzzleDifficulty.easy => 6,
      PuzzleDifficulty.medium => 8,
      PuzzleDifficulty.hard => 10,
    };
  }

  static List<PuzzleContentItem> get contentPool {
    final items = <PuzzleContentItem>[];
    for (final item in SpellingData.byCategory('animals')) {
      items.add(
        PuzzleContentItem(
          id: item.nameKey,
          emoji: item.emoji,
          nameKey: item.nameKey,
          group: 'animals',
        ),
      );
    }
    for (final item in SpellingData.byCategory('fruits')) {
      items.add(
        PuzzleContentItem(
          id: item.nameKey,
          emoji: item.emoji,
          nameKey: item.nameKey,
          group: 'fruits',
        ),
      );
    }
    for (final item in SpellingData.byCategory('vegetables')) {
      items.add(
        PuzzleContentItem(
          id: item.nameKey,
          emoji: item.emoji,
          nameKey: item.nameKey,
          group: 'vegetables',
        ),
      );
    }
    for (final item in VehiclesData.items) {
      items.add(
        PuzzleContentItem(
          id: item.nameKey,
          emoji: item.emoji,
          nameKey: item.nameKey,
          group: 'vehicles',
        ),
      );
    }
    for (final item in EmotionsData.items) {
      items.add(
        PuzzleContentItem(
          id: item.nameKey,
          emoji: item.emoji,
          nameKey: item.nameKey,
          group: 'emotions',
        ),
      );
    }
    for (final item in ShapesColorsData.shapes) {
      items.add(
        PuzzleContentItem(
          id: item.nameKey,
          emoji: item.emoji,
          nameKey: item.nameKey,
          group: 'shapes',
        ),
      );
    }
    return items;
  }

  static List<PuzzleContentItem> byGroup(String group) {
    return contentPool.where((e) => e.group == group).toList();
  }

  /// Four choices: correct + three wrong answers from the same category.
  static List<PuzzleContentItem>? _quizOptionsSameGroup(
    PuzzleContentItem correct,
    Random rng, {
    int optionCount = 4,
  }) {
    final peers = byGroup(correct.group)
        .where((e) => e.id != correct.id)
        .toList()
      ..shuffle(rng);
    final wrongNeeded = optionCount - 1;
    if (peers.isEmpty) return null;
    final options = <PuzzleContentItem>[
      correct,
      ...peers.take(wrongNeeded),
    ]..shuffle(rng);
    return options.length >= 2 ? options : null;
  }

  static List<MemoryCardFace> memoryFaces({
    required MemoryThemeId theme,
    required PuzzleDifficulty difficulty,
    Random? random,
  }) {
    final rng = random ?? Random();
    final need = pairCountFor(difficulty);
    final pool = _facesForTheme(theme);
    final shuffled = List<MemoryCardFace>.from(pool)..shuffle(rng);
    return shuffled.take(need).toList();
  }

  static List<MemoryCardFace> _facesForTheme(MemoryThemeId theme) {
    switch (theme) {
      case MemoryThemeId.animals:
        return SpellingData.byCategory('animals')
            .map(
              (item) => MemoryCardFace(
                pairId: item.nameKey,
                emoji: item.emoji,
                labelKey: item.nameKey,
              ),
            )
            .toList();
      case MemoryThemeId.fruits:
        return SpellingData.byCategory('fruits')
            .map(
              (item) => MemoryCardFace(
                pairId: item.nameKey,
                emoji: item.emoji,
                labelKey: item.nameKey,
              ),
            )
            .toList();
      case MemoryThemeId.emotions:
        return EmotionsData.items
            .map(
              (item) => MemoryCardFace(
                pairId: item.nameKey,
                emoji: item.emoji,
                labelKey: item.nameKey,
              ),
            )
            .toList();
      case MemoryThemeId.vehicles:
        return VehiclesData.items
            .map(
              (item) => MemoryCardFace(
                pairId: item.nameKey,
                emoji: item.emoji,
                labelKey: item.nameKey,
              ),
            )
            .toList();
      case MemoryThemeId.shapes:
        return ShapesColorsData.shapes
            .map(
              (item) => MemoryCardFace(
                pairId: item.nameKey,
                emoji: item.emoji,
                labelKey: item.nameKey,
              ),
            )
            .toList();
    }
  }

  static ({
    List<OppositePair> left,
    List<OppositePair> rightShuffled,
  }) oppositesBoard({
    int pairCount = 4,
    Random? random,
  }) {
    final rng = random ?? Random();
    final pool = List<OppositePair>.from(OppositesData.pairs)..shuffle(rng);
    final left = pool.take(pairCount).toList();
    final right = List<OppositePair>.from(left)..shuffle(rng);
    return (left: left, rightShuffled: right);
  }

  static List<PictureWordRound> pictureWordRounds({
    PuzzleDifficulty difficulty = defaultDifficulty,
    Random? random,
  }) {
    final rng = random ?? Random();
    final target = quizRoundCount(difficulty);
    final pool = List<PuzzleContentItem>.from(contentPool)..shuffle(rng);
    final rounds = <PictureWordRound>[];
    for (final correct in pool) {
      if (rounds.length >= target) break;
      final options = _quizOptionsSameGroup(correct, rng);
      if (options == null) continue;
      rounds.add(PictureWordRound(correct: correct, options: options));
    }
    return rounds;
  }

  static List<ListenFindRound> listenFindRounds({
    PuzzleDifficulty difficulty = defaultDifficulty,
    Random? random,
  }) {
    final rng = random ?? Random();
    final target = quizRoundCount(difficulty);
    final pool = List<PuzzleContentItem>.from(contentPool)..shuffle(rng);
    final rounds = <ListenFindRound>[];
    for (final correct in pool) {
      if (rounds.length >= target) break;
      final options = _quizOptionsSameGroup(correct, rng);
      if (options == null) continue;
      rounds.add(ListenFindRound(correct: correct, options: options));
    }
    return rounds;
  }

  static List<OddOneOutRound> oddOneOutRounds({
    PuzzleDifficulty difficulty = defaultDifficulty,
    Random? random,
  }) {
    final rng = random ?? Random();
    final count = quizRoundCount(difficulty);
    const groups = [
      'animals',
      'fruits',
      'vegetables',
      'vehicles',
      'emotions',
      'shapes',
    ];
    final rounds = <OddOneOutRound>[];

    var guard = 0;
    while (rounds.length < count && guard < count * 8) {
      guard++;
      final majority = groups[rng.nextInt(groups.length)];
      var oddGroup = groups[rng.nextInt(groups.length)];
      while (oddGroup == majority) {
        oddGroup = groups[rng.nextInt(groups.length)];
      }
      final majorityPool = List<PuzzleContentItem>.from(byGroup(majority))
        ..shuffle(rng);
      final oddPool = List<PuzzleContentItem>.from(byGroup(oddGroup))
        ..shuffle(rng);
      if (majorityPool.length < 3 || oddPool.isEmpty) continue;

      final options = <PuzzleContentItem>[
        ...majorityPool.take(3),
        oddPool.first,
      ]..shuffle(rng);
      final oddIndex = options.indexWhere((e) => e.group == oddGroup);
      if (oddIndex < 0) continue;
      rounds.add(OddOneOutRound(options: options, oddIndex: oddIndex));
    }
    return rounds;
  }

  static List<PuzzleContentItem> sortItemsFor({
    required SortModeInfo mode,
    PuzzleDifficulty difficulty = defaultDifficulty,
    Random? random,
  }) {
    final rng = random ?? Random();
    final need = sortItemCount(difficulty);
    final left = List<PuzzleContentItem>.from(byGroup(mode.leftGroup))
      ..shuffle(rng);
    final right = List<PuzzleContentItem>.from(byGroup(mode.rightGroup))
      ..shuffle(rng);
    final half = (need / 2).ceil();
    final items = <PuzzleContentItem>[
      ...left.take(half),
      ...right.take(need - half),
    ]..shuffle(rng);
    return items.take(need).toList();
  }
}
