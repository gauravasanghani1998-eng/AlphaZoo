import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../data/puzzle_games_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import '../widgets/puzzle_play_ui.dart';

class SortBoxesScreen extends StatefulWidget {
  const SortBoxesScreen({super.key});

  @override
  State<SortBoxesScreen> createState() => _SortBoxesScreenState();
}

class _SortBoxesScreenState extends State<SortBoxesScreen> {
  Color get _accent => PuzzleGameColors.accent(PuzzleGameId.sortBoxes);

  SortModeInfo _mode = PuzzleGamesData.sortModes.first;
  List<PuzzleContentItem> _items = [];
  final Set<String> _sortedIds = {};
  String? _selectedId;
  bool _playing = false;
  bool _won = false;
  Color _sessionChrome = AppColors.habitsHygiene;
  int? _lastSessionVariant;

  int get _modeIndex {
    final i = PuzzleGamesData.sortModes.indexWhere((m) => m.id == _mode.id);
    return i < 0 ? 0 : i;
  }

  Color get _setupChrome => AppColors.puzzlePageAccent(
        gameAccent: _accent,
        itemIndex: _modeIndex,
      );

  Color get _playAccent => _sessionChrome;

  Color get _shellChrome => _playing ? _playAccent : _setupChrome;

  void _pickSessionChrome() {
    const variants = 8;
    final rng = Random();
    var idx = rng.nextInt(variants);
    if (_lastSessionVariant != null && variants > 1) {
      while (idx == _lastSessionVariant) {
        idx = rng.nextInt(variants);
      }
    }
    _lastSessionVariant = idx;
    _sessionChrome = AppColors.puzzlePageAccent(
      gameAccent: _accent,
      itemIndex: _modeIndex * 2 + idx,
    );
  }

  @override
  void dispose() {
    AppSpeech.stop();
    super.dispose();
  }

  void _start() {
    AppHapticFeedback.medium();
    _pickSessionChrome();
    setState(() {
      _items = PuzzleGamesData.sortItemsFor(mode: _mode);
      _sortedIds.clear();
      _selectedId = null;
      _playing = true;
      _won = false;
    });
    AppSpeech.speak(context, 'puzzleGames.sortBoxes.startSpeak'.tr());
  }

  Future<void> _tapItem(PuzzleContentItem item) async {
    if (!_playing || _won || _sortedIds.contains(item.id)) return;
    AppHapticFeedback.light();
    setState(() => _selectedId = item.id);
    await AppSpeech.speak(context, item.nameKey.tr());
  }

