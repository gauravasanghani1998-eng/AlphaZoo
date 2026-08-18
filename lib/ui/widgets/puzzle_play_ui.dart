import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_colors.dart';
import '../../data/puzzle_games_data.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';

/// One theme per game (like Good Habits categories) — hub → setup → play.
class PuzzleGameColors {
  PuzzleGameColors._();

  static int _indexOf(PuzzleGameId id) {
    final i = PuzzleGamesData.games.indexWhere((g) => g.id == id);
    return i < 0 ? 0 : i;
  }

  /// Main theme color for this game.
  static Color accent(PuzzleGameId id) =>
      AppColors.getPuzzleGameColor(_indexOf(id));

  /// Soft wash — companion color from the same game family.
  static Color wash(PuzzleGameId id) =>
      AppColors.getPuzzleGameWash(_indexOf(id));

  static Color softBg(Color theme) =>
      Color.lerp(AppColors.puzzleHubBg, theme, 0.08)!;

  static Color appBar(Color theme) =>
      Color.lerp(AppColors.puzzleHubAppBar, theme, 0.12)!;

  /// Per step / theme tile / list row — varied like Good Habits habit rows.
  static Color itemAccent(Color gameTheme, int itemIndex) =>
      AppColors.puzzlePageAccent(
        gameAccent: gameTheme,
        itemIndex: itemIndex,
      );

  static Color step(Color theme, int index) => itemAccent(theme, index);

  static Color deep(Color theme) => AppColors.puzzleDeepAccent(theme);

  static Color pairLeft(Color theme) => theme;

  /// Second column / box — sibling wash, not app-wide pink.
  static Color pairRight(PuzzleGameId id) => wash(id);

  /// Same accent as the theme picker tile (Animals, Fruits, …).
  static Color memoryThemeAccent(MemoryThemeId themeId) {
    final idx = PuzzleGamesData.memoryThemes.indexWhere((t) => t.id == themeId);
    final base = accent(PuzzleGameId.memoryMatch);
    return itemAccent(base, idx < 0 ? 0 : idx);
  }

  static Color memoryThemeWash(MemoryThemeId themeId) {
    return Color.lerp(memoryThemeAccent(themeId), AppColors.white, 0.22)!;
  }

  /// Stronger tints for app bar + page (Good Habits category screen).
  /// App bar is richer than [playScaffoldBackground] / [playArenaBackground].
  static Color playAppBarBackground(Color sessionAccent) {
    final tinted = Color.lerp(AppColors.white, sessionAccent, 0.48)!;
    return Color.lerp(tinted, AppColors.puzzleDeepAccent(sessionAccent), 0.10)!;
  }

  static Color playScaffoldBackground(Color sessionAccent) {
    return Color.lerp(AppColors.puzzleHubBg, sessionAccent, 0.10)!;
  }

  static Color playArenaBackground(Color sessionAccent) {
    return Color.lerp(AppColors.puzzleHubBg, sessionAccent, 0.18)!;
  }

  /// Title / icons on session app bar — readable on tinted header.
  static Color playAppBarForeground(Color sessionAccent) {
    return Color.lerp(sessionAccent, const Color(0xFF1A1A1A), 0.82)!;
  }

  static BoxDecoration puzzleNavBarDecoration(Color sessionAccent) {
    final bg = playArenaBackground(sessionAccent);
    return BoxDecoration(
      color: bg,
      border: Border(
        top: BorderSide(color: sessionAccent.withValues(alpha: 0.22)),
      ),
    );
  }

  static Color puzzleHudSurface(Color sessionAccent) {
    // Keep a light theme hint without washing out stars / round chip.
    return Color.lerp(sessionAccent, AppColors.white, 0.90)!;
  }
}

/// Shared puzzle UI — uses AppColors primary / letter palette.
class PuzzlePlayUi {
  PuzzlePlayUi._();

  static TextStyle titleStyle({
    double size = 26,
    Color color = AppColors.textPrimary,
    FontWeight weight = FontWeight.w700,
  }) {
    return GoogleFonts.fredoka(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: 1.15,
    );
  }

