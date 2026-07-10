import 'dart:math';

import '../utils/math_logic_digits.dart';
import 'alphabet_data.dart';
import 'everyday_words_data.dart';
import 'native_script_data.dart';

enum MathCategoryId {
  counting,
  addition,
  subtraction,
  patterns,
  compare,
  logic,
}

enum MathActivityId {
  countObjects,
  countAndTap,
  missingCount,
  forwardCount,
  backwardCount,
  pictureAddition,
  fillAddition,
  pictureSubtraction,
  fillSubtraction,
  colorPattern,
  shapePattern,
  fruitPattern,
  compareGroups,
  biggerNumber,
  smallerNumber,
  oddOneOut,
  middleNumber,
  doubleIt,
  arrangeAlphabet,
  arrangeKakko,
  arrangeDays,
  arrangeMonths,
}

class MathCategoryInfo {
  final MathCategoryId id;
  final String emoji;
  final String titleKey;
  final String subtitleKey;
  final List<MathActivityId> activities;

  const MathCategoryInfo({
    required this.id,
    required this.emoji,
    required this.titleKey,
    required this.subtitleKey,
    required this.activities,
  });
}

class MathActivityInfo {
  final MathActivityId id;
  final String emoji;
  final String titleKey;

  const MathActivityInfo({
    required this.id,
    required this.emoji,
    required this.titleKey,
  });
}

class PickAnswerRound {
  final String instructionKey;
  final Map<String, String>? instructionArgs;
  final String? emoji;
  final int? emojiCount;
  final List<String>? rowItems;
  final List<String>? textParts;
  final int? blankIndex;
  final List<String> optionLabels;
  final int correctIndex;

  const PickAnswerRound({
    required this.instructionKey,
    this.instructionArgs,
    this.emoji,
    this.emojiCount,
    this.rowItems,
    this.textParts,
    this.blankIndex,
    required this.optionLabels,
    required this.correctIndex,
  });
}

class TwoGroupRound {
  final String emoji;
  final int leftCount;
  final int rightCount;
  final String instructionKey;

  const TwoGroupRound({
    required this.emoji,
    required this.leftCount,
    required this.rightCount,
    required this.instructionKey,
  });

  bool get leftHasMore => leftCount > rightCount;
}

class PictureMathRound {
  final String emoji;
  final int groupA;
  final int groupB;
  final bool isAddition;
  final int correctAnswer;
  final List<int> options;
  final String instructionKey;

  const PictureMathRound({
    required this.emoji,
    required this.groupA,
    required this.groupB,
    required this.isAddition,
    required this.correctAnswer,
    required this.options,
    required this.instructionKey,
  });
}

class PatternRound {
  final List<String> shown;
  final String correct;
  final List<String> options;
  final String instructionKey;

  const PatternRound({
    required this.shown,
    required this.correct,
    required this.options,
    required this.instructionKey,
  });
}

class OddOneOutRound {
  final List<String> items;
  final int oddIndex;
  final String instructionKey;

  const OddOneOutRound({
    required this.items,
    required this.oddIndex,
    required this.instructionKey,
  });
}

class CountTapRound {
  final String emoji;
  final int count;

  const CountTapRound({required this.emoji, required this.count});
}

enum MathRoundKind {
  pickAnswer,
  countTap,
  twoGroup,
  pictureMath,
  pattern,
  oddOneOut,
}

class MathActivityRound {
  final MathRoundKind kind;
  final PickAnswerRound? pickAnswer;
  final CountTapRound? countTap;
  final TwoGroupRound? twoGroup;
  final PictureMathRound? pictureMath;
  final PatternRound? pattern;
  final OddOneOutRound? oddOneOut;

  const MathActivityRound.pick(PickAnswerRound round)
      : kind = MathRoundKind.pickAnswer,
        pickAnswer = round,
        countTap = null,
        twoGroup = null,
        pictureMath = null,
        pattern = null,
        oddOneOut = null;

  const MathActivityRound.countTap(CountTapRound round)
      : kind = MathRoundKind.countTap,
        pickAnswer = null,
        countTap = round,
        twoGroup = null,
        pictureMath = null,
        pattern = null,
        oddOneOut = null;

  const MathActivityRound.twoGroup(TwoGroupRound round)
      : kind = MathRoundKind.twoGroup,
        pickAnswer = null,
        countTap = null,
        twoGroup = round,
        pictureMath = null,
        pattern = null,
        oddOneOut = null;

  const MathActivityRound.pictureMath(PictureMathRound round)
      : kind = MathRoundKind.pictureMath,
        pickAnswer = null,
        countTap = null,
        twoGroup = null,
        pictureMath = round,
        pattern = null,
        oddOneOut = null;

  const MathActivityRound.pattern(PatternRound round)
      : kind = MathRoundKind.pattern,
        pickAnswer = null,
        countTap = null,
        twoGroup = null,
        pictureMath = null,
        pattern = round,
        oddOneOut = null;

  const MathActivityRound.oddOneOut(OddOneOutRound round)
      : kind = MathRoundKind.oddOneOut,
        pickAnswer = null,
        countTap = null,
        twoGroup = null,
        pictureMath = null,
        pattern = null,
        oddOneOut = round;
}

class MathLogicData {
  MathLogicData._();

  static const Map<MathActivityId, int> _questionsPerActivity = {
    MathActivityId.countObjects: 20,
    MathActivityId.countAndTap: 18,
    MathActivityId.missingCount: 18,
    MathActivityId.forwardCount: 18,
    MathActivityId.backwardCount: 18,
    MathActivityId.pictureAddition: 20,
    MathActivityId.fillAddition: 20,
    MathActivityId.pictureSubtraction: 18,
    MathActivityId.fillSubtraction: 18,
    MathActivityId.colorPattern: 18,
    MathActivityId.shapePattern: 18,
    MathActivityId.fruitPattern: 18,
    MathActivityId.compareGroups: 20,
    MathActivityId.biggerNumber: 18,
    MathActivityId.smallerNumber: 18,
    MathActivityId.oddOneOut: 12,
    MathActivityId.middleNumber: 15,
    MathActivityId.doubleIt: 15,
    MathActivityId.arrangeAlphabet: 15,
    MathActivityId.arrangeKakko: 15,
    MathActivityId.arrangeDays: 15,
    MathActivityId.arrangeMonths: 15,
  };

  static int questionCountFor(MathActivityId activityId) =>
      _questionsPerActivity[activityId] ?? 15;

  static final Map<MathActivityId, List<MathActivityRound>> _sessionCache = {};
  static final Map<String, List<MathActivityRound>> _localeSessionCache = {};

  static bool _isLocaleDependent(MathActivityId activityId) {
    return activityId == MathActivityId.arrangeKakko ||
        activityId == MathActivityId.arrangeMonths;
  }

