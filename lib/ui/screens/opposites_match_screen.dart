import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../data/opposites_data.dart';
import '../../data/puzzle_games_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import '../widgets/puzzle_play_ui.dart';

class OppositesMatchScreen extends StatefulWidget {
  const OppositesMatchScreen({super.key});

  @override
  State<OppositesMatchScreen> createState() => _OppositesMatchScreenState();
}

class _OppositesMatchScreenState extends State<OppositesMatchScreen> {
  static final int _pairCount = PuzzleGamesData.oppositesPairCountFor(
    PuzzleGamesData.defaultDifficulty,
  );

  List<OppositePair> _left = [];
  List<OppositePair> _right = [];
  final Set<String> _matchedKeys = {};
  String? _selectedLeftKey;
  String? _selectedRightKey;
  bool _busy = false;
  bool _playing = false;
  bool _won = false;
  int _moves = 0;

  Color _sessionTheme = AppColors.directionsCompass;
  Color _sessionLeft = AppColors.directionsCompass;
  Color _sessionRight = AppColors.habitsClean;
  int? _lastSessionVariant;

  Color get _accent => PuzzleGameColors.accent(PuzzleGameId.oppositesMatch);
  Color get _buttonWash => PuzzleGameColors.wash(PuzzleGameId.oppositesMatch);
  Color get _shellAccent => _playing ? _sessionTheme : _accent;

  String _pairKey(OppositePair p) => '${p.leftKey}|${p.rightKey}';

  void _pickSessionTheme(Random rng) {
    const variants = 8;
    var v = rng.nextInt(variants);
    if (_lastSessionVariant != null && variants > 1) {
      while (v == _lastSessionVariant) {
        v = rng.nextInt(variants);
      }
    }
    _lastSessionVariant = v;
    _sessionTheme = AppColors.puzzlePageAccent(
      gameAccent: _accent,
      itemIndex: v,
    );
    _sessionLeft = Color.lerp(_sessionTheme, _accent, 0.18)!;
    _sessionRight = AppColors.puzzlePageAccent(
      gameAccent: PuzzleGameColors.wash(PuzzleGameId.oppositesMatch),
      itemIndex: (v + 3) % variants,
    );
  }

  @override
  void dispose() {
    AppSpeech.stop();
    super.dispose();
  }

  void _startGame() {
    AppHapticFeedback.medium();
    final board = PuzzleGamesData.oppositesBoard(pairCount: _pairCount);
    final rng = Random();
    _pickSessionTheme(rng);
    setState(() {
      _left = board.left;
      _right = board.rightShuffled;
      _matchedKeys.clear();
      _selectedLeftKey = null;
      _selectedRightKey = null;
      _busy = false;
      _playing = true;
      _won = false;
      _moves = 0;
    });
    AppSpeech.speak(context, 'puzzleGames.opposites.startSpeak'.tr());
  }

  Future<void> _selectLeft(OppositePair pair) async {
    if (!_playing || _busy || _won) return;
    final key = _pairKey(pair);
    if (_matchedKeys.contains(key)) return;
    AppHapticFeedback.light();
    setState(() => _selectedLeftKey = key);
    await AppSpeech.speak(context, pair.leftKey.tr());
    if (!mounted) return;
    await _tryMatch();
  }

  Future<void> _selectRight(OppositePair pair) async {
    if (!_playing || _busy || _won) return;
    final key = _pairKey(pair);
    if (_matchedKeys.contains(key)) return;
    AppHapticFeedback.light();
    setState(() => _selectedRightKey = key);
    await AppSpeech.speak(context, pair.rightKey.tr());
    if (!mounted) return;
    await _tryMatch();
  }