  Future<void> _tapBox(String group) async {
    if (!_playing || _won || _selectedId == null) return;
    final item = _items.firstWhere((e) => e.id == _selectedId);
    final correct = item.group == group;
    if (correct) {
      AppHapticFeedback.success();
      setState(() {
        _sortedIds.add(item.id);
        _selectedId = null;
      });
      if (_sortedIds.length >= _items.length) {
        await Future<void>.delayed(const Duration(milliseconds: 350));
        if (!mounted) return;
        setState(() => _won = true);
        AppHapticFeedback.heavy();
        await AppSpeech.speak(context, 'puzzleGames.winSpeak'.tr());
      }
    } else {
      AppHapticFeedback.error();
      // Full name first, then feedback — never cut mid-word.
      await AppSpeech.speakSequence(context, [
        item.nameKey.tr(),
        'puzzleGames.tryAgain'.tr(),
      ]);
      if (!mounted) return;
      setState(() => _selectedId = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pad = context.responsive.horizontalPadding;

    return PuzzleModuleScaffold(
      title: 'puzzleGames.sortBoxes.title'.tr(),
      themeAccent: _shellChrome,
      sessionChrome: true,
      child: Stack(
        fit: StackFit.expand,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(pad, 12, pad, 28),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: !_playing ? _setup() : _play(),
                ),
              );
            },
          ),
          if (_won)
            PuzzleWinOverlay(
              title: 'puzzleGames.winTitle'.tr(),
              subtitle: 'puzzleGames.sortBoxes.winSubtitle'.tr(
                namedArgs: {'count': '${_items.length}'},
              ),
              primaryLabel: 'puzzleGames.playAgain'.tr(),
              secondaryLabel: 'puzzleGames.backToGames'.tr(),
              accent: _playAccent,
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
    final chrome = _setupChrome;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PuzzleSetupIntro(
          emoji: '📦',
          title: 'puzzleGames.sortBoxes.setupTitle'.tr(),
          subtitle: 'puzzleGames.sortBoxes.setupSubtitle'.tr(),
          hint: 'puzzleGames.sortBoxes.playHint'.tr(),
          accent: chrome,
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Container(
              width: 5,
              height: 22,
              decoration: BoxDecoration(
                color: chrome,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'puzzleGames.sortBoxes.pickMode'.tr(),
                style: PuzzlePlayUi.titleStyle(
                  size: 18,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.05,
          children: PuzzleGamesData.sortModes.asMap().entries.map((entry) {
            final mode = entry.value;
            final modeIndex = entry.key;
            final selected = _mode.id == mode.id;
            final color = PuzzleGameColors.itemAccent(_accent, modeIndex);
            return GestureDetector(
              onTap: () {
                AppHapticFeedback.light();
                setState(() => _mode = mode);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: selected
                      ? Color.lerp(AppColors.white, color, 0.18)
                      : AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: selected ? color : color.withValues(alpha: 0.25),
                    width: selected ? 2.6 : 1.6,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (selected ? color : Colors.black)
                          .withValues(alpha: selected ? 0.18 : 0.05),
                      blurRadius: selected ? 12 : 6,
                      offset: Offset(0, selected ? 5 : 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(mode.emoji, style: const TextStyle(fontSize: 36)),
                    const SizedBox(height: 8),
                    Text(
                      mode.titleKey.tr(),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: PuzzlePlayUi.titleStyle(
                        size: 14,
                        color: selected ? color : AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 14),
        PuzzleHowStep(
          step: 1,
          emoji: '👆',
          text: 'puzzleGames.sortBoxes.howStep1'.tr(),
          accent: PuzzleGameColors.step(chrome, 0),
        ),
        PuzzleHowStep(
          step: 2,
          emoji: '📦',
          text: 'puzzleGames.sortBoxes.howStep2'.tr(),
          accent: PuzzleGameColors.step(chrome, 1),
        ),
        PuzzleHowStep(
          step: 3,
          emoji: '⭐',
          text: 'puzzleGames.sortBoxes.howStep3'.tr(),
          accent: PuzzleGameColors.step(chrome, 2),
        ),
        const SizedBox(height: 18),
        PuzzlePrimaryButton(
          label: 'puzzleGames.start'.tr(),
          accent: chrome,
          wash: PuzzleGameColors.wash(PuzzleGameId.sortBoxes),
          onPressed: _start,
        ),
      ],
    );
  }

  Widget _play() {
    final pending =
        _items.where((e) => !_sortedIds.contains(e.id)).toList();
    final roundAccent = _playAccent;
    final leftColor = PuzzleGameColors.pairLeft(roundAccent);
    final rightColor = PuzzleGameColors.pairRight(PuzzleGameId.sortBoxes);
    final hasPick = _selectedId != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PuzzleHudBar(
          stars: _sortedIds.length,
          maxStars: _items.length,
          trailingLabel: 'puzzleGames.sortBoxes.progress'.tr(
            namedArgs: {
              'done': '${_sortedIds.length}',
              'total': '${_items.length}',
            },
          ),
          accent: roundAccent,
          surfaceColor: PuzzleGameColors.puzzleHudSurface(roundAccent),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: roundAccent.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: roundAccent.withValues(alpha: 0.45)),
          ),
          child: Row(
            children: [
              Text(_mode.emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _mode.titleKey.tr(),
                  style: PuzzlePlayUi.titleStyle(size: 15, color: roundAccent),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'puzzleGames.sortBoxes.playHint'.tr(),
          style: PuzzlePlayUi.bodyStyle(
            size: 15,
            weight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'puzzleGames.sortBoxes.itemsLabel'.tr(),
          style: PuzzlePlayUi.titleStyle(size: 17, color: roundAccent),
        ),
        const SizedBox(height: 10),
        if (pending.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Text(
                '✨',
                style: const TextStyle(fontSize: 48),
              ),
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pending.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.92,
            ),
            itemBuilder: (context, index) {
              final item = pending[index];
              final chipAccent =
                  PuzzleGameColors.itemAccent(roundAccent, index);
              final selected = _selectedId == item.id;
              final tileFill = Color.lerp(chipAccent, AppColors.white, 0.38)!;
              return GestureDetector(
                onTap: () => _tapItem(item),
                child: AnimatedScale(
                  scale: selected ? 1.06 : 1,
                  duration: const Duration(milliseconds: 180),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          tileFill,
                          Color.lerp(chipAccent, AppColors.white, 0.62)!,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: selected
                            ? roundAccent
                            : chipAccent.withValues(alpha: 0.55),
                        width: selected ? 3 : 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: chipAccent.withValues(
                            alpha: selected ? 0.35 : 0.22,
                          ),
                          blurRadius: selected ? 12 : 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item.emoji,
                      style: TextStyle(
                        fontSize: selected ? 34 : 30,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        const SizedBox(height: 18),
        Text(
          'puzzleGames.sortBoxes.howStep2'.tr(),
          style: PuzzlePlayUi.bodyStyle(
            size: 14,
            weight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _SortBox(
                label: _mode.leftBoxKey.tr(),
                color: leftColor,
                active: hasPick,
                onTap: () => _tapBox(_mode.leftGroup),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SortBox(
                label: _mode.rightBoxKey.tr(),
                color: rightColor,
                active: hasPick,
                onTap: () => _tapBox(_mode.rightGroup),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SortBox extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  final bool active;

  const _SortBox({
    required this.label,
    required this.color,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: active ? 128 : 118,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              color.withValues(alpha: active ? 0.55 : 0.42),
              color.withValues(alpha: active ? 0.28 : 0.18),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: active ? AppColors.white : color.withValues(alpha: 0.65),
            width: active ? 3 : 2.2,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: active ? 0.45 : 0.28),
              blurRadius: active ? 16 : 10,
              offset: Offset(0, active ? 6 : 4),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: PuzzlePlayUi.titleStyle(
              size: 17,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
