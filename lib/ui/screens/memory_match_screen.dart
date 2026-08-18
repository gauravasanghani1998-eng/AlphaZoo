import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../data/puzzle_games_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import '../widgets/puzzle_play_ui.dart';

class _MemoryCard {
  final String pairId;
  final String emoji;
  final String? labelKey;
  bool faceUp = false;
  bool matched = false;

  _MemoryCard({
    required this.pairId,
    required this.emoji,
    this.labelKey,
  });
}

class MemoryMatchScreen extends StatefulWidget {
  const MemoryMatchScreen({super.key});

  @override
  State<MemoryMatchScreen> createState() => _MemoryMatchScreenState();
}

class _MemoryMatchScreenState extends State<MemoryMatchScreen> {
  static const _difficulty = PuzzleGamesData.defaultDifficulty;

  MemoryThemeId _theme = MemoryThemeId.animals;
  List<_MemoryCard> _cards = [];
  int? _firstIndex;
  int? _secondIndex;
  bool _busy = false;
  bool _playing = false;
  bool _won = false;
  int _moves = 0;
  int _matches = 0;
  /// One light color for all cards this round; rotates within the selected theme.
  Color _boardCardColor = AppColors.habitsHygiene;
  Color _playSessionChrome = AppColors.habitsHygiene;
  int? _lastBoardColorVariant;

  Color get _themeAccent => PuzzleGameColors.memoryThemeAccent(_theme);
  Color get _themeWash => PuzzleGameColors.memoryThemeWash(_theme);
  Color get _shellAccent => _playing ? _playSessionChrome : _themeAccent;

  int get _pairTotal => PuzzleGamesData.pairCountFor(_difficulty);

  void _pickNewBoardColor(Random rng) {
    const variants = 8;
    var idx = rng.nextInt(variants);
    if (_lastBoardColorVariant != null && variants > 1) {
      while (idx == _lastBoardColorVariant) {
        idx = rng.nextInt(variants);
      }
    }
    _lastBoardColorVariant = idx;
    _playSessionChrome = AppColors.puzzlePageAccent(
      gameAccent: _themeAccent,
      itemIndex: idx,
    );
    _boardCardColor = AppColors.memoryLightCardVariant(
      themeAccent: _themeAccent,
      variantIndex: idx,
    );
  }

  @override
  void dispose() {
    AppSpeech.stop();
    super.dispose();
  }

  void _startGame() {
    AppHapticFeedback.medium();
    final faces = PuzzleGamesData.memoryFaces(
      theme: _theme,
      difficulty: _difficulty,
    );
    final deck = <_MemoryCard>[];
    for (final face in faces) {
      deck.add(
        _MemoryCard(
          pairId: face.pairId,
          emoji: face.emoji,
          labelKey: face.labelKey,
        ),
      );
      deck.add(
        _MemoryCard(
          pairId: face.pairId,
          emoji: face.emoji,
          labelKey: face.labelKey,
        ),
      );
    }
    final rng = Random();
    deck.shuffle(rng);
    _pickNewBoardColor(rng);

    setState(() {
      _cards = deck;
      _firstIndex = null;
      _secondIndex = null;
      _busy = false;
      _playing = true;
      _won = false;
      _moves = 0;
      _matches = 0;
    });

    AppSpeech.speak(context, 'puzzleGames.memory.startSpeak'.tr());
  }