  static const _fruits = ['🍎', '🍌', '🍊', '🍇', '🍓'];
  static const _animals = ['🐶', '🐱', '🐰', '🐻', '🦊'];
  static const _birds = ['🐦', '🐤', '🦜', '🦆', '🐧'];
  static const _stars = ['⭐', '🌟', '✨'];
  static const _balloons = ['🎈', '🎈', '🎈'];
  static const _shapes = ['🔺', '⬛', '⚪', '💎'];
  static const _colorPattern = ['🔴', '🔵', '🟢', '🟡'];
  static const _fruitPattern = ['🍎', '🍌', '🍊', '🍇'];
  static const _shapePattern = ['⭐', '❤️', '🔺', '⬛'];

  static const _oddSets = [
    (items: ['🍎', '🍎', '🍎', '🚗'], odd: 3),
    (items: ['🐶', '🐶', '🐱', '🐶'], odd: 2),
    (items: ['⭐', '⭐', '🌙', '⭐'], odd: 2),
    (items: ['🔴', '🔴', '🔵', '🔴'], odd: 2),
    (items: ['🐟', '🐟', '🐟', '🐶'], odd: 3),
    (items: ['🍌', '🍌', '🍌', '🍎'], odd: 3),
    (items: ['🌸', '🌸', '🌸', '🌳'], odd: 3),
    (items: ['🐦', '🐦', '🐦', '🐱'], odd: 3),
    (items: ['🟡', '🟡', '🟢', '🟡'], odd: 2),
    (items: ['⚽', '⚽', '🏀', '⚽'], odd: 2),
    (items: ['🍊', '🍊', '🍇', '🍊'], odd: 2),
    (items: ['🐰', '🐰', '🐻', '🐰'], odd: 2),
  ];

  static const List<MathCategoryInfo> categories = [
    MathCategoryInfo(
      id: MathCategoryId.counting,
      emoji: '🔢',
      titleKey: 'mathLogic.categories.counting.title',
      subtitleKey: 'mathLogic.categories.counting.subtitle',
      activities: [
        MathActivityId.countObjects,
        MathActivityId.countAndTap,
        MathActivityId.missingCount,
        MathActivityId.forwardCount,
        MathActivityId.backwardCount,
      ],
    ),
    MathCategoryInfo(
      id: MathCategoryId.addition,
      emoji: '➕',
      titleKey: 'mathLogic.categories.addition.title',
      subtitleKey: 'mathLogic.categories.addition.subtitle',
      activities: [
        MathActivityId.pictureAddition,
        MathActivityId.fillAddition,
      ],
    ),
    MathCategoryInfo(
      id: MathCategoryId.subtraction,
      emoji: '➖',
      titleKey: 'mathLogic.categories.subtraction.title',
      subtitleKey: 'mathLogic.categories.subtraction.subtitle',
      activities: [
        MathActivityId.pictureSubtraction,
        MathActivityId.fillSubtraction,
      ],
    ),
    MathCategoryInfo(
      id: MathCategoryId.patterns,
      emoji: '🎨',
      titleKey: 'mathLogic.categories.patterns.title',
      subtitleKey: 'mathLogic.categories.patterns.subtitle',
      activities: [
        MathActivityId.colorPattern,
        MathActivityId.shapePattern,
        MathActivityId.fruitPattern,
      ],
    ),
    MathCategoryInfo(
      id: MathCategoryId.compare,
      emoji: '⚖️',
      titleKey: 'mathLogic.categories.compare.title',
      subtitleKey: 'mathLogic.categories.compare.subtitle',
      activities: [
        MathActivityId.compareGroups,
        MathActivityId.biggerNumber,
        MathActivityId.smallerNumber,
      ],
    ),
    MathCategoryInfo(
      id: MathCategoryId.logic,
      emoji: '🧠',
      titleKey: 'mathLogic.categories.logic.title',
      subtitleKey: 'mathLogic.categories.logic.subtitle',
      activities: [
        MathActivityId.oddOneOut,
        MathActivityId.middleNumber,
        MathActivityId.doubleIt,
        MathActivityId.arrangeAlphabet,
        MathActivityId.arrangeKakko,
        MathActivityId.arrangeDays,
        MathActivityId.arrangeMonths,
      ],
    ),
  ];

  static MathCategoryInfo category(MathCategoryId id) =>
      categories.firstWhere((c) => c.id == id);