  static TextStyle bodyStyle({
    double size = 15,
    Color color = AppColors.textSecondary,
    FontWeight weight = FontWeight.w500,
  }) {
    return GoogleFonts.baloo2(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: 1.3,
    );
  }
}

/// Soft playground with static decor blobs (tinted by game theme when set).
class PuzzleArenaBackground extends StatelessWidget {
  final Widget child;
  final Color? themeAccent;
  final bool sessionChrome;

  const PuzzleArenaBackground({
    super.key,
    required this.child,
    this.themeAccent,
    this.sessionChrome = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = themeAccent;
    final bg = theme == null
        ? AppColors.puzzleHubBg
        : sessionChrome
            ? PuzzleGameColors.playArenaBackground(theme)
            : PuzzleGameColors.softBg(theme);
    final orbA = theme ?? AppColors.habitsHygiene;
    final orbB = theme == null
        ? AppColors.habitsClean.withValues(alpha: 1)
        : Color.lerp(theme, AppColors.white, 0.35)!;
    final orbC = theme == null
        ? AppColors.habitsManners.withValues(alpha: 1)
        : Color.lerp(theme, AppColors.primary, 0.45)!;
    final orbAlpha = sessionChrome ? 0.22 : 0.14;

    return Stack(
      children: [
        Positioned.fill(child: ColoredBox(color: bg)),
        Positioned(
          top: 28,
          right: -36,
          child: _Orb(color: orbA.withValues(alpha: orbAlpha), size: 130),
        ),
        Positioned(
          top: 170,
          left: -44,
          child: _Orb(
            color: orbB.withValues(alpha: sessionChrome ? 0.24 : 0.16),
            size: 110,
          ),
        ),
        Positioned(
          bottom: 100,
          right: 12,
          child: _Orb(
            color: orbC.withValues(alpha: sessionChrome ? 0.16 : 0.10),
            size: 88,
          ),
        ),
        child,
      ],
    );
  }
}

class _Orb extends StatelessWidget {
  final Color color;
  final double size;

  const _Orb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class PuzzleModuleScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;
  final Color? appBarColor;

  /// When set (game screens), bg / app bar / chrome match this theme —
  /// same pattern as Good Habits category → detail.
  final Color? themeAccent;

  /// Play round: stronger header + background (visible theme swap on restart).
  final bool sessionChrome;

  /// Body stays neutral (hub cream); only app bar uses [themeAccent] strongly.
  final bool neutralPlayBody;

  const PuzzleModuleScaffold({
    super.key,
    required this.title,
    required this.child,
    this.actions,
    this.appBarColor,
    this.themeAccent,
    this.sessionChrome = false,
    this.neutralPlayBody = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = themeAccent;
    final chrome = theme ?? AppColors.habitsHygiene;
    final vivid = sessionChrome && theme != null && !neutralPlayBody;
    final strongBar = theme != null &&
        (vivid || neutralPlayBody || appBarColor != null);
    final bar = appBarColor ??
        (theme == null
            ? AppColors.puzzleHubAppBar
            : strongBar && (sessionChrome || neutralPlayBody)
                ? PuzzleGameColors.playAppBarBackground(theme)
                : PuzzleGameColors.appBar(theme));
    final barForeground = vivid
        ? PuzzleGameColors.playAppBarForeground(chrome)
        : chrome;
    final scaffoldBg = neutralPlayBody
        ? AppColors.puzzleHubBg
        : theme == null
            ? AppColors.puzzleHubBg
            : vivid
                ? PuzzleGameColors.playScaffoldBackground(theme)
                : Color.lerp(AppColors.white, theme, 0.06)!;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: bar.withValues(alpha: 0.98),
        elevation: vivid ? 4 : 2,
        shadowColor: chrome.withValues(alpha: vivid ? 0.28 : 0.12),
        surfaceTintColor: Colors.transparent,
        bottom: vivid
            ? PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Container(
                  height: 1,
                  color: barForeground.withValues(alpha: 0.18),
                ),
              )
            : null,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: barForeground,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          style: PuzzlePlayUi.titleStyle(
            size: 20,
            color: barForeground,
            weight: FontWeight.w500,
          ),
        ),
        actions: actions,
        iconTheme: IconThemeData(color: barForeground),
      ),
      body: PuzzleArenaBackground(
        themeAccent: neutralPlayBody ? null : theme,
        sessionChrome: vivid,
        child: SafeArea(child: child),
      ),
    );
  }
}