  Future<void> _tryMatch() async {
    final leftKey = _selectedLeftKey;
    final rightKey = _selectedRightKey;
    if (leftKey == null || rightKey == null) return;

    setState(() {
      _busy = true;
      _moves += 1;
    });

    await Future<void>.delayed(const Duration(milliseconds: 280));
    if (!mounted) return;

    if (leftKey == rightKey) {
      setState(() {
        _matchedKeys.add(leftKey);
        _selectedLeftKey = null;
        _selectedRightKey = null;
        _busy = false;
      });
      AppHapticFeedback.success();
      // Cards already spoke their word on tap — no "X and Y are opposites" line.

      if (_matchedKeys.length >= _pairCount) {
        await Future<void>.delayed(const Duration(milliseconds: 400));
        if (!mounted) return;
        setState(() => _won = true);
        AppHapticFeedback.heavy();
        await AppSpeech.speak(context, 'puzzleGames.winSpeak'.tr());
      }
    } else {
      AppHapticFeedback.error();
      setState(() {
        _selectedLeftKey = null;
        _selectedRightKey = null;
        _busy = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;

    return PuzzleModuleScaffold(
      title: 'puzzleGames.opposites.title'.tr(),
      themeAccent: _shellAccent,
      sessionChrome: _playing,
      actions: [
        if (_playing)
          IconButton(
            tooltip: 'puzzleGames.restart'.tr(),
            onPressed: _startGame,
            icon: const Icon(Icons.refresh_rounded),
            color: PuzzleGameColors.playAppBarForeground(_sessionTheme),
          ),
      ],
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(pad, 12, pad, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!_playing) _buildSetup() else _buildPlay(),
              ],
            ),
          ),
          if (_won)
            PuzzleWinOverlay(
              title: 'puzzleGames.winTitle'.tr(),
              subtitle: 'puzzleGames.opposites.winSubtitle'.tr(
                namedArgs: {'moves': '$_moves'},
              ),
              primaryLabel: 'puzzleGames.playAgain'.tr(),
              secondaryLabel: 'puzzleGames.backToGames'.tr(),
              accent: _sessionTheme,
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
          emoji: '⚖️',
          title: 'puzzleGames.opposites.setupTitle'.tr(),
          subtitle: 'puzzleGames.opposites.setupSubtitle'.tr(),
          hint: 'puzzleGames.opposites.playHint'.tr(),
          accent: _accent,
        ),
        const SizedBox(height: 18),
        Text(
          'puzzleGames.opposites.howTitle'.tr(),
          style: PuzzlePlayUi.titleStyle(size: 18),
        ),
        const SizedBox(height: 10),
        PuzzleHowStep(
          step: 1,
          emoji: '👈',
          text: 'puzzleGames.opposites.howStep1'.tr(),
          accent: PuzzleGameColors.step(_accent, 0),
        ),
        PuzzleHowStep(
          step: 2,
          emoji: '👉',
          text: 'puzzleGames.opposites.howStep2'.tr(),
          accent: PuzzleGameColors.step(_accent, 1),
        ),
        PuzzleHowStep(
          step: 3,
          emoji: '⭐',
          text: 'puzzleGames.opposites.howStep3'.tr(),
          accent: PuzzleGameColors.step(_accent, 2),
        ),
        const SizedBox(height: 20),
        PuzzlePrimaryButton(
          label: 'puzzleGames.start'.tr(),
          accent: _accent,
          wash: _buttonWash,
          onPressed: _startGame,
        ),
      ],
    );
  }

  Widget _buildPlay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PuzzleHudBar(
          stars: _matchedKeys.length,
          maxStars: _pairCount,
          trailingLabel: 'puzzleGames.opposites.moves'.tr(
            namedArgs: {'count': '$_moves'},
          ),
          accent: _sessionTheme,
        ),
        const SizedBox(height: 10),
        Text(
          'puzzleGames.opposites.playHint'.tr(),
          style: PuzzlePlayUi.bodyStyle(size: 14),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
          decoration: BoxDecoration(
            color: AppColors.puzzleBoard,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: _sessionTheme.withValues(alpha: 0.30),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: _sessionTheme.withValues(alpha: 0.14),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _ColumnLabel(
                      text: 'puzzleGames.opposites.leftLabel'.tr(),
                      color: _sessionLeft,
                    ),
                    const SizedBox(height: 8),
                    ..._left.asMap().entries.map((entry) {
                      final pair = entry.value;
                      final key = _pairKey(pair);
                      final matched = _matchedKeys.contains(key);
                      final rowAccent =
                          PuzzleGameColors.itemAccent(_sessionLeft, entry.key);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: PuzzleConnectTile(
                          emoji: pair.leftEmoji,
                          label: pair.leftKey.tr(),
                          selected: _selectedLeftKey == key,
                          matched: matched,
                          accent: rowAccent,
                          verticalLayout: true,
                          dimmed: _selectedLeftKey != null &&
                              _selectedLeftKey != key,
                          onTap: () => _selectLeft(pair),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 52, 4, 0),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _sessionTheme.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.swap_horiz_rounded,
                    color: _sessionTheme,
                    size: 22,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    _ColumnLabel(
                      text: 'puzzleGames.opposites.rightLabel'.tr(),
                      color: _sessionRight,
                    ),
                    const SizedBox(height: 8),
                    ..._right.asMap().entries.map((entry) {
                      final pair = entry.value;
                      final key = _pairKey(pair);
                      final matched = _matchedKeys.contains(key);
                      final rowAccent =
                          PuzzleGameColors.itemAccent(_sessionRight, entry.key);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: PuzzleConnectTile(
                          emoji: pair.rightEmoji,
                          label: pair.rightKey.tr(),
                          selected: _selectedRightKey == key,
                          matched: matched,
                          accent: rowAccent,
                          verticalLayout: true,
                          dimmed: _selectedRightKey != null &&
                              _selectedRightKey != key,
                          onTap: () => _selectRight(pair),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ColumnLabel extends StatelessWidget {
  final String text;
  final Color color;

  const _ColumnLabel({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        color: Color.lerp(Colors.white, color, 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.22)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: PuzzlePlayUi.bodyStyle(
          size: 13,
          color: color,
          weight: FontWeight.w700,
        ),
      ),
    );
  }
}