  static MathActivityInfo activityInfo(MathActivityId id) {
    const map = {
      MathActivityId.countObjects: MathActivityInfo(
        id: MathActivityId.countObjects,
        emoji: '🍎',
        titleKey: 'mathLogic.activities.countObjects.title',
      ),
      MathActivityId.countAndTap: MathActivityInfo(
        id: MathActivityId.countAndTap,
        emoji: '👆',
        titleKey: 'mathLogic.activities.countAndTap.title',
      ),
      MathActivityId.missingCount: MathActivityInfo(
        id: MathActivityId.missingCount,
        emoji: '❓',
        titleKey: 'mathLogic.activities.missingCount.title',
      ),
      MathActivityId.forwardCount: MathActivityInfo(
        id: MathActivityId.forwardCount,
        emoji: '➡️',
        titleKey: 'mathLogic.activities.forwardCount.title',
      ),
      MathActivityId.backwardCount: MathActivityInfo(
        id: MathActivityId.backwardCount,
        emoji: '⬅️',
        titleKey: 'mathLogic.activities.backwardCount.title',
      ),
      MathActivityId.pictureAddition: MathActivityInfo(
        id: MathActivityId.pictureAddition,
        emoji: '🍎',
        titleKey: 'mathLogic.activities.pictureAddition.title',
      ),
      MathActivityId.fillAddition: MathActivityInfo(
        id: MathActivityId.fillAddition,
        emoji: '➕',
        titleKey: 'mathLogic.activities.fillAddition.title',
      ),
      MathActivityId.pictureSubtraction: MathActivityInfo(
        id: MathActivityId.pictureSubtraction,
        emoji: '🎈',
        titleKey: 'mathLogic.activities.pictureSubtraction.title',
      ),
      MathActivityId.fillSubtraction: MathActivityInfo(
        id: MathActivityId.fillSubtraction,
        emoji: '➖',
        titleKey: 'mathLogic.activities.fillSubtraction.title',
      ),
      MathActivityId.colorPattern: MathActivityInfo(
        id: MathActivityId.colorPattern,
        emoji: '🔴',
        titleKey: 'mathLogic.activities.colorPattern.title',
      ),
      MathActivityId.shapePattern: MathActivityInfo(
        id: MathActivityId.shapePattern,
        emoji: '⭐',
        titleKey: 'mathLogic.activities.shapePattern.title',
      ),
      MathActivityId.fruitPattern: MathActivityInfo(
        id: MathActivityId.fruitPattern,
        emoji: '🍎',
        titleKey: 'mathLogic.activities.fruitPattern.title',
      ),
      MathActivityId.compareGroups: MathActivityInfo(
        id: MathActivityId.compareGroups,
        emoji: '⚖️',
        titleKey: 'mathLogic.activities.compareGroups.title',
      ),
      MathActivityId.biggerNumber: MathActivityInfo(
        id: MathActivityId.biggerNumber,
        emoji: '🔼',
        titleKey: 'mathLogic.activities.biggerNumber.title',
      ),
      MathActivityId.smallerNumber: MathActivityInfo(
        id: MathActivityId.smallerNumber,
        emoji: '🔽',
        titleKey: 'mathLogic.activities.smallerNumber.title',
      ),
      MathActivityId.oddOneOut: MathActivityInfo(
        id: MathActivityId.oddOneOut,
        emoji: '🔍',
        titleKey: 'mathLogic.activities.oddOneOut.title',
      ),
      MathActivityId.middleNumber: MathActivityInfo(
        id: MathActivityId.middleNumber,
        emoji: '🎯',
        titleKey: 'mathLogic.activities.middleNumber.title',
      ),
      MathActivityId.doubleIt: MathActivityInfo(
        id: MathActivityId.doubleIt,
        emoji: '✖️',
        titleKey: 'mathLogic.activities.doubleIt.title',
      ),
      MathActivityId.arrangeAlphabet: MathActivityInfo(
        id: MathActivityId.arrangeAlphabet,
        emoji: '🔤',
        titleKey: 'mathLogic.activities.arrangeAlphabet.title',
      ),
      MathActivityId.arrangeKakko: MathActivityInfo(
        id: MathActivityId.arrangeKakko,
        emoji: 'ક',
        titleKey: 'mathLogic.activities.arrangeKakko.title',
      ),
      MathActivityId.arrangeDays: MathActivityInfo(
        id: MathActivityId.arrangeDays,
        emoji: '📅',
        titleKey: 'mathLogic.activities.arrangeDays.title',
      ),
      MathActivityId.arrangeMonths: MathActivityInfo(
        id: MathActivityId.arrangeMonths,
        emoji: '🗓️',
        titleKey: 'mathLogic.activities.arrangeMonths.title',
      ),
    };
    return map[id]!;
  }

  static List<MathActivityRound> sessionFor(
    MathActivityId activityId, {
    String languageCode = 'en',
  }) {
    if (_isLocaleDependent(activityId)) {
      final cacheKey = '${activityId.name}_$languageCode';
      return _localeSessionCache.putIfAbsent(
        cacheKey,
        () => _buildSession(activityId, languageCode),
      );
    }
    return _sessionCache.putIfAbsent(
      activityId,
      () => _buildSession(activityId, languageCode),
    );
  }

  static List<MathActivityRound> _buildSession(
    MathActivityId activityId,
    String languageCode,
  ) {
    final seed = activityId.index * 10007 +
        activityId.name.hashCode +
        languageCode.hashCode;
    final random = Random(seed);
    final total = questionCountFor(activityId);
    switch (activityId) {
      case MathActivityId.forwardCount:
        return _buildForwardCountSession(random, total);
      case MathActivityId.backwardCount:
        return _buildBackwardCountSession(random, total);
      case MathActivityId.fillAddition:
        return _buildFillAdditionSession(random, total);
      case MathActivityId.fillSubtraction:
        return _buildFillSubtractionSession(random, total);
      case MathActivityId.biggerNumber:
        return _buildBiggerNumberSession(random, total);
      case MathActivityId.smallerNumber:
        return _buildSmallerNumberSession(random, total);
      case MathActivityId.middleNumber:
        return _buildMiddleNumberSession(random, total);
      case MathActivityId.doubleIt:
        return _buildDoubleItSession(random, total);
      case MathActivityId.arrangeKakko:
        return _buildArrangeKakkoSession(languageCode, total);
      default:
        return List.generate(
          total,
          (i) => _generateRound(
            activityId,
            random,
            languageCode: languageCode,
            roundIndex: i,
            totalRounds: total,
          ),
        );
    }
  }

  static MathActivityRound _generateRound(
    MathActivityId id,
    Random random, {
    String languageCode = 'en',
    int roundIndex = 0,
    int totalRounds = 15,
  }) {
    switch (id) {
      case MathActivityId.countObjects:
        return MathActivityRound.pick(randomCountObjects(random));
      case MathActivityId.countAndTap:
        return MathActivityRound.countTap(randomCountTap(random));
      case MathActivityId.missingCount:
        return MathActivityRound.pick(
          randomMissingCount(
            random,
            roundIndex: roundIndex,
            totalRounds: totalRounds,
          ),
        );
      case MathActivityId.forwardCount:
        return MathActivityRound.pick(
          randomForwardCount(
            random,
            roundIndex: roundIndex,
            totalRounds: totalRounds,
          ),
        );
      case MathActivityId.backwardCount:
        return MathActivityRound.pick(
          randomBackwardCount(
            random,
            roundIndex: roundIndex,
            totalRounds: totalRounds,
          ),
        );
      case MathActivityId.pictureAddition:
        return MathActivityRound.pictureMath(randomPictureAddition(random));
      case MathActivityId.fillAddition:
        return MathActivityRound.pick(
          randomFillAddition(
            random,
            roundIndex: roundIndex,
            totalRounds: totalRounds,
          ),
        );
      case MathActivityId.pictureSubtraction:
        return MathActivityRound.pictureMath(randomPictureSubtraction(random));
      case MathActivityId.fillSubtraction:
        return MathActivityRound.pick(
          randomFillSubtraction(
            random,
            roundIndex: roundIndex,
            totalRounds: totalRounds,
          ),
        );
      case MathActivityId.colorPattern:
        return MathActivityRound.pattern(randomColorPattern(random));
      case MathActivityId.shapePattern:
        return MathActivityRound.pattern(randomShapePattern(random));
      case MathActivityId.fruitPattern:
        return MathActivityRound.pattern(randomFruitPattern(random));
      case MathActivityId.compareGroups:
        return MathActivityRound.twoGroup(randomCompareGroups(random));
      case MathActivityId.biggerNumber:
        return MathActivityRound.pick(
          randomBiggerNumber(
            random,
            roundIndex: roundIndex,
            totalRounds: totalRounds,
          ),
        );
      case MathActivityId.smallerNumber:
        return MathActivityRound.pick(
          randomSmallerNumber(
            random,
            roundIndex: roundIndex,
            totalRounds: totalRounds,
          ),
        );
      case MathActivityId.oddOneOut:
        return MathActivityRound.oddOneOut(randomOddOneOut(random));
      case MathActivityId.middleNumber:
        return MathActivityRound.pick(randomMiddleNumber(random));
      case MathActivityId.doubleIt:
        return MathActivityRound.pick(
          randomDoubleIt(
            random,
            roundIndex: roundIndex,
            totalRounds: totalRounds,
          ),
        );
      case MathActivityId.arrangeAlphabet:
        return MathActivityRound.pick(
          randomArrangeAlphabet(
            random,
            roundIndex: roundIndex,
            totalRounds: totalRounds,
          ),
        );
      case MathActivityId.arrangeKakko:
        throw StateError('arrangeKakko is built via _buildArrangeKakkoSession');
      case MathActivityId.arrangeDays:
        return MathActivityRound.pick(
          randomArrangeDays(
            random,
            roundIndex: roundIndex,
            totalRounds: totalRounds,
          ),
        );
      case MathActivityId.arrangeMonths:
        return MathActivityRound.pick(
          randomArrangeMonths(
            random,
            languageCode: languageCode,
            roundIndex: roundIndex,
            totalRounds: totalRounds,
          ),
        );
    }
  }