/// Soft pastel hero (static — no bounce).
class PuzzleHeroBanner extends StatelessWidget {
  final String title;
  final String subtitle;

  const PuzzleHeroBanner({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 16, 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.habitsHygiene,
            AppColors.primary,
            AppColors.habitsClean,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.habitsHygiene.withValues(alpha: 0.28),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.28),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'puzzleGames.heroChip'.tr(),
                    style: PuzzlePlayUi.bodyStyle(
                      size: 12,
                      color: AppColors.white,
                      weight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  title,
                  style: PuzzlePlayUi.titleStyle(
                    size: 26,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: PuzzlePlayUi.bodyStyle(
                    size: 14,
                    color: AppColors.white.withValues(alpha: 0.95),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: AppColors.white.withValues(alpha: 0.45),
                width: 2,
              ),
            ),
            alignment: Alignment.center,
            child: const Text('🧩', style: TextStyle(fontSize: 36)),
          ),
        ],
      ),
    );
  }
}

/// Game pick card — bright kid colors, candy play button (no dull navy).
class PuzzleGameEntryCard extends StatefulWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final String badge;
  final Color accent;
  final Color wash;
  final VoidCallback onTap;

  const PuzzleGameEntryCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.accent,
    required this.wash,
    required this.onTap,
  });

  @override
  State<PuzzleGameEntryCard> createState() => _PuzzleGameEntryCardState();
}

