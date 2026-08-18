import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Chalkboard + wooden frame palette for the trace practice screen.
class LetterTraceBoardTheme {
  LetterTraceBoardTheme._();

  static const Color frameOuter = Color(0xFFE8A54B);
  static const Color frameInner = Color(0xFF9A6530);
  static const Color chalkGreen = Color(0xFF2E5038);
  static const Color chalkGreenDark = Color(0xFF243D2E);
  static const Color woodLight = Color(0xFFD4A06A);
  static const Color woodMid = Color(0xFFB8793A);
  static const Color woodDark = Color(0xFF6B4420);
  static const Color woodPlankHighlight = Color(0xFFE8C08A);
}

/// Outer wooden frame wrapping the chalkboard body.
class LetterTraceWoodenFrame extends StatelessWidget {
  final Widget child;

  const LetterTraceWoodenFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            LetterTraceBoardTheme.frameOuter,
            LetterTraceBoardTheme.frameInner,
            LetterTraceBoardTheme.woodDark,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.28),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(7),
      child: Container(
        decoration: BoxDecoration(
          color: LetterTraceBoardTheme.chalkGreenDark,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: LetterTraceBoardTheme.woodDark.withValues(alpha: 0.55),
            width: 2,
          ),
        ),
        child: child,
      ),
    );
  }
}

/// Hanging wooden plank button (A~Z / a~z style).
class LetterTraceWoodPlankButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final List<Color>? labelColors;

  const LetterTraceWoodPlankButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.labelColors,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: selected
                  ? [
                      LetterTraceBoardTheme.woodPlankHighlight,
                      LetterTraceBoardTheme.woodMid,
                    ]
                  : [
                      LetterTraceBoardTheme.woodLight,
                      LetterTraceBoardTheme.woodMid.withValues(alpha: 0.88),
                    ],
            ),
            border: Border.all(
              color: selected
                  ? LetterTraceBoardTheme.woodDark
                  : LetterTraceBoardTheme.woodDark.withValues(alpha: 0.65),
              width: selected ? 2.5 : 1.8,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: selected ? 0.22 : 0.12),
                blurRadius: selected ? 6 : 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: _PlankLabel(text: label, colors: labelColors),
        ),
      ),
    );
  }
}

class _PlankLabel extends StatelessWidget {
  final String text;
  final List<Color>? colors;

  const _PlankLabel({required this.text, this.colors});

  @override
  Widget build(BuildContext context) {
    if (colors == null || colors!.length < 2) {
      return Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.fredoka(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: LetterTraceBoardTheme.woodDark,
          height: 1.0,
        ),
      );
    }

    final parts = text.split('~');
    if (parts.length != 2) {
      return Text(text, textAlign: TextAlign.center);
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            parts[0],
            style: GoogleFonts.fredoka(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: colors![0],
              shadows: const [
                Shadow(color: Colors.white, offset: Offset(1, 1), blurRadius: 0),
              ],
            ),
          ),
          Text(
            '~',
            style: GoogleFonts.fredoka(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: LetterTraceBoardTheme.woodDark,
            ),
          ),
          Text(
            parts[1],
            style: GoogleFonts.fredoka(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: colors![1],
              shadows: const [
                Shadow(color: Colors.white, offset: Offset(1, 1), blurRadius: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Small chip button — same size family as Start again / Hear again.
class LetterTraceCompactAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const LetterTraceCompactAction({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.55)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Beige tile showing current letter — capital/lowercase pair or single glyph.
class LetterTraceLetterBadge extends StatelessWidget {
  final String upper;
  final String lower;
  final bool showCasePair;

  const LetterTraceLetterBadge({
    super.key,
    required this.upper,
    required this.lower,
    this.showCasePair = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFF8E8), Color(0xFFF3E2C8)],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: LetterTraceBoardTheme.woodDark, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: showCasePair
          ? Column(
              children: [
                Text(
                  upper,
                  style: GoogleFonts.nunito(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: LetterTraceBoardTheme.woodDark,
                    height: 1,
                  ),
                ),
                Text(
                  lower,
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: LetterTraceBoardTheme.woodMid,
                    height: 1.1,
                  ),
                ),
              ],
            )
          : FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                upper,
                style: GoogleFonts.nunito(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: LetterTraceBoardTheme.woodDark,
                  height: 1,
                ),
              ),
            ),
    );
  }
}