  static List<int> _pickOptions(Random random, int correct, int min, int max) {
    final options = <int>{correct};
    while (options.length < 3) {
      final n = min + random.nextInt(max - min + 1);
      if (n != correct) options.add(n);
    }
    final list = options.toList()..shuffle(random);
    return list;
  }

  static int _indexOf(List<int> options, int correct) =>
      options.indexOf(correct);

  static List<String> _intLabels(List<int> nums) =>
      nums.map((n) => '$n').toList();

  static PickAnswerRound randomCountObjects(Random random) {
    final pools = [_fruits, _animals, _birds, _stars, _balloons, _shapes];
    final pool = pools[random.nextInt(pools.length)];
    final emoji = pool[random.nextInt(pool.length)];
    final count = 2 + random.nextInt(7);
    final options = _pickOptions(random, count, 1, 10);
    return PickAnswerRound(
      instructionKey: 'mathLogic.activities.countObjects.instruction',
      emoji: emoji,
      emojiCount: count,
      optionLabels: _intLabels(options),
      correctIndex: _indexOf(options, count),
    );
  }

  static CountTapRound randomCountTap(Random random) {
    final emoji = _fruits[random.nextInt(_fruits.length)];
    return CountTapRound(emoji: emoji, count: 3 + random.nextInt(5));
  }

  static int _progressiveMax(int roundIndex, int totalRounds) {
    if (roundIndex < 4) return 10;
    final remaining = (totalRounds - 4).clamp(1, totalRounds);
    final step = roundIndex - 3;
    return (10 + ((100 - 10) * step / remaining)).round().clamp(10, 100);
  }

  static PickAnswerRound randomMissingCount(
    Random random, {
    int roundIndex = 0,
    int totalRounds = 18,
  }) {
    final maxNum = _progressiveMax(roundIndex, totalRounds);
    final seqLen = 4 + random.nextInt(2);
    final missingPos = 1 + random.nextInt(seqLen - 2);

    final minMissing = (1 + missingPos).clamp(2, maxNum);
    final maxMissing =
        (maxNum).clamp(minMissing, 100 - (seqLen - 1 - missingPos));

    final missing = minMissing == maxMissing
        ? minMissing
        : minMissing + random.nextInt(maxMissing - minMissing + 1);
    final start = missing - missingPos;
    final end = start + seqLen - 1;

    final parts = <String>[];
    for (var n = start; n <= end; n++) {
      parts.add(n == missing ? '__' : '$n');
    }

    final spread = (maxNum / 8).round().clamp(2, 8);
    final optMin = (missing - spread).clamp(1, 100);
    final optMax = (missing + spread).clamp(1, 100);
    final options = _pickOptions(random, missing, optMin, optMax);

    return PickAnswerRound(
      instructionKey: 'mathLogic.activities.missingCount.instruction',
      textParts: parts,
      blankIndex: missing - start,
      optionLabels: _intLabels(options),
      correctIndex: _indexOf(options, missing),
    );
  }

  static List<MathActivityRound> _buildForwardCountSession(
    Random random,
    int total,
  ) {
    final used = <int>{};
    return List.generate(total, (i) {
      final maxNum = _progressiveMax(i, total);
      final maxN = (maxNum - 1).clamp(1, 99);
      final available = <int>[
        for (var v = 1; v <= maxN; v++)
          if (!used.contains(v)) v,
      ];
      final n = available[random.nextInt(available.length)];
      used.add(n);
      return MathActivityRound.pick(_forwardCountForN(random, n, maxNum));
    });
  }

  static List<MathActivityRound> _buildBackwardCountSession(
    Random random,
    int total,
  ) {
    final used = <int>{};
    return List.generate(total, (i) {
      final maxNum = _progressiveMax(i, total);
      final maxN = maxNum.clamp(2, 100);
      final available = <int>[
        for (var v = 2; v <= maxN; v++)
          if (!used.contains(v)) v,
      ];
      final n = available[random.nextInt(available.length)];
      used.add(n);
      return MathActivityRound.pick(_backwardCountForN(random, n, maxNum));
    });
  }

  static PickAnswerRound _forwardCountForN(Random random, int n, int maxNum) {
    final answer = n + 1;
    final spread = (maxNum / 8).round().clamp(2, 8);
    final optMin = (answer - spread).clamp(1, 100);
    final optMax = (answer + spread).clamp(1, 100);
    final options = _pickOptions(random, answer, optMin, optMax);
    return PickAnswerRound(
      instructionKey: 'mathLogic.activities.forwardCount.instruction',
      instructionArgs: {'number': '$n'},
      optionLabels: _intLabels(options),
      correctIndex: _indexOf(options, answer),
    );
  }

  static PickAnswerRound _backwardCountForN(Random random, int n, int maxNum) {
    final answer = n - 1;
    final spread = (maxNum / 8).round().clamp(2, 8);
    final optMin = (answer - spread).clamp(1, 100);
    final optMax = (answer + spread).clamp(1, 100);
    final options = _pickOptions(random, answer, optMin, optMax);
    return PickAnswerRound(
      instructionKey: 'mathLogic.activities.backwardCount.instruction',
      instructionArgs: {'number': '$n'},
      optionLabels: _intLabels(options),
      correctIndex: _indexOf(options, answer),
    );
  }

  static PickAnswerRound randomForwardCount(
    Random random, {
    int roundIndex = 0,
    int totalRounds = 18,
  }) {
    final maxNum = _progressiveMax(roundIndex, totalRounds);
    final maxN = (maxNum - 1).clamp(1, 99);
    final n = 1 + random.nextInt(maxN);
    return _forwardCountForN(random, n, maxNum);
  }

