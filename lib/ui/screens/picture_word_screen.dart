import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../data/puzzle_games_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import '../widgets/kid_alphabet_style_detail.dart';
import '../widgets/puzzle_play_ui.dart';

class PictureWordScreen extends StatefulWidget {
  const PictureWordScreen({super.key});

  @override
  State<PictureWordScreen> createState() => _PictureWordScreenState();
}

class _PictureWordScreenState extends State<PictureWordScreen> {
  Color get _accent => PuzzleGameColors.accent(PuzzleGameId.pictureWord);
  Color get _buttonWash => PuzzleGameColors.wash(PuzzleGameId.pictureWord);

  List<PictureWordRound> _rounds = [];
  int _index = 0;
  int _score = 0;
  bool _playing = false;
  bool _won = false;
  int? _selected;
  bool _answered = false;
  final Set<int> _correctRoundIndices = {};
  final Map<int, int> _correctOptionByRound = {};

  PictureWordRound get _current => _rounds[_index];

  Color get _roundAccent =>
      AppColors.puzzlePageAccent(gameAccent: _accent, itemIndex: _index);

  bool get _isLastRound => _index >= _rounds.length - 1;

  @override
  void dispose() {
    AppSpeech.stop();
    super.dispose();
  }

  void _start() {
    AppHapticFeedback.medium();
    setState(() {
      _rounds = PuzzleGamesData.pictureWordRounds();
      _index = 0;
      _score = 0;
      _playing = true;
      _won = false;
      _selected = null;
      _answered = false;
      _correctRoundIndices.clear();
      _correctOptionByRound.clear();
    });
    AppSpeech.speak(context, 'puzzleGames.pictureWord.startSpeak'.tr());
  }

  void _syncRoundState() {
    _answered = _correctRoundIndices.contains(_index);
    if (_answered) {
      _selected = _correctOptionByRound[_index];
    } else {
      _selected = null;
    }
    _score = _correctRoundIndices.length;
  }

  void _goToRound(int index) {
    if (index < 0 || index >= _rounds.length) return;
    setState(() {
      _index = index;
      _syncRoundState();
    });
  }

  Future<void> _pick(int optionIndex) async {
    if (!_playing || _won || _answered) return;

    final option = _current.options[optionIndex];
    final name = option.nameKey.tr();
    final isCorrect = option.id == _current.correct.id;

    setState(() => _selected = optionIndex);

    if (!isCorrect) {
      AppHapticFeedback.error();
      await AppSpeech.speakSequence(
        context,
        [name, 'puzzleGames.tryAgain'.tr()],
        isCurrent: () =>
            mounted && !_answered && _selected == optionIndex && !_won,
      );
      if (!mounted || _answered || _selected != optionIndex) return;
      setState(() => _selected = null);
      return;
    }

    AppHapticFeedback.success();
    if (!_correctRoundIndices.contains(_index)) {
      _correctRoundIndices.add(_index);
    }
    _correctOptionByRound[_index] = optionIndex;
    setState(() {
      _answered = true;
      _score = _correctRoundIndices.length;
    });
    // One clear sentence that already includes the name — no cut-off.
    await AppSpeech.speak(
      context,
      'puzzleGames.pictureWord.correctSpeak'.tr(
        namedArgs: {'name': name},
      ),
    );
  }

  void _previousRound() {
    if (_index <= 0) return;
    AppHapticFeedback.light();
    _goToRound(_index - 1);
  }

  void _onNextPressed() {
    if (!_answered) return;
    AppHapticFeedback.light();
    if (_isLastRound) {
      setState(() => _won = true);
      AppHapticFeedback.heavy();
      AppSpeech.speak(context, 'puzzleGames.winSpeak'.tr());
      return;
    }
    _goToRound(_index + 1);
  }