class _PuzzleGameEntryCardState extends State<PuzzleGameEntryCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final radius = context.responsive.cardRadius + 2;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [
              BoxShadow(
                color: widget.accent.withValues(alpha: 0.14),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(radius),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                AppHapticFeedback.medium();
                widget.onTap();
              },
              splashColor: widget.accent.withValues(alpha: 0.12),
              highlightColor: widget.accent.withValues(alpha: 0.06),
              child: Ink(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(
                    color: widget.accent.withValues(alpha: 0.35),
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              widget.accent.withValues(alpha: 0.22),
                              widget.accent.withValues(alpha: 0.08),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          widget.emoji,
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: widget.accent.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                widget.badge,
                                style: PuzzlePlayUi.bodyStyle(
                                  size: 11,
                                  color: widget.accent,
                                  weight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              widget.title,
                              style: PuzzlePlayUi.titleStyle(size: 19),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.subtitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: PuzzlePlayUi.bodyStyle(size: 13),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(
                                  Icons.play_circle_fill_rounded,
                                  color: widget.accent,
                                  size: 22,
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'puzzleGames.playNow'.tr(),
                                      maxLines: 1,
                                      style: PuzzlePlayUi.bodyStyle(
                                        size: 15,
                                        color: widget.accent,
                                        weight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Soft intro strip for setup screens (Good Habits category intro style).
class PuzzleSetupIntro extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final Color accent;
  final String? hint;

  const PuzzleSetupIntro({
    super.key,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.accent,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accent.withValues(alpha: 0.20),
            accent.withValues(alpha: 0.06),
            AppColors.white,
          ],
        ),
        border: Border.all(color: accent.withValues(alpha: 0.32), width: 2),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.12),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: accent.withValues(alpha: 0.22),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 28)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: PuzzlePlayUi.titleStyle(size: 20)),
                const SizedBox(height: 4),
                Text(subtitle, style: PuzzlePlayUi.bodyStyle(size: 14)),
                if (hint != null && hint!.trim().isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    hint!,
                    style: PuzzlePlayUi.bodyStyle(
                      size: 13,
                      color: accent,
                      weight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PuzzleHowStep extends StatelessWidget {
  final int step;
  final String text;
  final Color accent;
  final String emoji;

  const PuzzleHowStep({
    super.key,
    required this.step,
    required this.text,
    required this.accent,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withValues(alpha: 0.24), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.10),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [accent, accent.withValues(alpha: 0.72)],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Text(
              '$step',
              style: PuzzlePlayUi.bodyStyle(
                size: 16,
                color: Colors.white,
                weight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: PuzzlePlayUi.bodyStyle(
                size: 15,
                color: AppColors.textPrimary,
                weight: FontWeight.w600,
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class PuzzleThemeTile extends StatelessWidget {
  final String emoji;
  final String label;
  final bool selected;
  final Color accent;
  final VoidCallback onTap;

  const PuzzleThemeTile({
    super.key,
    required this.emoji,
    required this.label,
    required this.selected,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final soft = Color.lerp(Colors.white, accent, selected ? 0.14 : 0.06)!;
    final border = selected ? accent : accent.withValues(alpha: 0.28);

    return GestureDetector(
      onTap: () {
        AppHapticFeedback.light();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 14),
        decoration: BoxDecoration(
          color: soft,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: border, width: selected ? 2.6 : 1.8),
          boxShadow: [
            BoxShadow(
              color: selected
                  ? accent.withValues(alpha: 0.24)
                  : accent.withValues(alpha: 0.10),
              blurRadius: selected ? 14 : 8,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    accent.withValues(alpha: 0.28),
                    accent.withValues(alpha: 0.10),
                  ],
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: accent.withValues(alpha: selected ? 0.55 : 0.32),
                  width: 2,
                ),
              ),
              alignment: Alignment.center,
              child: Text(emoji, style: const TextStyle(fontSize: 28)),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: PuzzlePlayUi.bodyStyle(
                size: 14,
                color: selected ? accent : AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            AnimatedOpacity(
              opacity: selected ? 1 : 0,
              duration: const Duration(milliseconds: 160),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [accent, accent.withValues(alpha: 0.78)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '✓',
                  style: PuzzlePlayUi.bodyStyle(
                    size: 11,
                    color: Colors.white,
                    weight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PuzzleHudBar extends StatelessWidget {
  final int stars;
  final int maxStars;
  final String trailingLabel;
  final Color accent;
  final Color? surfaceColor;

  const PuzzleHudBar({
    super.key,
    required this.stars,
    required this.maxStars,
    required this.trailingLabel,
    required this.accent,
    this.surfaceColor,
  });

  @override
  Widget build(BuildContext context) {
    final count = maxStars.clamp(0, 10);
    final surface = surfaceColor ?? Colors.white.withValues(alpha: 0.96);
    final starLit = const Color(0xFFE8A100);
    final starDim = AppColors.textSecondary.withValues(alpha: 0.38);
    final chipBg = Colors.white;
    final chipText = Color.lerp(accent, AppColors.textPrimary, 0.35)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withValues(alpha: 0.32), width: 1.8),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(count, (i) {
                  final lit = i < stars;
                  return Padding(
                    padding: EdgeInsets.only(right: i == count - 1 ? 0 : 2),
                    child: Text(
                      lit ? '⭐' : '☆',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1,
                        color: lit ? starLit : starDim,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Flexible(
            flex: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: chipBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: accent.withValues(alpha: 0.45),
                  width: 1.4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Text(
                trailingLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: PuzzlePlayUi.bodyStyle(
                  size: 13,
                  color: chipText,
                  weight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PuzzleWinOverlay extends StatefulWidget {
  final String title;
  final String subtitle;
  final String primaryLabel;
  final String secondaryLabel;
  final VoidCallback onPrimary;
  final VoidCallback onSecondary;
  final Color accent;

  const PuzzleWinOverlay({
    super.key,
    required this.title,
    required this.subtitle,
    required this.primaryLabel,
    required this.secondaryLabel,
    required this.onPrimary,
    required this.onSecondary,
    required this.accent,
  });

  @override
  State<PuzzleWinOverlay> createState() => _PuzzleWinOverlayState();
}

class _PuzzleWinOverlayState extends State<PuzzleWinOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.45),
      child: Center(
        child: AnimatedBuilder(
          animation: _pulse,
          builder: (context, child) {
            final scale = 1 + (_pulse.value * 0.03);
            return Transform.scale(scale: scale, child: child);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 28),
            padding: const EdgeInsets.fromLTRB(22, 26, 22, 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Color.lerp(Colors.white, widget.accent, 0.08)!,
                ],
              ),
              border: Border.all(
                color: widget.accent.withValues(alpha: 0.35),
                width: 2.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.accent.withValues(alpha: 0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🎉', style: TextStyle(fontSize: 48)),
                const SizedBox(height: 8),
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: PuzzlePlayUi.titleStyle(
                    size: 26,
                    color: widget.accent,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                  style: PuzzlePlayUi.bodyStyle(size: 15),
                ),
                const SizedBox(height: 14),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('⭐', style: TextStyle(fontSize: 26)),
                    SizedBox(width: 6),
                    Text('⭐', style: TextStyle(fontSize: 26)),
                    SizedBox(width: 6),
                    Text('⭐', style: TextStyle(fontSize: 26)),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      AppHapticFeedback.success();
                      widget.onPrimary();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: widget.accent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Text(
                      widget.primaryLabel,
                      style: PuzzlePlayUi.bodyStyle(
                        size: 16,
                        color: Colors.white,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: widget.onSecondary,
                  child: Text(
                    widget.secondaryLabel,
                    style: PuzzlePlayUi.bodyStyle(
                      size: 15,
                      color: widget.accent,
                      weight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PuzzleFlipCard extends StatelessWidget {
  final bool faceUp;
  final bool matched;
  final String emoji;
  final Color accent;
  final VoidCallback? onTap;
  final bool locked;

  const PuzzleFlipCard({
    super.key,
    required this.faceUp,
    required this.matched,
    required this.emoji,
    required this.accent,
    this.onTap,
    this.locked = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: locked || matched ? null : onTap,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: faceUp || matched ? 1 : 0),
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOutCubic,
        builder: (context, value, _) {
          final angle = value * math.pi;
          final showFront = value >= 0.5;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0012)
              ..rotateY(angle),
            child: showFront
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(math.pi),
                    child: _Face(
                      matched: matched,
                      emoji: emoji,
                      accent: accent,
                      isFront: true,
                    ),
                  )
                : _Face(
                    matched: false,
                    emoji: '🧩',
                    accent: accent,
                    isFront: false,
                  ),
          );
        },
      ),
    );
  }
}

class _Face extends StatelessWidget {
  final bool matched;
  final String emoji;
  final Color accent;
  final bool isFront;

  const _Face({
    required this.matched,
    required this.emoji,
    required this.accent,
    required this.isFront,
  });

  @override
  Widget build(BuildContext context) {
    final border = matched
        ? AppColors.puzzleSuccess
        : isFront
            ? accent
            : Colors.white.withValues(alpha: 0.55);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: isFront
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Color.lerp(
                    Colors.white,
                    matched ? AppColors.puzzleSuccess : accent,
                    matched ? 0.18 : 0.10,
                  )!,
                ],
              )
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  accent,
                  Color.lerp(accent, Colors.white, 0.18)!,
                ],
              ),
        border: Border.all(color: border, width: matched ? 3 : 2.2),
        boxShadow: [
          BoxShadow(
            color: (matched ? AppColors.puzzleSuccess : accent)
                .withValues(alpha: matched ? 0.32 : 0.2),
            blurRadius: matched ? 14 : 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        emoji,
        style: TextStyle(
          fontSize: isFront ? 38 : 30,
          color: isFront ? null : Colors.white.withValues(alpha: 0.95),
        ),
      ),
    );
  }
}

class PuzzleConnectTile extends StatelessWidget {
  final String emoji;
  final String label;
  final bool selected;
  final bool matched;
  final bool dimmed;
  final Color accent;
  final VoidCallback? onTap;
  final bool verticalLayout;

  const PuzzleConnectTile({
    super.key,
    required this.emoji,
    required this.label,
    required this.selected,
    required this.matched,
    required this.accent,
    this.dimmed = false,
    this.onTap,
    this.verticalLayout = false,
  });

  @override
  Widget build(BuildContext context) {
    Color bg = Colors.white;
    Color border = accent.withValues(alpha: 0.28);
    var shadows = <BoxShadow>[
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 8,
        offset: const Offset(0, 3),
      ),
    ];

    if (matched) {
      bg = Color.lerp(Colors.white, AppColors.puzzleSuccess, 0.16)!;
      border = AppColors.puzzleSuccess;
      shadows = [
        BoxShadow(
          color: AppColors.puzzleSuccess.withValues(alpha: 0.26),
          blurRadius: 12,
          offset: const Offset(0, 5),
        ),
      ];
    } else if (selected) {
      bg = Color.lerp(Colors.white, accent, 0.14)!;
      border = accent;
      shadows = [
        BoxShadow(
          color: accent.withValues(alpha: 0.28),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ];
    }

    return Opacity(
      opacity: dimmed && !matched && !selected ? 0.45 : 1,
      child: GestureDetector(
        onTap: matched ? null : onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          constraints: verticalLayout
              ? const BoxConstraints(minHeight: 96)
              : null,
          padding: EdgeInsets.symmetric(
            horizontal: verticalLayout ? 8 : 10,
            vertical: verticalLayout ? 10 : 12,
          ),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: border,
              width: selected || matched ? 2.8 : 2,
            ),
            boxShadow: shadows,
          ),
          child: verticalLayout
              ? _buildVerticalContent()
              : _buildHorizontalContent(matched),
        ),
      ),
    );
  }

  Widget _buildHorizontalContent(bool matched) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Color.lerp(Colors.white, accent, 0.12),
            borderRadius: BorderRadius.circular(14),
          ),
          alignment: Alignment.center,
          child: Text(emoji, style: const TextStyle(fontSize: 26)),
        ),
        const SizedBox(width: 10),
        Expanded(child: _labelText(compact: false)),

      ],
    );
  }

  Widget _buildVerticalContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(Colors.white, accent, 0.20)!,
                Color.lerp(Colors.white, accent, 0.06)!,
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: accent.withValues(alpha: 0.28)),
          ),
          alignment: Alignment.center,
          child: Text(emoji, style: const TextStyle(fontSize: 24)),
        ),
        const SizedBox(height: 8),
        _labelText(compact: true),

      ],
    );
  }

  Widget _labelText({required bool compact}) {
    final len = label.length;
    var size = compact ? 13.5 : 15.0;
    if (len > 8) size -= 0.5;
    if (len > 11) size -= 1.0;
    if (len > 14) size -= 0.5;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth.isFinite && constraints.maxWidth > 0
            ? constraints.maxWidth
            : (compact ? 132.0 : 200.0);
        return SizedBox(
          width: maxW,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: compact ? 2 : 2,
              softWrap: true,
              style: PuzzlePlayUi.bodyStyle(
                size: size,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ).copyWith(height: 1.12),
            ),
          ),
        );
      },
    );
  }
}

class PuzzlePrimaryButton extends StatelessWidget {
  final String label;
  final Color accent;
  final Color? wash;
  final VoidCallback onPressed;

  const PuzzlePrimaryButton({
    super.key,
    required this.label,
    required this.accent,
    this.wash,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final washColor = wash ?? Color.lerp(accent, Colors.white, 0.22)!;
    final btn = Color.lerp(accent, Colors.white, 0.18)!;
    final btnEnd = Color.lerp(
      Color.lerp(accent, washColor, 0.3)!,
      Colors.white,
      0.14,
    )!;

    return GestureDetector(
      onTap: () {
        AppHapticFeedback.medium();
        onPressed();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [btn, btnEnd]),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: btn.withValues(alpha: 0.32),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.28),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: PuzzlePlayUi.bodyStyle(
                size: 16,
                color: Colors.white,
                weight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