  static PickAnswerRound randomBackwardCount(
    Random random, {
    int roundIndex = 0,
    int totalRounds = 18,
  }) {
    final maxNum = _progressiveMax(roundIndex, totalRounds);
    final maxN = maxNum.clamp(2, 100);
    final n = 2 + random.nextInt(maxN - 1);
    return _backwardCountForN(random, n, maxNum);
  }

  static int _progressiveOperandMax(int roundIndex, int totalRounds) {
    if (roundIndex < 4) return 9;
    final remaining = (totalRounds - 4).clamp(1, totalRounds);
    final step = roundIndex - 3;
    return (10 + ((20 - 10) * step / remaining)).round().clamp(10, 20);
  }

  static ({int a, int b}) _additionOperands(
    Random random,
    int roundIndex,
    int totalRounds,
  ) {
    final maxOp = _progressiveOperandMax(roundIndex, totalRounds);
    const maxSum = 40;
    final minSum = roundIndex < 4 ? 2 : (roundIndex < totalRounds ~/ 2 ? 6 : 10);

    for (var attempt = 0; attempt < 60; attempt++) {
      final a = 1 + random.nextInt(maxOp);
      final maxB = min(maxOp, maxSum - a);
      if (maxB < 1) continue;
      final minB = (minSum - a).clamp(1, maxB);
      if (minB > maxB) continue;
      final b = minB + random.nextInt(maxB - minB + 1);
      final sum = a + b;
      if (sum >= minSum && sum <= maxSum) {
        return (a: a, b: b);
      }
    }
    return (a: 12, b: 8);
  }

  static ({int a, int b}) _subtractionOperands(
    Random random,
    int roundIndex,
    int totalRounds,
  ) {
    final maxOp = _progressiveOperandMax(roundIndex, totalRounds);
    const maxAnswer = 40;
    final minAnswer = roundIndex < 4 ? 1 : (roundIndex < totalRounds ~/ 2 ? 3 : 5);
    final maxA = min(35, maxOp + 10);

    for (var attempt = 0; attempt < 60; attempt++) {
      final aMin = roundIndex < 4 ? 3 : 6;
      if (aMin > maxA) break;
      final a = aMin + random.nextInt(maxA - aMin + 1);
      final maxB = a - minAnswer;
      if (maxB < 1) continue;
      final b = 1 + random.nextInt(min(maxB, maxOp));
      final answer = a - b;
      if (answer >= minAnswer && answer <= maxAnswer) {
        return (a: a, b: b);
      }
    }
    return (a: 18, b: 5);
  }

  static List<MathActivityRound> _buildFillAdditionSession(
    Random random,
    int total,
  ) {
    final used = <String>{};
    return List.generate(total, (i) {
      var pair = _additionOperands(random, i, total);
      var attempts = 0;
      while (used.contains('${pair.a}_${pair.b}') && attempts < 80) {
        pair = _additionOperands(random, i, total);
        attempts++;
      }
      used.add('${pair.a}_${pair.b}');
      return MathActivityRound.pick(
        _fillAdditionFor(random, pair.a, pair.b),
      );
    });
  }

  static List<MathActivityRound> _buildFillSubtractionSession(
    Random random,
    int total,
  ) {
    final used = <String>{};
    return List.generate(total, (i) {
      var pair = _subtractionOperands(random, i, total);
      var attempts = 0;
      while (used.contains('${pair.a}_${pair.b}') && attempts < 80) {
        pair = _subtractionOperands(random, i, total);
        attempts++;
      }
      used.add('${pair.a}_${pair.b}');
      return MathActivityRound.pick(
        _fillSubtractionFor(random, pair.a, pair.b),
      );
    });
  }

  static PickAnswerRound _fillAdditionFor(Random random, int a, int b) {
    final sum = a + b;
    final spread = (sum / 5).round().clamp(2, 6);
    final optMin = (sum - spread).clamp(2, 40);
    final optMax = (sum + spread).clamp(2, 40);
    final options = _pickOptions(random, sum, optMin, optMax);
    return PickAnswerRound(
      instructionKey: 'mathLogic.activities.fillAddition.instruction',
      instructionArgs: {'a': '$a', 'b': '$b'},
      optionLabels: _intLabels(options),
      correctIndex: _indexOf(options, sum),
    );
  }

  static PickAnswerRound _fillSubtractionFor(Random random, int a, int b) {
    final answer = a - b;
    final spread = (answer / 5).round().clamp(2, 6);
    final optMin = (answer - spread).clamp(0, 40);
    final optMax = (answer + spread).clamp(0, 40);
    final options = _pickOptions(random, answer, optMin, optMax);
    return PickAnswerRound(
      instructionKey: 'mathLogic.activities.fillSubtraction.instruction',
      instructionArgs: {'a': '$a', 'b': '$b'},
      optionLabels: _intLabels(options),
      correctIndex: _indexOf(options, answer),
    );
  }

  static PictureMathRound randomPictureAddition(Random random) {
    final emoji = _fruits[random.nextInt(_fruits.length)];
    final a = 1 + random.nextInt(4);
    final b = 1 + random.nextInt(4);
    final sum = a + b;
    final options = _pickOptions(random, sum, 1, 10);
    return PictureMathRound(
      emoji: emoji,
      groupA: a,
      groupB: b,
      isAddition: true,
      correctAnswer: sum,
      options: options,
      instructionKey: 'mathLogic.activities.pictureAddition.instruction',
    );
  }

  static PickAnswerRound randomFillAddition(
    Random random, {
    int roundIndex = 0,
    int totalRounds = 20,
  }) {
    final pair = _additionOperands(random, roundIndex, totalRounds);
    return _fillAdditionFor(random, pair.a, pair.b);
  }

  static PictureMathRound randomPictureSubtraction(Random random) {
    final emoji = _balloons[0];
    final total = 3 + random.nextInt(5);
    final remove = 1 + random.nextInt(total - 1);
    final answer = total - remove;
    final options = _pickOptions(random, answer, 0, 10);
    return PictureMathRound(
      emoji: emoji,
      groupA: total,
      groupB: remove,
      isAddition: false,
      correctAnswer: answer,
      options: options,
      instructionKey: 'mathLogic.activities.pictureSubtraction.instruction',
    );
  }

  static PickAnswerRound randomFillSubtraction(
    Random random, {
    int roundIndex = 0,
    int totalRounds = 18,
  }) {
    final pair = _subtractionOperands(random, roundIndex, totalRounds);
    return _fillSubtractionFor(random, pair.a, pair.b);
  }