  @override
  Widget build(BuildContext context) {
    final pad = context.responsive.horizontalPadding;

    return PuzzleModuleScaffold(
      title: 'puzzleGames.pictureWord.title'.tr(),
      themeAccent: _playing ? _roundAccent : _accent,
      sessionChrome: _playing,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(pad, 12, pad, 12),
                  child: !_playing ? _setup() : _play(),
                ),
              ),
              if (_playing && !_won)
                KidAlphabetStyleDetail.navigationBar(
                  responsive: context.responsive,
                  accentColor: _roundAccent,
                  barDecoration:
                      PuzzleGameColors.puzzleNavBarDecoration(_roundAccent),
                  canPrevious: _index > 0,
                  canNext: _answered,
                  onPrevious: _index > 0 ? _previousRound : null,
                  onNext: _answered ? _onNextPressed : null,
                ),
            ],
          ),
          if (_won)
            PuzzleWinOverlay(
              title: 'puzzleGames.winTitle'.tr(),
              subtitle: 'puzzleGames.pictureWord.winSubtitle'.tr(
                namedArgs: {
                  'score': '$_score',
                  'total': '${_rounds.length}',
                },
              ),
              primaryLabel: 'puzzleGames.playAgain'.tr(),
              secondaryLabel: 'puzzleGames.backToGames'.tr(),
              accent: _roundAccent,
              onPrimary: () {
                setState(() => _won = false);
                _start();
              },
              onSecondary: () {
                setState(() => _won = false);
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
    );
  }

  Widget _setup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PuzzleSetupIntro(
          emoji: '🖼️',
          title: 'puzzleGames.pictureWord.setupTitle'.tr(),
          subtitle: 'puzzleGames.pictureWord.setupSubtitle'.tr(),
          hint: 'puzzleGames.pictureWord.prompt'.tr(),
          accent: _accent,
        ),
        const SizedBox(height: 16),
        Text(
          'puzzleGames.pictureWord.howTitle'.tr(),
          style: PuzzlePlayUi.titleStyle(size: 18),
        ),
        const SizedBox(height: 10),
        PuzzleHowStep(
          step: 1,
          emoji: '👀',
          text: 'puzzleGames.pictureWord.howStep1'.tr(),
          accent: PuzzleGameColors.step(_accent, 0),
        ),
        PuzzleHowStep(
          step: 2,
          emoji: '🔤',
          text: 'puzzleGames.pictureWord.howStep2'.tr(),
          accent: PuzzleGameColors.step(_accent, 1),
        ),
        PuzzleHowStep(
          step: 3,
          emoji: '⭐',
          text: 'puzzleGames.pictureWord.howStep3'.tr(),
          accent: PuzzleGameColors.step(_accent, 2),
        ),
        const SizedBox(height: 20),
        PuzzlePrimaryButton(
          label: 'puzzleGames.start'.tr(),
          accent: _accent,
          wash: _buttonWash,
          onPressed: _start,
        ),
      ],
    );
  }

  Widget _play() {
    final round = _current;
    final roundAccent = _roundAccent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PuzzleHudBar(
          stars: _score,
          maxStars: _rounds.length,
          trailingLabel: 'puzzleGames.round'.tr(
            namedArgs: {
              'current': '${_index + 1}',
              'total': '${_rounds.length}',
            },
          ),
          accent: roundAccent,
          surfaceColor: PuzzleGameColors.puzzleHudSurface(roundAccent),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Container(
              width: 5,
              height: 22,
              decoration: BoxDecoration(
                color: roundAccent,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'puzzleGames.pictureWord.prompt'.tr(),
                style: PuzzlePlayUi.titleStyle(
                  size: 18,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 28),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: roundAccent.withValues(alpha: 0.45),
              width: 2.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(round.correct.emoji, style: const TextStyle(fontSize: 72)),
        ),
        const SizedBox(height: 16),
        ...List.generate(round.options.length, (i) {
          final opt = round.options[i];
          final isCorrectOption = opt.id == round.correct.id;
          final showCorrect = _answered &&
              _correctOptionByRound[_index] == i &&
              isCorrectOption;
          final showWrong =
              !_answered && _selected == i && !isCorrectOption;

          Color border = AppColors.textSecondary.withValues(alpha: 0.22);
          Color bg = AppColors.white;
          Color textColor = AppColors.textPrimary;

          if (showCorrect) {
            border = AppColors.puzzleSuccess;
            bg = Color.lerp(AppColors.white, AppColors.puzzleSuccess, 0.14)!;
            textColor = AppColors.puzzleSuccess;
          } else if (showWrong) {
            border = AppColors.puzzleWrong;
            bg = Color.lerp(AppColors.white, AppColors.puzzleWrong, 0.12)!;
            textColor = AppColors.puzzleWrong;
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: _answered ? null : () => _pick(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: border, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  opt.nameKey.tr(),
                  textAlign: TextAlign.center,
                  style: PuzzlePlayUi.titleStyle(
                    size: 18,
                    color: textColor,
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