  Future<void> _onCardTap(int index) async {
    if (!_playing || _busy || _won) return;
    final card = _cards[index];
    if (card.faceUp || card.matched) return;
    if (_firstIndex != null && _secondIndex != null) return;

    AppHapticFeedback.light();
    setState(() => card.faceUp = true);
    final flippedLabel = card.labelKey?.tr();
    final speakFlip = (flippedLabel != null && flippedLabel.isNotEmpty)
        ? AppSpeech.speak(context, flippedLabel)
        : Future<void>.value();

    if (_firstIndex == null) {
      setState(() => _firstIndex = index);
      await speakFlip;
      return;
    }

    if (_firstIndex == index) return;

    setState(() {
      _secondIndex = index;
      _busy = true;
      _moves += 1;
    });

    final first = _cards[_firstIndex!];
    final second = _cards[index];

    // Let kids see both cards and hear the second name fully.
    await Future.wait<void>([
      speakFlip,
      Future<void>.delayed(const Duration(milliseconds: 520)),
    ]);
    if (!mounted) return;

    if (first.pairId == second.pairId) {
      setState(() {
        first.matched = true;
        second.matched = true;
        _matches += 1;
        _firstIndex = null;
        _secondIndex = null;
        _busy = false;
      });
      AppHapticFeedback.success();
      final label = first.labelKey?.tr() ?? first.emoji;
      await AppSpeech.speak(
        context,
        'puzzleGames.memory.matchSpeak'.tr(namedArgs: {'name': label}),
      );

      if (_matches >= _pairTotal) {
        await Future<void>.delayed(const Duration(milliseconds: 350));
        if (!mounted) return;
        setState(() => _won = true);
        AppHapticFeedback.heavy();
        await AppSpeech.speak(context, 'puzzleGames.winSpeak'.tr());
      }
    } else {
      AppHapticFeedback.error();
      setState(() {
        first.faceUp = false;
        second.faceUp = false;
        _firstIndex = null;
        _secondIndex = null;
        _busy = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;

    return PuzzleModuleScaffold(
      title: 'puzzleGames.memory.title'.tr(),
      themeAccent: _shellAccent,
      sessionChrome: _playing,
      actions: [
        if (_playing)
          IconButton(
            tooltip: 'puzzleGames.restart'.tr(),
            onPressed: _startGame,
            icon: const Icon(Icons.refresh_rounded),
            color: PuzzleGameColors.playAppBarForeground(_playSessionChrome),
          ),
      ],
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(pad, 12, pad, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!_playing) _buildSetup() else ...[
                  PuzzleHudBar(
                    stars: _matches,
                    maxStars: _pairTotal,
                    trailingLabel: 'puzzleGames.memory.moves'.tr(
                      namedArgs: {'count': '$_moves'},
                    ),
                    accent: _playSessionChrome,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'puzzleGames.memory.playHint'.tr(),
                    style: PuzzlePlayUi.bodyStyle(size: 14),
                  ),
                  const SizedBox(height: 14),
                  _buildBoard(),
                ],
              ],
            ),
          ),
          if (_won)
            PuzzleWinOverlay(
              title: 'puzzleGames.winTitle'.tr(),
              subtitle: 'puzzleGames.memory.winSubtitle'.tr(
                namedArgs: {
                  'matches': '$_matches',
                  'moves': '$_moves',
                },
              ),
              primaryLabel: 'puzzleGames.playAgain'.tr(),
              secondaryLabel: 'puzzleGames.backToGames'.tr(),
              accent: _playSessionChrome,
              onPrimary: () {
                setState(() => _won = false);
                _startGame();
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

  Widget _buildSetup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PuzzleSetupIntro(
          emoji: '🎴',
          title: 'puzzleGames.memory.setupTitle'.tr(),
          subtitle: 'puzzleGames.memory.setupSubtitle'.tr(),
          hint: 'puzzleGames.memory.playHint'.tr(),
          accent: _themeAccent,
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color: _themeAccent.withValues(alpha: 0.22),
              width: 1.6,
            ),
            boxShadow: [
              BoxShadow(
                color: _themeAccent.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _themeAccent.withValues(alpha: 0.22),
                          _themeAccent.withValues(alpha: 0.08),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('🎨', style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'puzzleGames.memory.pickTheme'.tr(),
                          style: PuzzlePlayUi.titleStyle(size: 18),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'puzzleGames.memory.playHint'.tr(),
                          style: PuzzlePlayUi.bodyStyle(size: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: PuzzleGamesData.memoryThemes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.98,
                ),
                itemBuilder: (context, index) {
                  final theme = PuzzleGamesData.memoryThemes[index];
                  return PuzzleThemeTile(
                    emoji: theme.emoji,
                    label: theme.titleKey.tr(),
                    selected: _theme == theme.id,
                    accent: PuzzleGameColors.memoryThemeAccent(theme.id),
                    onTap: () => setState(() => _theme = theme.id),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        PuzzlePrimaryButton(
          label: 'puzzleGames.start'.tr(),
          accent: _themeAccent,
          wash: _themeWash,
          onPressed: _startGame,
        ),
      ],
    );
  }

  Widget _buildBoard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.puzzleBoard,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: _boardCardColor.withValues(alpha: 0.28),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: _boardCardColor.withValues(alpha: 0.12),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _cards.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.72,
        ),
        itemBuilder: (context, index) {
          final card = _cards[index];
          return PuzzleFlipCard(
            faceUp: card.faceUp || card.matched,
            matched: card.matched,
            emoji: card.emoji,
            accent: _boardCardColor,
            locked: _busy,
            onTap: () => _onCardTap(index),
          );
        },
      ),
    );
  }
}