  static PatternRound randomColorPattern(Random random) => randomPattern(
        random,
        _colorPattern,
        'mathLogic.activities.colorPattern.instruction',
      );

  static PatternRound randomShapePattern(Random random) => randomPattern(
        random,
        _shapePattern,
        'mathLogic.activities.shapePattern.instruction',
      );

  static PatternRound randomFruitPattern(Random random) => randomPattern(
        random,
        _fruitPattern,
        'mathLogic.activities.fruitPattern.instruction',
      );

  static PatternRound randomPattern(Random random, List<String> pool, String key) {
    final a = pool[random.nextInt(pool.length)];
    var b = pool[random.nextInt(pool.length)];
    while (b == a) {
      b = pool[random.nextInt(pool.length)];
    }
    final shown = <String>[a, b, a, b];
    final correct = a;
    final wrong = pool.where((s) => s != correct).toList()..shuffle(random);
    final options = [correct, wrong[0], wrong[1]]..shuffle(random);
    return PatternRound(
      shown: shown,
      correct: correct,
      options: options,
      instructionKey: key,
    );
  }

  static TwoGroupRound randomCompareGroups(Random random) {
    final emoji = _fruits[random.nextInt(_fruits.length)];
    var left = 1 + random.nextInt(6);
    var right = 1 + random.nextInt(6);
    while (left == right) {
      right = 1 + random.nextInt(6);
    }
    return TwoGroupRound(
      emoji: emoji,
      leftCount: left,
      rightCount: right,
      instructionKey: 'mathLogic.activities.compareGroups.instruction',
    );
  }

  static ({int a, int b}) _comparePair(
    Random random,
    int roundIndex,
    int totalRounds,
  ) {
    final maxNum = _progressiveMax(roundIndex, totalRounds);
    var a = 1 + random.nextInt(maxNum);
    var b = 1 + random.nextInt(maxNum);
    while (a == b) {
      b = 1 + random.nextInt(maxNum);
    }
    return (a: a, b: b);
  }

  static List<int> _compareNumberOptions(
    Random random,
    int correct,
    int other,
  ) {
    final options = <int>{correct, other};
    while (options.length < 3) {
      final spread = 12;
      final n = (correct + random.nextInt(spread * 2 + 1) - spread).clamp(1, 100);
      if (n != correct && n != other) options.add(n);
    }
    return options.toList()..shuffle(random);
  }

  static List<MathActivityRound> _buildBiggerNumberSession(
    Random random,
    int total,
  ) {
    final used = <String>{};
    return List.generate(total, (i) {
      var pair = _comparePair(random, i, total);
      var attempts = 0;
      while (used.contains('${pair.a}_${pair.b}') && attempts < 80) {
        pair = _comparePair(random, i, total);
        attempts++;
      }
      used.add('${pair.a}_${pair.b}');
      return MathActivityRound.pick(
        _biggerNumberFor(random, pair.a, pair.b),
      );
    });
  }

  static List<MathActivityRound> _buildSmallerNumberSession(
    Random random,
    int total,
  ) {
    final used = <String>{};
    return List.generate(total, (i) {
      var pair = _comparePair(random, i, total);
      var attempts = 0;
      while (used.contains('${pair.a}_${pair.b}') && attempts < 80) {
        pair = _comparePair(random, i, total);
        attempts++;
      }
      used.add('${pair.a}_${pair.b}');
      return MathActivityRound.pick(
        _smallerNumberFor(random, pair.a, pair.b),
      );
    });
  }

  static PickAnswerRound _biggerNumberFor(Random random, int a, int b) {
    final bigger = a > b ? a : b;
    final other = a > b ? b : a;
    final options = _compareNumberOptions(random, bigger, other);
    return PickAnswerRound(
      instructionKey: 'mathLogic.activities.biggerNumber.instruction',
      instructionArgs: {'left': '$a', 'right': '$b'},
      optionLabels: _intLabels(options),
      correctIndex: _indexOf(options, bigger),
    );
  }

  static PickAnswerRound _smallerNumberFor(Random random, int a, int b) {
    final smaller = a < b ? a : b;
    final other = a < b ? b : a;
    final options = _compareNumberOptions(random, smaller, other);
    return PickAnswerRound(
      instructionKey: 'mathLogic.activities.smallerNumber.instruction',
      instructionArgs: {'left': '$a', 'right': '$b'},
      optionLabels: _intLabels(options),
      correctIndex: _indexOf(options, smaller),
    );
  }

  static PickAnswerRound randomBiggerNumber(
    Random random, {
    int roundIndex = 0,
    int totalRounds = 18,
  }) {
    final pair = _comparePair(random, roundIndex, totalRounds);
    return _biggerNumberFor(random, pair.a, pair.b);
  }

  static PickAnswerRound randomSmallerNumber(
    Random random, {
    int roundIndex = 0,
    int totalRounds = 18,
  }) {
    final pair = _comparePair(random, roundIndex, totalRounds);
    return _smallerNumberFor(random, pair.a, pair.b);
  }

  static OddOneOutRound randomOddOneOut(Random random) {
    final set = _oddSets[random.nextInt(_oddSets.length)];
    return OddOneOutRound(
      items: set.items,
      oddIndex: set.odd,
      instructionKey: 'mathLogic.activities.oddOneOut.instruction',
    );
  }

  static PickAnswerRound _middleNumberFor(Random random, int a, int b, int c) {
    final sorted = [a, b, c]..sort();
    final middle = sorted[1];
    final options = [a, b, c]..shuffle(random);
    return PickAnswerRound(
      instructionKey: 'mathLogic.activities.middleNumber.instruction',
      textParts: ['$a', '$b', '$c'],
      optionLabels: _intLabels(options),
      correctIndex: options.indexOf(middle),
    );
  }

  static ({int a, int b, int c}) _middleNumberTriple(
    Random random,
    int roundIndex,
    int totalRounds,
  ) {
    final maxNum = _progressiveMax(roundIndex, totalRounds);
    var a = 1 + random.nextInt(maxNum);
    var b = 1 + random.nextInt(maxNum);
    var c = 1 + random.nextInt(maxNum);
    while (b == a) {
      b = 1 + random.nextInt(maxNum);
    }
    while (c == a || c == b) {
      c = 1 + random.nextInt(maxNum);
    }
    return (a: a, b: b, c: c);
  }

  static List<MathActivityRound> _buildMiddleNumberSession(
    Random random,
    int total,
  ) {
    final used = <String>{};
    return List.generate(total, (i) {
      var triple = _middleNumberTriple(random, i, total);
      var attempts = 0;
      var key = ([triple.a, triple.b, triple.c]..sort()).join('_');
      while (used.contains(key) && attempts < 80) {
        triple = _middleNumberTriple(random, i, total);
        key = ([triple.a, triple.b, triple.c]..sort()).join('_');
        attempts++;
      }
      used.add(key);
      return MathActivityRound.pick(
        _middleNumberFor(random, triple.a, triple.b, triple.c),
      );
    });
  }

