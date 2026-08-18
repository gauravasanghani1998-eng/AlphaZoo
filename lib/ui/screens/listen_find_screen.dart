import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../data/puzzle_games_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import '../widgets/kid_alphabet_style_detail.dart';
import '../widgets/puzzle_play_ui.dart';

class ListenFindScreen extends StatefulWidget {
  const ListenFindScreen({super.key});

  @override
  State<ListenFindScreen> createState() => _ListenFindScreenState();
}

class _ListenFindScreenState extends State<ListenFindScreen> {
  Color get _accent => PuzzleGameColors.accent(PuzzleGameId.listenFind);
  Color get _buttonWash => PuzzleGameColors.wash(PuzzleGameId.listenFind);

  List<ListenFindRound> _rounds = [];
  int _index = 0;
  int _score = 0;
  bool _playing = false;
  bool _won = false;
  int? _selected;
  bool _answered = false;
  final Set<int> _correctRoundIndices = {};
  final Map<int, int> _correctOptionByRound = {};

  ListenFindRound get _current => _rounds[_index];

  Color get _roundAccent =>
      AppColors.puzzlePageAccent(gameAccent: _accent, itemIndex: _index);

  bool get _isLastRound => _index >= _rounds.length - 1;

  @override
  void dispose() {
    AppSpeech.stop();
    super.dispose();
  }

  Future<void> _start() async {
    AppHapticFeedback.medium();
    setState(() {
      _rounds = PuzzleGamesData.listenFindRounds();
      _index = 0;
      _score = 0;
      _playing = true;
      _won = false;
      _selected = null;
      _answered = false;
      _correctRoundIndices.clear();
      _correctOptionByRound.clear();
    });
    await AppSpeech.speak(
      context,
      'puzzleGames.listenFind.startSpeak'.tr(),
    );
    if (!mounted || !_playing || _won) return;
    await _speakPrompt();
  }

  Future<void> _speakPrompt() async {
    if (!_playing || _won) return;
    final name = _current.correct.nameKey.tr();
    await AppSpeech.speak(
      context,
      'puzzleGames.listenFind.speakPrompt'.tr(namedArgs: {'name': name}),
    );
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
    _speakPrompt();
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
    await AppSpeech.speak(
      context,
      'puzzleGames.listenFind.correctSpeak'.tr(),
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
      title: 'puzzleGames.listenFind.title'.tr(),
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
              subtitle: 'puzzleGames.listenFind.winSubtitle'.tr(
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
          emoji: '👂',
          title: 'puzzleGames.listenFind.setupTitle'.tr(),
          subtitle: 'puzzleGames.listenFind.setupSubtitle'.tr(),
          hint: 'puzzleGames.listenFind.prompt'.tr(),
          accent: _accent,
        ),
        const SizedBox(height: 16),
        PuzzleHowStep(
          step: 1,
          emoji: '🔊',
          text: 'puzzleGames.listenFind.howStep1'.tr(),
          accent: PuzzleGameColors.step(_accent, 0),
        ),
        PuzzleHowStep(
          step: 2,
          emoji: '🖼️',
          text: 'puzzleGames.listenFind.howStep2'.tr(),
          accent: PuzzleGameColors.step(_accent, 1),
        ),
        PuzzleHowStep(
          step: 3,
          emoji: '⭐',
          text: 'puzzleGames.listenFind.howStep3'.tr(),
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
                'puzzleGames.listenFind.prompt'.tr(),
                style: PuzzlePlayUi.titleStyle(
                  size: 18,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Center(
          child: GestureDetector(
            onTap: _speakPrompt,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              decoration: BoxDecoration(
                color: roundAccent,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: roundAccent.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.volume_up_rounded, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    'puzzleGames.listenFind.listenAgain'.tr(),
                    style: PuzzlePlayUi.bodyStyle(
                      size: 15,
                      color: Colors.white,
                      weight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _current.options.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.05,
          ),
          itemBuilder: (context, i) {
            final opt = _current.options[i];
            final isCorrectOption = opt.id == _current.correct.id;
            final showCorrect = _answered &&
                _correctOptionByRound[_index] == i &&
                isCorrectOption;
            final showWrong =
                !_answered && _selected == i && !isCorrectOption;

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
                  borderRadius: BorderRadius.circular(22),
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
                child: Text(opt.emoji, style: const TextStyle(fontSize: 48)),
              ),
            );
          },
        ),
      ],
    );
  }
}
