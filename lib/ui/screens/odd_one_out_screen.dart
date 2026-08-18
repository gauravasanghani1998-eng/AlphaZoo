import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../data/puzzle_games_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import '../widgets/kid_alphabet_style_detail.dart';
import '../widgets/puzzle_play_ui.dart';

class OddOneOutScreen extends StatefulWidget {
  const OddOneOutScreen({super.key});

  @override
  State<OddOneOutScreen> createState() => _OddOneOutScreenState();
}

class _OddOneOutScreenState extends State<OddOneOutScreen> {
  Color get _accent => PuzzleGameColors.accent(PuzzleGameId.oddOneOut);
  Color get _buttonWash => PuzzleGameColors.wash(PuzzleGameId.oddOneOut);

  List<OddOneOutRound> _rounds = [];
  int _index = 0;
  int _score = 0;
  bool _playing = false;
  bool _won = false;
  int? _selected;
  bool _answered = false;
  final Set<int> _correctRoundIndices = {};
  final Map<int, int> _correctOptionByRound = {};

  OddOneOutRound get _current => _rounds[_index];

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
      _rounds = PuzzleGamesData.oddOneOutRounds();
      _index = 0;
      _score = 0;
      _playing = true;
      _won = false;
      _selected = null;
      _answered = false;
      _correctRoundIndices.clear();
      _correctOptionByRound.clear();
    });
    AppSpeech.speak(context, 'puzzleGames.oddOneOut.startSpeak'.tr());
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
    final isOdd = optionIndex == _current.oddIndex;

    setState(() => _selected = optionIndex);

    if (!isOdd) {
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
    await AppSpeech.speakSequence(
      context,
      [name, 'puzzleGames.oddOneOut.correctSpeak'.tr()],
      isCurrent: () => mounted && _answered && !_won,
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
      title: 'puzzleGames.oddOneOut.title'.tr(),
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
              subtitle: 'puzzleGames.oddOneOut.winSubtitle'.tr(
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
          emoji: '🔎',
          title: 'puzzleGames.oddOneOut.setupTitle'.tr(),
          subtitle: 'puzzleGames.oddOneOut.setupSubtitle'.tr(),
          hint: 'puzzleGames.oddOneOut.prompt'.tr(),
          accent: _accent,
        ),
        const SizedBox(height: 16),
        PuzzleHowStep(
          step: 1,
          emoji: '👀',
          text: 'puzzleGames.oddOneOut.howStep1'.tr(),
          accent: PuzzleGameColors.step(_accent, 0),
        ),
        PuzzleHowStep(
          step: 2,
          emoji: '👆',
          text: 'puzzleGames.oddOneOut.howStep2'.tr(),
          accent: PuzzleGameColors.step(_accent, 1),
        ),
        PuzzleHowStep(
          step: 3,
          emoji: '⭐',
          text: 'puzzleGames.oddOneOut.howStep3'.tr(),
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
                'puzzleGames.oddOneOut.prompt'.tr(),
                style: PuzzlePlayUi.titleStyle(
                  size: 18,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _current.options.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (context, i) {
            final opt = _current.options[i];
            final isOdd = i == _current.oddIndex;
            final showCorrect =
                _answered && _correctOptionByRound[_index] == i && isOdd;
            final showWrong = !_answered && _selected == i && !isOdd;

            Color border = AppColors.textSecondary.withValues(alpha: 0.22);
            Color bg = AppColors.white;

            if (showCorrect) {
              border = AppColors.puzzleSuccess;
              bg = Color.lerp(AppColors.white, AppColors.puzzleSuccess, 0.14)!;
            } else if (showWrong) {
              border = AppColors.puzzleWrong;
              bg = Color.lerp(AppColors.white, AppColors.puzzleWrong, 0.12)!;
            }

            return GestureDetector(
              onTap: _answered ? null : () => _pick(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: border, width: 2.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(opt.emoji, style: const TextStyle(fontSize: 52)),
              ),
            );
          },
        ),
      ],
    );
  }
}