  static PickAnswerRound randomMiddleNumber(Random random) {
    final triple = _middleNumberTriple(random, 8, 15);
    return _middleNumberFor(random, triple.a, triple.b, triple.c);
  }

  static PickAnswerRound _doubleItFor(Random random, int n, int maxNum) {
    final answer = n * 2;
    final spread = (answer / 5).round().clamp(2, 8);
    final optMin = (answer - spread).clamp(2, 100);
    final optMax = (answer + spread).clamp(2, 100);
    final options = _pickOptions(random, answer, optMin, optMax);
    return PickAnswerRound(
      instructionKey: 'mathLogic.activities.doubleIt.instruction',
      instructionArgs: {'number': '$n'},
      optionLabels: _intLabels(options),
      correctIndex: _indexOf(options, answer),
    );
  }

  static List<MathActivityRound> _buildDoubleItSession(
    Random random,
    int total,
  ) {
    final used = <int>{};
    return List.generate(total, (i) {
      final maxNum = _progressiveOperandMax(i, total);
      final available = <int>[
        for (var v = 1; v <= maxNum; v++)
          if (!used.contains(v)) v,
      ];
      final n = available[random.nextInt(available.length)];
      used.add(n);
      return MathActivityRound.pick(
        _doubleItFor(random, n, _progressiveMax(i, total)),
      );
    });
  }

  static PickAnswerRound randomDoubleIt(
    Random random, {
    int roundIndex = 0,
    int totalRounds = 15,
  }) {
    final maxNum = _progressiveOperandMax(roundIndex, totalRounds);
    final n = 1 + random.nextInt(maxNum);
    return _doubleItFor(random, n, _progressiveMax(roundIndex, totalRounds));
  }

  static final List<String> _alphabetLetters = AlphabetData.items
      .map((item) => item.letter)
      .toList(growable: false);

  /// Standard school kakko order — excludes rare letters like ङ / ઙ where omitted.
  static const List<String> _gujaratiKakkoGlyphs = [
    'ક', 'ખ', 'ગ', 'ઘ', 'ચ', 'છ', 'જ', 'ઝ', 'ટ', 'ઠ', 'ડ', 'ઢ', 'ણ',
    'ત', 'થ', 'દ', 'ધ', 'ન', 'પ', 'ફ', 'બ', 'ભ', 'મ', 'ય', 'ર', 'લ', 'વ',
    'શ', 'ષ', 'સ', 'હ', 'ળ', 'ક્ષ', 'જ્ઞ',
  ];

  static const List<String> _devanagariKakkoGlyphs = [
    'क', 'ख', 'ग', 'घ', 'च', 'छ', 'ज', 'झ', 'ट', 'ठ', 'ड', 'ढ', 'ण',
    'त', 'थ', 'द', 'ध', 'न', 'प', 'फ', 'ब', 'भ', 'म', 'य', 'र', 'ल', 'व',
    'श', 'ष', 'स', 'ह', 'ळ', 'क्ष', 'ज्ञ',
  ];

  static const List<String> _gurmukhiKakkoGlyphs = [
    'ਕ', 'ਖ', 'ਗ', 'ਘ', 'ਚ', 'ਛ', 'ਜ', 'ਝ', 'ਟ', 'ਠ', 'ਡ', 'ਢ', 'ਣ',
    'ਤ', 'ਥ', 'ਦ', 'ਧ', 'ਨ', 'ਪ', 'ਫ', 'ਬ', 'ਭ', 'ਮ', 'ਯ', 'ਰ', 'ਲ', 'ਵ',
    'ਸ਼', '਷', 'ਸ', 'ਹ', 'ਲ਼', 'ਕ੍ਸ਼', 'ਗਿਆ',
  ];

  static const List<String> _tamilKakkoGlyphs = [
    'க', 'க', 'க', 'க', 'ச', 'ச', 'ஜ', 'ஜ', 'ட', 'ட', 'ட', 'ட', 'ண',
    'த', 'த', 'த', 'த', 'ந', 'ப', 'ப', 'ப', 'ப', 'ம', 'ய', 'ர', 'ல', 'வ',
    'ஷ', 'ஷ', 'ஸ', 'ஹ', 'ள', 'க்ஷ', 'ஞ',
  ];

  static List<String> _canonicalKakkoGlyphsFor(String languageCode) {
    switch (NativeScriptData.familyFor(languageCode)) {
      case NativeScriptFamily.gujarati:
        return _gujaratiKakkoGlyphs;
      case NativeScriptFamily.devanagari:
        return _devanagariKakkoGlyphs;
      case NativeScriptFamily.gurmukhi:
        return _gurmukhiKakkoGlyphs;
      case NativeScriptFamily.tamil:
        return _tamilKakkoGlyphs;
    }
  }

  static const List<({List<int> slots, int missingIndex})> _kakkoRoundTemplates = [
    (slots: [0, 1, -1, 3], missingIndex: 2),
    (slots: [18, -1, 20, 21], missingIndex: 19),
    (slots: [0, -1, 2, 3], missingIndex: 1),
    (slots: [4, 5, -1, 7], missingIndex: 6),
    (slots: [8, -1, 10, 11], missingIndex: 9),
    (slots: [13, 14, -1, 16], missingIndex: 15),
    (slots: [17, -1, 19, 20], missingIndex: 18),
    (slots: [22, 23, -1, 25], missingIndex: 24),
    (slots: [26, -1, 28, 29], missingIndex: 27),
    (slots: [27, 28, -1, 30], missingIndex: 29),
    (slots: [30, -1, 32, 33], missingIndex: 31),
    (slots: [2, 3, -1, 5], missingIndex: 4),
    (slots: [11, -1, 13, 14], missingIndex: 12),
    (slots: [20, 21, -1, 23], missingIndex: 22),
    (slots: [6, 7, -1, 9], missingIndex: 8),
  ];

  static bool _kakkoTemplateFits(
    ({List<int> slots, int missingIndex}) template,
    int listLength,
  ) {
    if (template.missingIndex < 0 || template.missingIndex >= listLength) {
      return false;
    }
    for (final slot in template.slots) {
      if (slot != -1 && (slot < 0 || slot >= listLength)) return false;
    }
    return true;
  }

