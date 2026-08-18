import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/puzzle_games_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import '../widgets/puzzle_play_ui.dart';
import 'listen_find_screen.dart';
import 'memory_match_screen.dart';
import 'odd_one_out_screen.dart';
import 'opposites_match_screen.dart';
import 'picture_word_screen.dart';
import 'sort_boxes_screen.dart';

class PuzzleGamesScreen extends StatefulWidget {
  const PuzzleGamesScreen({super.key});

  @override
  State<PuzzleGamesScreen> createState() => _PuzzleGamesScreenState();
}

class _PuzzleGamesScreenState extends State<PuzzleGamesScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _enter;

  @override
  void initState() {
    super.initState();
    _enter = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
  }

  @override
  void dispose() {
    _enter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final top = responsive.verticalPadding;

    return PuzzleModuleScaffold(
      title: 'puzzleGames.title'.tr(),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(pad, top, pad, top + 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeTransition(
              opacity: CurvedAnimation(
                parent: _enter,
                curve: const Interval(0, 0.55, curve: Curves.easeOut),
              ),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.08),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _enter,
                    curve: const Interval(0, 0.55, curve: Curves.easeOut),
                  ),
                ),
                child: PuzzleHeroBanner(
                  title: 'puzzleGames.header'.tr(),
                  subtitle: 'puzzleGames.description'.tr(),
                ),
              ),
            ),
            const SizedBox(height: 22),
            FadeTransition(
              opacity: CurvedAnimation(
                parent: _enter,
                curve: const Interval(0.25, 0.7, curve: Curves.easeOut),
              ),
              child: Row(
                children: [
                  const Text('🧩', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'puzzleGames.pickGame'.tr(),
                        maxLines: 1,
                        style: PuzzlePlayUi.titleStyle(size: 19),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            ...List.generate(PuzzleGamesData.games.length, (index) {
              final game = PuzzleGamesData.games[index];
              final start = (0.28 + index * 0.08).clamp(0.0, 0.85);
              final end = (start + 0.4).clamp(0.0, 1.0);
              final accent = PuzzleGameColors.accent(game.id);
              final wash = PuzzleGameColors.wash(game.id);
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index < PuzzleGamesData.games.length - 1 ? 14 : 0,
                ),
                child: FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _enter,
                    curve: Interval(start, end, curve: Curves.easeOut),
                  ),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.1),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _enter,
                        curve: Interval(start, end, curve: Curves.easeOutCubic),
                      ),
                    ),
                    child: PuzzleGameEntryCard(
                      emoji: game.emoji,
                      title: game.titleKey.tr(),
                      subtitle: game.subtitleKey.tr(),
                      badge: game.badgeKey.tr(),
                      accent: accent,
                      wash: wash,
                      onTap: () => _openGame(context, game.id),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _openGame(BuildContext context, PuzzleGameId id) {
    AppHapticFeedback.medium();
    AppSpeech.stop();
    final Widget screen = switch (id) {
      PuzzleGameId.memoryMatch => const MemoryMatchScreen(),
      PuzzleGameId.oppositesMatch => const OppositesMatchScreen(),
      PuzzleGameId.pictureWord => const PictureWordScreen(),
      PuzzleGameId.listenFind => const ListenFindScreen(),
      PuzzleGameId.sortBoxes => const SortBoxesScreen(),
      PuzzleGameId.oddOneOut => const OddOneOutScreen(),
    };
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (_, __, ___) => screen,
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 360),
      ),
    );
  }
}
