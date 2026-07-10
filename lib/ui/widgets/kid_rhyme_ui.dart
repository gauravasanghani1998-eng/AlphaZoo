import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';

/// Soft musical backdrop for rhyme list & lyric screens.
class KidRhymeBackdrop extends StatelessWidget {
  final List<Color> gradientColors;
  final Widget child;

  const KidRhymeBackdrop({
    super.key,
    required this.gradientColors,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ),
          ),
        ),
        const _FloatingMusicNotes(),
        child,
      ],
    );
  }
}

class _FloatingMusicNotes extends StatelessWidget {
  const _FloatingMusicNotes();

  static const _notes = [
    _NoteSpec('♪', 0.08, 0.12, 28, 0.12),
    _NoteSpec('🎵', 0.82, 0.08, 32, 0.1),
    _NoteSpec('♫', 0.15, 0.38, 24, 0.08),
    _NoteSpec('✨', 0.88, 0.32, 22, 0.14),
    _NoteSpec('♪', 0.72, 0.62, 26, 0.09),
    _NoteSpec('🎶', 0.06, 0.72, 30, 0.11),
  ];

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              for (final n in _notes)
                Positioned(
                  left: constraints.maxWidth * n.dx - n.size / 2,
                  top: constraints.maxHeight * n.dy,
                  child: Opacity(
                    opacity: n.opacity,
                    child: Text(
                      n.glyph,
                      style: TextStyle(fontSize: n.size),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _NoteSpec {
  final String glyph;
  final double dx;
  final double dy;
  final double size;
  final double opacity;

  const _NoteSpec(this.glyph, this.dx, this.dy, this.size, this.opacity);
}

/// Story-book style rhyme row on the list screen.
class KidRhymeListCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String preview;
  final Color color;
  final bool hasSong;
  final VoidCallback onTap;

  const KidRhymeListCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.preview,
    required this.color,
    required this.hasSong,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const radius = 16.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 14,
              spreadRadius: 1,
              offset: const Offset(0, 5),
            ),
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(radius),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                border: Border(
                  left: BorderSide(color: color, width: 5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _EmojiBubble(emoji: emoji, color: color),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppTextStyles.bodyBold.copyWith(
                              fontSize: 17,
                              color: AppColors.textPrimary,
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            preview,
                            style: AppTextStyles.body.copyWith(
                              fontSize: 13,
                              height: 1.35,
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    _PlayOrb(color: color, hasSong: hasSong),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmojiBubble extends StatelessWidget {
  final String emoji;
  final Color color;

  const _EmojiBubble({required this.emoji, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.22),
            color.withValues(alpha: 0.08),
          ],
        ),
        border: Border.all(color: color.withValues(alpha: 0.35), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(emoji, style: const TextStyle(fontSize: 34)),
    );
  }
}

class _PlayOrb extends StatelessWidget {
  final Color color;
  final bool hasSong;

  const _PlayOrb({required this.color, required this.hasSong});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withValues(alpha: 0.78)],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Icon(
        hasSong ? Icons.play_arrow_rounded : Icons.volume_up_rounded,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}

/// Open-book style lyrics panel for the sing-along screen.
class KidRhymeLyricsBook extends StatelessWidget {
  final Color color;
  final List<List<int>> stanzaLineIndices;
  final List<String> lines;
  final String footerHint;
  final double fontSize;

  const KidRhymeLyricsBook({
    super.key,
    required this.color,
    required this.stanzaLineIndices,
    required this.lines,
    required this.footerHint,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 18,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      color.withValues(alpha: 0.35),
                      color.withValues(alpha: 0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 22, 22, 22),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFFFFBF7),
                    Color.lerp(const Color(0xFFFFF8EE), color, 0.06)!,
                  ],
                ),
                border: Border.all(color: color.withValues(alpha: 0.28), width: 2),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.auto_stories_rounded,
                          color: color.withValues(alpha: 0.7), size: 24),
                      const SizedBox(width: 8),
                      Text(
                        '♪ ♫ ♪',
                        style: TextStyle(
                          fontSize: 14,
                          color: color.withValues(alpha: 0.55),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...stanzaLineIndices.asMap().entries.map((entry) {
                    final stanzaIndex = entry.key;
                    final lineIndices = entry.value;
                    return Column(
                      children: [
                        if (stanzaIndex > 0) ...[
                          const SizedBox(height: 6),
                          RhymeStanzaDivider(color: color),
                          const SizedBox(height: 14),
                        ],
                        ...lineIndices.map((lineIndex) {
                          return RhymeLyricLine(
                            text: lines[lineIndex],
                            color: color,
                            fontSize: fontSize,
                          );
                        }),
                      ],
                    );
                  }),
                  const SizedBox(height: 6),
                  Text(
                    footerHint,
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RhymeLyricLine extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;

  const RhymeLyricLine({
    super.key,
    required this.text,
    required this.color,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.12),
          width: 1,
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyBold.copyWith(
          fontSize: fontSize,
          height: 1.5,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class RhymeStanzaDivider extends StatelessWidget {
  final Color color;

  const RhymeStanzaDivider({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, color.withValues(alpha: 0.35)],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('✦', style: TextStyle(color: color, fontSize: 16)),
        ),
        Expanded(
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withValues(alpha: 0.35), Colors.transparent],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Hero emoji stage with soft rings for the lyric screen.
class KidRhymeHeroStage extends StatelessWidget {
  final String emoji;
  final Color color;
  final Animation<double> bounce;
  final bool bouncing;
  final String singAlongLabel;

  const KidRhymeHeroStage({
    super.key,
    required this.emoji,
    required this.color,
    required this.bounce,
    required this.bouncing,
    required this.singAlongLabel,
  });

  @override
  Widget build(BuildContext context) {
    final emojiSize =
        (MediaQuery.sizeOf(context).width * 0.18).clamp(52.0, 72.0);
    final innerCircle = emojiSize + 24;

    return Column(
      children: [
        ScaleTransition(
          scale: bouncing ? bounce : const AlwaysStoppedAnimation(1.0),
          child: SizedBox(
            width: innerCircle + 40,
            height: innerCircle + 40,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  width: innerCircle + 32,
                  height: innerCircle + 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.35),
                      width: 2,
                    ),
                  ),
                ),
                Container(
                  width: innerCircle + 12,
                  height: innerCircle + 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.22),
                  ),
                ),
                Container(
                  width: innerCircle,
                  height: innerCircle,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.55),
                        color.withValues(alpha: 0.35),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.35),
                        blurRadius: 24,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(innerCircle * 0.14),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      emoji,
                      style: TextStyle(
                        fontSize: emojiSize,
                        height: 1.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const Positioned(
                  top: 6,
                  right: 14,
                  child: Text('✨', style: TextStyle(fontSize: 16)),
                ),
                const Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text('⭐', style: TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
          ),
          child: Text(
            singAlongLabel,
            style: AppTextStyles.bodyBold.copyWith(
              color: Colors.white,
              fontSize: 15,
              shadows: [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Bottom play controls for rhyme detail.
class KidRhymePlayDock extends StatelessWidget {
  final Color color;
  final IconData mainIcon;
  final String playLabel;
  final String statusLabel;
  final bool showStatus;
  final bool showEnglishNote;
  final String englishNote;
  final double? progress;
  final VoidCallback onToggle;

  const KidRhymePlayDock({
    super.key,
    required this.color,
    required this.mainIcon,
    required this.playLabel,
    required this.statusLabel,
    required this.showStatus,
    required this.showEnglishNote,
    required this.englishNote,
    required this.progress,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.94),
            border: Border(
              top: BorderSide(color: color.withValues(alpha: 0.15)),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, -6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showStatus && statusLabel.isNotEmpty) ...[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.graphic_eq_rounded, color: color, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        statusLabel,
                        style: AppTextStyles.caption.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
              if (showEnglishNote) ...[
                Text(
                  englishNote,
                  style: AppTextStyles.caption.copyWith(
                    color: color.withValues(alpha: 0.85),
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
              ],
              if (progress != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress!.clamp(0.0, 1.0),
                    minHeight: 7,
                    backgroundColor: color.withValues(alpha: 0.12),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
                const SizedBox(height: 14),
              ],
              GestureDetector(
                onTap: onToggle,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color.withValues(alpha: 0.15),
                      ),
                    ),
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [color, Color.lerp(color, Colors.black, 0.12)!],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: 0.45),
                            blurRadius: 18,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Icon(mainIcon, color: Colors.white, size: 42),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                playLabel,
                style: AppTextStyles.bodyBold.copyWith(
                  color: color,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Pulsing ring used behind idle play button (optional decoration).
class KidRhymePulseRing extends StatefulWidget {
  final Color color;
  final bool active;

  const KidRhymePulseRing({
    super.key,
    required this.color,
    required this.active,
  });

  @override
  State<KidRhymePulseRing> createState() => _KidRhymePulseRingState();
}

class _KidRhymePulseRingState extends State<KidRhymePulseRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    if (widget.active) _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant KidRhymePulseRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.active) {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.active) return const SizedBox.shrink();
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        final scale = 1.0 + t * 0.22;
        final opacity = (1 - t) * 0.35;
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: widget.color.withValues(alpha: opacity),
                width: 3,
              ),
            ),
          ),
        );
      },
    );
  }
}

Color rhymeGradientEnd(Color c) {
  return Color.lerp(const Color(0xFFFFF8F0), c, 0.18)!;
}

List<Color> rhymeDetailGradient(Color c) {
  return [
    Color.lerp(c, Colors.white, 0.15)!,
    c.withValues(alpha: 0.45),
    const Color(0xFFFFF8F0),
    AppColors.appBarTint,
  ];
}