  static ({List<int> slots, int missingIndex}) _kakkoTemplateFor(
    int roundIndex,
    int listLength,
  ) {
    for (var offset = 0; offset < _kakkoRoundTemplates.length; offset++) {
      final template =
          _kakkoRoundTemplates[(roundIndex + offset) % _kakkoRoundTemplates.length];
      if (_kakkoTemplateFits(template, listLength)) return template;
    }
    final missingIndex = (1 + roundIndex).clamp(1, listLength - 2);
    return (
      slots: [missingIndex - 1, -1, missingIndex + 1, missingIndex + 2],
      missingIndex: missingIndex,
    );
  }

  static List<MathActivityRound> _buildArrangeKakkoSession(
    String languageCode,
    int total,
  ) {
    final items = _canonicalKakkoGlyphsFor(languageCode);
    return List.generate(
      total,
      (i) => MathActivityRound.pick(
        _deterministicKakkoRound(
          items: items,
          roundIndex: i,
        ),
      ),
    );
  }

  static PickAnswerRound _deterministicKakkoRound({
    required List<String> items,
    required int roundIndex,
  }) {
    final template = _kakkoTemplateFor(roundIndex, items.length);
    final missingIndex = template.missingIndex;
    final correct = items[missingIndex];

    final parts = <String>[];
    var blankIndex = 0;
    for (var i = 0; i < template.slots.length; i++) {
      final slot = template.slots[i];
      if (slot == -1) {
        parts.add('__');
        blankIndex = i;
      } else {
        parts.add(items[slot]);
      }
    }

    final wrongOptions = <String>{};
    for (final slot in template.slots) {
      if (slot != -1 && slot != missingIndex) {
        wrongOptions.add(items[slot]);
      }
    }
    for (var delta = 1; wrongOptions.length < 2 && delta < items.length; delta++) {
      if (missingIndex - delta >= 0) {
        wrongOptions.add(items[missingIndex - delta]);
      }
      if (wrongOptions.length < 2 && missingIndex + delta < items.length) {
        wrongOptions.add(items[missingIndex + delta]);
      }
    }
    wrongOptions.remove(correct);

    var options = <String>[correct, ...wrongOptions.take(2)];
    if (roundIndex % 3 == 1) {
      options = [options[1], options[0], options[2]];
    } else if (roundIndex % 3 == 2) {
      options = [options[2], options[0], options[1]];
    }

    return PickAnswerRound(
      instructionKey: 'mathLogic.activities.arrangeKakko.instruction',
      textParts: parts,
      blankIndex: blankIndex,
      optionLabels: options,
      correctIndex: options.indexOf(correct),
    );
  }

  static final List<String> _dayLabelRefs = EverydayWordsData.days
      .map((item) => _translationRef(item.nameKey!))
      .toList(growable: false);

  static List<String> _monthLabelRefsFor(String languageCode) {
    return EverydayWordsData.monthsForLocale(languageCode)
        .map((item) => _translationRef(item.nameKey!))
        .toList(growable: false);
  }

  static String _translationRef(String key) =>
      '${MathLogicDigits.translationRefPrefix}$key';

  static int _progressivePoolEnd(
    int roundIndex,
    int totalRounds,
    int fullLength, {
    int minPool = 4,
  }) {
    if (fullLength <= minPool) return fullLength;
    if (roundIndex < 4) {
      return (fullLength * 0.4).round().clamp(minPool, fullLength);
    }
    if (roundIndex < 10) {
      return (fullLength * 0.7).round().clamp(minPool + 2, fullLength);
    }
    return fullLength;
  }

  static PickAnswerRound _randomMissingInSequence(
    Random random, {
    required List<String> items,
    required String instructionKey,
    int roundIndex = 0,
    int totalRounds = 15,
    int minSeqLen = 3,
    int maxSeqLen = 5,
  }) {
    final poolEnd = _progressivePoolEnd(roundIndex, totalRounds, items.length);
    final pool = items.sublist(0, poolEnd);
    final poolLen = pool.length;

    final effectiveMaxSeq = maxSeqLen.clamp(minSeqLen, poolLen);
    final seqLen = minSeqLen == effectiveMaxSeq
        ? minSeqLen
        : minSeqLen + random.nextInt(effectiveMaxSeq - minSeqLen + 1);

    final maxStart = poolLen - seqLen;
    final start = random.nextInt(maxStart + 1);
    final missingPos = 1 + random.nextInt(seqLen - 2);
    final missingPoolIndex = start + missingPos;
    final correct = pool[missingPoolIndex];

    final parts = <String>[];
    for (var i = 0; i < seqLen; i++) {
      parts.add(i == missingPos ? '__' : pool[start + i]);
    }

    final wrongOptions = <String>{};
    for (var delta = -2; delta <= 2; delta++) {
      if (delta == 0) continue;
      final idx = missingPoolIndex + delta;
      if (idx >= 0 && idx < poolLen) {
        wrongOptions.add(pool[idx]);
      }
    }

    var attempts = 0;
    while (wrongOptions.length < 2 && attempts < 40) {
      final idx = random.nextInt(poolLen);
      if (pool[idx] != correct) wrongOptions.add(pool[idx]);
      attempts++;
    }
    while (wrongOptions.length < 2) {
      final idx = random.nextInt(items.length);
      if (items[idx] != correct) wrongOptions.add(items[idx]);
    }

    final options = [correct, ...wrongOptions.take(2)].toList()..shuffle(random);

    return PickAnswerRound(
      instructionKey: instructionKey,
      textParts: parts,
      blankIndex: missingPos,
      optionLabels: options,
      correctIndex: options.indexOf(correct),
    );
  }

  static PickAnswerRound randomArrangeAlphabet(
    Random random, {
    int roundIndex = 0,
    int totalRounds = 15,
  }) {
    return _randomMissingInSequence(
      random,
      items: _alphabetLetters,
      instructionKey: 'mathLogic.activities.arrangeAlphabet.instruction',
      roundIndex: roundIndex,
      totalRounds: totalRounds,
      minSeqLen: 3,
      maxSeqLen: 5,
    );
  }

  static PickAnswerRound randomArrangeDays(
    Random random, {
    int roundIndex = 0,
    int totalRounds = 15,
  }) {
    return _randomMissingInSequence(
      random,
      items: _dayLabelRefs,
      instructionKey: 'mathLogic.activities.arrangeDays.instruction',
      roundIndex: roundIndex,
      totalRounds: totalRounds,
      minSeqLen: 3,
      maxSeqLen: 4,
    );
  }

  static PickAnswerRound randomArrangeMonths(
    Random random, {
    String languageCode = 'en',
    int roundIndex = 0,
    int totalRounds = 15,
  }) {
    return _randomMissingInSequence(
      random,
      items: _monthLabelRefsFor(languageCode),
      instructionKey: 'mathLogic.activities.arrangeMonths.instruction',
      roundIndex: roundIndex,
      totalRounds: totalRounds,
      minSeqLen: 3,
      maxSeqLen: 5,
    );
  }
}
