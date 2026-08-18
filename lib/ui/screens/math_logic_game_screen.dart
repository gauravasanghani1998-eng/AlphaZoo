import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/math_logic_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/math_logic_colors.dart';
import '../../utils/math_logic_digits.dart';
import '../../utils/responsive.dart';
import '../widgets/kid_module_scaffold.dart';
import '../widgets/math_logic_play_ui.dart';

class MathLogicGameScreen extends StatefulWidget {
  final MathActivityId activityId;
  final Color accentColor;

  const MathLogicGameScreen({
    super.key,
    required this.activityId,
    required this.accentColor,
  });

  @override
  State<MathLogicGameScreen> createState() => _MathLogicGameScreenState();
}

class _MathLogicGameScreenState extends State<MathLogicGameScreen> {
  late List<MathActivityRound> _session;
  String? _sessionLanguage;
  int _roundIndex = 0;
  bool _answered = false;
  bool _sessionComplete = false;
  int? _selectedIndex;
  final Set<int> _tappedIndices = {};

  MathActivityInfo get _info => MathLogicData.activityInfo(widget.activityId);

  MathActivityRound get _current => _session[_roundIndex];

  int get _roundNumber => _roundIndex + 1;

  int get _totalRounds => _session.length;

  bool get _isLastRound => _roundIndex >= _session.length - 1;

  String get _instructionKey {
    if (widget.activityId == MathActivityId.countAndTap) {
      return 'mathLogic.activities.countAndTap.instruction';
    }
    return switch (_current.kind) {
      MathRoundKind.pickAnswer => _current.pickAnswer!.instructionKey,
      MathRoundKind.twoGroup => _current.twoGroup!.instructionKey,
      MathRoundKind.pictureMath => _current.pictureMath!.instructionKey,
      MathRoundKind.pattern => _current.pattern!.instructionKey,
      MathRoundKind.oddOneOut => _current.oddOneOut!.instructionKey,
      MathRoundKind.countTap => 'mathLogic.activities.countAndTap.instruction',
    };
  }

  Map<String, String>? get _instructionArgs => _current.pickAnswer?.instructionArgs;

  Map<String, String>? _formattedInstructionArgs(BuildContext context) {
    return MathLogicDigits.formatArgs(context, _instructionArgs);
  }

  String _localizedInstruction(BuildContext context) {
    final args = _formattedInstructionArgs(context);
    return args == null
        ? _instructionKey.tr()
        : _instructionKey.tr(namedArgs: args);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final languageCode = context.locale.languageCode;
    if (_sessionLanguage == languageCode) return;

    final reload = _sessionLanguage != null;
    _sessionLanguage = languageCode;
    _session = MathLogicData.sessionFor(
      widget.activityId,
      languageCode: languageCode,
    );

    if (!reload) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _speakInstruction());
    } else {
      setState(() {
        _roundIndex = 0;
        _resetRoundUi();
        _sessionComplete = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) => _speakInstruction());
    }
  }

  void _resetRoundUi() {
    _answered = false;
    _selectedIndex = null;
    _tappedIndices.clear();
  }

  Future<void> _speakInstruction() async {
    if (!mounted || _sessionComplete) return;
    await AppSpeech.speak(context, _localizedInstruction(context));
  }

  Future<void> _onCorrect() async {
    if (_answered) return;
    setState(() => _answered = true);
    await AppHapticFeedback.success();

    if (_isLastRound) {
      setState(() => _sessionComplete = true);
      if (mounted) {
        await AppSpeech.speak(context, 'mathLogic.games.sessionComplete'.tr());
      }
    } else if (mounted) {
      await AppSpeech.speak(context, 'mathLogic.games.correct'.tr());
    }
  }

  Future<void> _onWrong() async {
    await AppHapticFeedback.light();
    if (mounted) {
      await AppSpeech.speak(context, 'mathLogic.games.tryAgain'.tr());
    }
  }

  void _previousRound() {
    if (_roundIndex <= 0) return;
    setState(() {
      _roundIndex--;
      _resetRoundUi();
      _sessionComplete = false;
    });
    _speakInstruction();
  }

  void _nextRound() {
    if (_sessionComplete || _isLastRound) return;
    setState(() {
      _roundIndex++;
      _resetRoundUi();
    });
    _speakInstruction();
  }

  void _finishSession() {
    AppHapticFeedback.success();
    AppSpeech.stop();
    Navigator.of(context).pop();
  }

  void _onNextPressed() {
    if (_sessionComplete || (_isLastRound && _answered)) {
      _finishSession();
    } else {
      _nextRound();
    }
  }

  @override
  void dispose() {
    AppSpeech.stop();
    super.dispose();
  }

  Color get _accent => MathLogicColors.forRound(
        widget.activityId,
        _roundIndex,
        baseAccent: widget.accentColor,
      );

  @override
  Widget build(BuildContext context) {
    final accent = _accent;
    final instruction = _localizedInstruction(context);

    return KidModuleScaffold(
      title: _info.titleKey.tr(),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                context.responsive.horizontalPadding,
                context.responsive.verticalPadding,
                context.responsive.horizontalPadding,
                16,
              ),
              child: Column(
                children: [
                  MathPlayUi.sessionProgress(
                    context: context,
                    currentRound: _roundNumber,
                    totalRounds: _totalRounds,
                    accent: accent,
                    sessionComplete: _sessionComplete,
                  ),
                  const SizedBox(height: 16),
                  MathPlayUi.instructionBanner(
                    text: instruction,
                    onSpeak: _speakInstruction,
                    showSuccess: _answered && !_sessionComplete,
                    successText: 'mathLogic.games.wellDone'.tr(),
                    showFinish: _sessionComplete,
                    finishText: 'mathLogic.games.sessionComplete'.tr(),
                    accent: accent,
                  ),
                  const SizedBox(height: 20),
                  MathPlayUi.playCard(accent: accent, child: _buildBody(accent)),
                ],
              ),
            ),
          ),
          MathPlayUi.roundNavigationBar(
            responsive: context.responsive,
            accent: accent,
            canPrevious: _roundIndex > 0,
            canNext: _answered,
            onPrevious: _roundIndex > 0 ? _previousRound : null,
            onNext: _answered ? _onNextPressed : null,
            showFinishLabel: _sessionComplete || _isLastRound,
          ),
        ],
      ),
    );
  }

  Widget _buildBody(Color accent) {
    return switch (_current.kind) {
      MathRoundKind.pickAnswer => _buildPickAnswer(accent, _current.pickAnswer!),
      MathRoundKind.countTap => _buildCountTap(accent, _current.countTap!),
      MathRoundKind.twoGroup => _buildCompare(accent, _current.twoGroup!),
      MathRoundKind.pictureMath => _buildPictureMath(accent, _current.pictureMath!),
      MathRoundKind.pattern => _buildPattern(accent, _current.pattern!),
      MathRoundKind.oddOneOut => _buildOddOneOut(accent, _current.oddOneOut!),
    };
  }

  Widget _buildPickAnswer(Color accent, PickAnswerRound round) {
    return Column(
      children: [
        if (round.emoji != null && round.emojiCount != null)
          MathPlayUi.emojiGrid(
            emoji: round.emoji!,
            count: round.emojiCount!,
            accent: accent,
          ),
        if (round.instructionArgs != null &&
            round.instructionArgs!.containsKey('left'))
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MathPlayUi.numberPair(
              left: MathLogicDigits.formatText(
                context,
                round.instructionArgs!['left']!,
              ),
              right: MathLogicDigits.formatText(
                context,
                round.instructionArgs!['right']!,
              ),
              symbol: widget.activityId == MathActivityId.biggerNumber
                  ? '?'
                  : widget.activityId == MathActivityId.smallerNumber
                      ? '?'
                      : '+',
              accent: accent,
            ),
          ),
        if ((widget.activityId == MathActivityId.doubleIt ||
                widget.activityId == MathActivityId.forwardCount ||
                widget.activityId == MathActivityId.backwardCount) &&
            round.instructionArgs != null &&
            round.instructionArgs!.containsKey('number'))
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MathPlayUi.numberChip(
              MathLogicDigits.formatText(
                context,
                round.instructionArgs!['number']!,
              ),
              accent,
            ),
          ),
        if (widget.activityId == MathActivityId.fillAddition &&
            round.instructionArgs != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              '${MathLogicDigits.formatText(context, round.instructionArgs!['a']!)} + '
              '${MathLogicDigits.formatText(context, round.instructionArgs!['b']!)} = ?',
              style: AppTextStyles.bodyBold.copyWith(
                fontSize: 36,
                color: accent,
                fontWeight: FontWeight.w800,
                height: 1.1,
              ),
            ),
          ),
        if (widget.activityId == MathActivityId.fillSubtraction &&
            round.instructionArgs != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              '${MathLogicDigits.formatText(context, round.instructionArgs!['a']!)} − '
              '${MathLogicDigits.formatText(context, round.instructionArgs!['b']!)} = ?',
              style: AppTextStyles.bodyBold.copyWith(
                fontSize: 36,
                color: accent,
                fontWeight: FontWeight.w800,
                height: 1.1,
              ),
            ),
          ),
        if (round.textParts != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: MathPlayUi.sequenceRow(
              MathLogicDigits.formatParts(context, round.textParts!),
              accent: accent,
            ),
          ),
        const SizedBox(height: 18),
        MathPlayUi.optionButtons(
          labels: MathLogicDigits.formatLabels(context, round.optionLabels),
          answered: _answered,
          selectedIndex: _selectedIndex,
          correctIndex: round.correctIndex,
          onPick: (i) {
            setState(() => _selectedIndex = i);
            if (i == round.correctIndex) {
              _onCorrect();
            } else {
              _onWrong();
            }
          },
          accent: accent,
        ),
      ],
    );
  }

  Widget _buildCountTap(Color accent, CountTapRound round) {
    return Column(
      children: [
        Text(
          'mathLogic.games.countProgress'.tr(
            namedArgs: {
              'current': MathLogicDigits.format(context, _tappedIndices.length),
              'total': MathLogicDigits.format(context, round.count),
            },
          ),
          style: AppTextStyles.bodyBold.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: List.generate(round.count, (index) {
            final tapped = _tappedIndices.contains(index);
            final tileColor = MathLogicColors.tileColor(
              widget.activityId,
              _roundIndex,
              index,
              baseAccent: accent,
            );
            return GestureDetector(
              onTap: _answered
                  ? null
                  : () {
                      if (_tappedIndices.contains(index)) return;
                      setState(() => _tappedIndices.add(index));
                      AppHapticFeedback.light();
                      if (_tappedIndices.length == round.count) {
                        _onCorrect();
                      }
                    },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: tapped
                      ? tileColor.withValues(alpha: 0.12)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: tapped
                        ? tileColor.withValues(alpha: 0.65)
                        : tileColor.withValues(alpha: 0.4),
                    width: 2.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: tileColor.withValues(alpha: 0.16),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    tapped ? '✓' : round.emoji,
                    style: TextStyle(
                      fontSize: tapped ? 28 : 38,
                      color: tapped ? tileColor : null,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildCompare(Color accent, TwoGroupRound round) {
    final correctIndex = round.leftHasMore ? 0 : 1;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _compareColumn(
            accent: accent,
            label: 'mathLogic.games.leftGroup'.tr(),
            emoji: round.emoji,
            count: round.leftCount,
            groupIndex: 0,
            correctIndex: correctIndex,
            selectedIndex: _selectedIndex,
            onTap: _answered ? null : () => _pickCompare(round, true, 0),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _compareColumn(
            accent: accent,
            label: 'mathLogic.games.rightGroup'.tr(),
            emoji: round.emoji,
            count: round.rightCount,
            groupIndex: 1,
            correctIndex: correctIndex,
            selectedIndex: _selectedIndex,
            onTap: _answered ? null : () => _pickCompare(round, false, 1),
          ),
        ),
      ],
    );
  }

  void _pickCompare(TwoGroupRound round, bool left, int groupIndex) {
    setState(() => _selectedIndex = groupIndex);
    final ok = round.leftHasMore ? left : !left;
    if (ok) {
      _onCorrect();
    } else {
      _onWrong();
    }
  }

  Widget _compareColumn({
    required Color accent,
    required String label,
    required String emoji,
    required int count,
    required int groupIndex,
    required int correctIndex,
    required int? selectedIndex,
    required VoidCallback? onTap,
  }) {
    final isSelected = selectedIndex == groupIndex;
    final isCorrectPick = groupIndex == correctIndex;
    final style = MathPlayUi.selectionStyle(
      accent: accent,
      isSelected: isSelected,
      isCorrectPick: isCorrectPick,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: style.background,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: style.border, width: 2.5),
            boxShadow: style.shadows,
          ),
          child: Column(
            children: [
              Text(label, style: AppTextStyles.caption.copyWith(fontSize: 13)),
              const SizedBox(height: 10),
              MathPlayUi.emojiGrid(emoji: emoji, count: count, size: 28, accent: accent),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPictureMath(Color accent, PictureMathRound round) {
    return Column(
      children: [
        MathPlayUi.pictureMathDisplay(round, accent: accent),
        const SizedBox(height: 24),
        MathPlayUi.optionButtons(
          labels: round.options
              .map((n) => MathLogicDigits.format(context, n))
              .toList(),
          answered: _answered,
          selectedIndex: _selectedIndex,
          correctIndex: round.options.indexOf(round.correctAnswer),
          onPick: (i) {
            setState(() => _selectedIndex = i);
            if (round.options[i] == round.correctAnswer) {
              _onCorrect();
            } else {
              _onWrong();
            }
          },
          accent: accent,
        ),
      ],
    );
  }

  Widget _buildPattern(Color accent, PatternRound round) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          children: [
            ...round.shown.map((s) => Text(s, style: const TextStyle(fontSize: 42))),
            Container(
              width: 52,
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    accent.withValues(alpha: 0.25),
                    accent.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: accent, width: 2),
              ),
              child: Text(
                '?',
                style: AppTextStyles.heading2.copyWith(
                  fontSize: 28,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        MathPlayUi.optionButtons(
          labels: round.options,
          answered: _answered,
          selectedIndex: _selectedIndex,
          correctIndex: round.options.indexOf(round.correct),
          onPick: (i) {
            setState(() => _selectedIndex = i);
            if (round.options[i] == round.correct) {
              _onCorrect();
            } else {
              _onWrong();
            }
          },
          accent: accent,
        ),
      ],
    );
  }

  Widget _buildOddOneOut(Color accent, OddOneOutRound round) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 1.05,
      ),
      itemCount: round.items.length,
      itemBuilder: (context, index) {
        final isSelected = _selectedIndex == index;
        final isCorrectPick = index == round.oddIndex;
        final style = MathPlayUi.selectionStyle(
          accent: accent,
          isSelected: isSelected,
          isCorrectPick: isCorrectPick,
        );

        return GestureDetector(
          onTap: _answered
              ? null
              : () {
                  setState(() => _selectedIndex = index);
                  if (index == round.oddIndex) {
                    _onCorrect();
                  } else {
                    _onWrong();
                  }
                },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              color: style.background,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: style.border, width: 2.5),
              boxShadow: style.shadows,
            ),
            child: Center(
              child: Text(round.items[index], style: const TextStyle(fontSize: 54)),
            ),
          ),
        );
      },
    );
  }
}
