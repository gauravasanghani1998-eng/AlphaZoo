import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/positions_directions_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';

/// Positions & Directions detail — a live "playground stage" acts out each
/// concept with moving emoji, then bright story cards explain it.
class PositionsDirectionsDetailScreen extends StatefulWidget {
  final int initialIndex;

  const PositionsDirectionsDetailScreen({
    super.key,
    required this.initialIndex,
  });

  @override
  State<PositionsDirectionsDetailScreen> createState() =>
      _PositionsDirectionsDetailScreenState();
}

class _PositionsDirectionsDetailScreenState
    extends State<PositionsDirectionsDetailScreen>
    with TickerProviderStateMixin {
  late int _index;
  late final AnimationController _play;
  late final AnimationController _enter;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  final ScrollController _scroll = ScrollController();

  List<PositionDirectionItem> get _items => PositionsDirectionsData.items;

  PositionDirectionItem get _item => _items[_index];

  String get _name => _item.nameKey.tr();
  String get _caption => _item.captionKey.tr();
  String get _about => _item.aboutKey.tr();
  String get _funFact => _item.funFactKey.tr();
  String get _try => _item.tryKey.tr();

  Color get _accent => AppColors.directionsAccent(_index);

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex.clamp(0, _items.length - 1);
    _play = AnimationController(
      duration: const Duration(milliseconds: 2600),
      vsync: this,
    )..repeat();
    _enter = AnimationController(
      duration: const Duration(milliseconds: 550),
      vsync: this,
    );
    _setupAnims();
    _enter.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) => _speakIntro());
  }

  void _setupAnims() {
    _fade = CurvedAnimation(parent: _enter, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _enter, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    AppSpeech.stop();
    _play.dispose();
    _enter.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _speakIntro() => AppSpeech.speak(context, '$_name. $_caption');

  void _speakPart(String title, String body) {
    final t = title.trim();
    final b = body.trim();
    AppSpeech.speak(context, t.isEmpty ? b : '$t. $b');
  }

  void _goTo(int next) {
    if (next < 0 || next >= _items.length) return;
    AppHapticFeedback.success();
    if (_scroll.hasClients) _scroll.jumpTo(0);
    setState(() => _index = next);
    _enter.reset();
    _setupAnims();
    _enter.forward();
    _speakIntro();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final total = _items.length;
    final accent = _accent;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) => AppSpeech.stop(),
      child: Scaffold(
        backgroundColor: AppColors.directionsDetailBg,
        body: Column(
          children: [
            _TopStrip(
              accent: accent,
              emoji: _item.emoji,
              title: _name,
              onBack: () {
                AppSpeech.stop();
                Navigator.of(context).pop();
              },
            ),
            Expanded(
              child: FadeTransition(
                opacity: _fade,
                child: SlideTransition(
                  position: _slide,
                  child: SingleChildScrollView(
                    controller: _scroll,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(pad, 16, pad, 20),
                    child: Column(
                      children: [
                        _PlaygroundStage(item: _item, play: _play),
                        const SizedBox(height: 14),
                        _CaptionBubble(
                          accent: accent,
                          caption: _caption,
                          onTap: () {
                            AppHapticFeedback.light();
                            AppSpeech.speak(context, _caption);
                          },
                        ),
                        const SizedBox(height: 18),
                        _StoryCard(
                          accent: accent,
                          icon: Icons.menu_book_rounded,
                          title: 'positionsDirections.meaningTitle'.tr(),
                          body: _about,
                          onSpeak: () => _speakPart(
                            'positionsDirections.meaningTitle'.tr(),
                            _about,
                          ),
                        ),
                        const SizedBox(height: 14),
                        _StoryCard(
                          accent: accent,
                          icon: Icons.auto_awesome_rounded,
                          title: 'positionsDirections.funTitle'.tr(),
                          body: _funFact,
                          onSpeak: () => _speakPart(
                            'positionsDirections.funTitle'.tr(),
                            _funFact,
                          ),
                        ),
                        const SizedBox(height: 14),
                        _StoryCard(
                          accent: accent,
                          icon: Icons.flag_rounded,
                          title: 'positionsDirections.tryTitle'.tr(),
                          body: _try,
                          onSpeak: () => _speakPart(
                            'positionsDirections.tryTitle'.tr(),
                            _try,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _ListenPill(
                          accent: accent,
                          label: 'positionsDirections.listenAgain'.tr(),
                          onTap: _speakIntro,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _CompassNavBar(
              accent: accent,
              index: _index,
              total: total,
              onPrev: _index > 0 ? () => _goTo(_index - 1) : null,
              onNext: _index < total - 1 ? () => _goTo(_index + 1) : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _TopStrip extends StatelessWidget {
  final Color accent;
  final String emoji;
  final String title;
  final VoidCallback onBack;

  const _TopStrip({
    required this.accent,
    required this.emoji,
    required this.title,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(12, topPad + 8, 12, 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accent,
            Color.lerp(accent, AppColors.directionsSkyTop, 0.55)!,
          ],
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Material(
            color: AppColors.white.withValues(alpha: 0.25),
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onBack,
              child: const SizedBox(
                width: 42,
                height: 42,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.white,
                  size: 19,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.heading2.copyWith(
                        color: AppColors.white,
                        fontSize: 22,
                        shadows: [
                          Shadow(
                            color: AppColors.black.withValues(alpha: 0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 42),
        ],
      ),
    );
  }
}

/// Sky + rolling grass hill where emojis act out the concept in a loop.
class _PlaygroundStage extends StatelessWidget {
  final PositionDirectionItem item;
  final Animation<double> play;

  const _PlaygroundStage({required this.item, required this.play});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: AppColors.directionsSkyTop.withValues(alpha: 0.45),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: SizedBox(
          height: 250,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Vivid sky
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: AppColors.directionsStageSky,
                    stops: [0.0, 0.55, 1.0],
                  ),
                ),
              ),
              // Glowing sun
              Positioned(
                top: 12,
                left: 14,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.directionsSun.withValues(alpha: 0.55),
                        AppColors.directionsSun.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                  child: const Text('☀️', style: TextStyle(fontSize: 28)),
                ),
              ),
              // Drifting clouds
              AnimatedBuilder(
                animation: play,
                builder: (context, _) {
                  final t = play.value;
                  final sway = math.sin(t * 2 * math.pi) * 8;
                  return Stack(
                    children: [
                      Positioned(
                        top: 16,
                        right: 24 + sway,
                        child: const Text(
                          '☁️',
                          style: TextStyle(fontSize: 26),
                        ),
                      ),
                      Positioned(
                        top: 54,
                        right: 90 - sway,
                        child: Text(
                          '☁️',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.white.withValues(alpha: 0.85),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              // Rolling grass hill
              const Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 74,
                child: CustomPaint(painter: _HillPainter()),
              ),
              const Positioned(
                bottom: 10,
                left: 22,
                child: Text('🌼', style: TextStyle(fontSize: 16)),
              ),
              const Positioned(
                bottom: 6,
                right: 30,
                child: Text('🌷', style: TextStyle(fontSize: 16)),
              ),
              const Positioned(
                bottom: 14,
                right: 88,
                child: Text('🌿', style: TextStyle(fontSize: 13)),
              ),
              // The show
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 34, 16, 26),
                  child: _buildActors(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActors() {
    switch (item.kind) {
      case PositionStageKind.direction:
        return _DirectionShow(item: item, play: play);
      case PositionStageKind.scene:
        return _SceneShow(item: item, play: play);
      case PositionStageKind.orbit:
        return _OrbitShow(item: item, play: play);
    }
  }
}

/// Two-tone grass hill with a soft curved top edge.
class _HillPainter extends CustomPainter {
  const _HillPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final back = Paint()..color = AppColors.directionsGrass;
    final front = Paint()..color = AppColors.directionsGrassDark;

    final backPath = Path()
      ..moveTo(0, size.height * 0.42)
      ..quadraticBezierTo(
        size.width * 0.3,
        size.height * 0.05,
        size.width * 0.62,
        size.height * 0.3,
      )
      ..quadraticBezierTo(
        size.width * 0.85,
        size.height * 0.48,
        size.width,
        size.height * 0.28,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(backPath, back);

    final frontPath = Path()
      ..moveTo(0, size.height * 0.78)
      ..quadraticBezierTo(
        size.width * 0.4,
        size.height * 0.5,
        size.width,
        size.height * 0.72,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(frontPath, front);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DirectionShow extends StatelessWidget {
  final PositionDirectionItem item;
  final Animation<double> play;

  const _DirectionShow({required this.item, required this.play});

  @override
  Widget build(BuildContext context) {
    // Arrow points the way; the chick hops along it again and again.
    final angle = item.dirDy != 0
        ? (item.dirDy < 0 ? -math.pi / 2 : math.pi / 2)
        : (item.dirDx < 0 ? math.pi : 0.0);

    return AnimatedBuilder(
      animation: play,
      builder: (context, _) {
        final t = Curves.easeInOut.transform(
          play.value < 0.5 ? play.value * 2 : (1 - play.value) * 2,
        );
        final travel = 0.5 * t;
        return Stack(
          children: [
            if (item.refEmoji != null)
              Align(
                alignment: item.refAlignment,
                child: Text(
                  item.refEmoji!,
                  style: TextStyle(fontSize: 48 * item.refScale),
                ),
              ),
            Align(
              alignment: Alignment.center,
              child: Transform.rotate(
                angle: angle,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 76,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(
                item.dirDx * (0.2 + travel),
                item.dirDy * (0.2 + travel),
              ),
              child: Text(
                item.actorEmoji,
                style: const TextStyle(fontSize: 46),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SceneShow extends StatelessWidget {
  final PositionDirectionItem item;
  final Animation<double> play;

  const _SceneShow({required this.item, required this.play});

  @override
  Widget build(BuildContext context) {
    final refs = <Widget>[
      if (item.refEmoji != null)
        Align(
          alignment: item.refAlignment,
          child: Text(
            item.refEmoji!,
            style: TextStyle(fontSize: 52 * item.refScale),
          ),
        ),
      if (item.refEmoji2 != null)
        Align(
          alignment: item.ref2Alignment,
          child: Text(
            item.refEmoji2!,
            style: TextStyle(fontSize: 52 * item.refScale),
          ),
        ),
    ];

    final actor = AnimatedBuilder(
      animation: play,
      builder: (context, child) {
        final bob = Curves.easeInOut.transform(
          play.value < 0.5 ? play.value * 2 : (1 - play.value) * 2,
        );
        return Align(
          alignment: Alignment(
            item.actorAlignment.x,
            item.actorAlignment.y - bob * 0.07,
          ),
          child: child,
        );
      },
      child: Text(
        item.actorEmoji,
        style: TextStyle(fontSize: 44 * item.actorScale),
      ),
    );

    return Stack(
      children: item.actorInFront ? [...refs, actor] : [actor, ...refs],
    );
  }
}

class _OrbitShow extends StatelessWidget {
  final PositionDirectionItem item;
  final Animation<double> play;

  const _OrbitShow({required this.item, required this.play});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: play,
      builder: (context, _) {
        final angle = play.value * 2 * math.pi;
        return Stack(
          children: [
            if (item.refEmoji != null)
              Align(
                alignment: item.refAlignment,
                child: Text(
                  item.refEmoji!,
                  style: TextStyle(fontSize: 52 * item.refScale),
                ),
              ),
            Align(
              alignment: Alignment(
                item.refAlignment.x + 0.72 * math.cos(angle),
                item.refAlignment.y + 0.55 * math.sin(angle),
              ),
              child: Text(
                item.actorEmoji,
                style: TextStyle(fontSize: 40 * item.actorScale),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Speech-bubble caption: colored gradient pill with a chatty icon.
class _CaptionBubble extends StatelessWidget {
  final Color accent;
  final String caption;
  final VoidCallback onTap;

  const _CaptionBubble({
    required this.accent,
    required this.caption,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                accent,
                Color.lerp(accent, AppColors.directionsSkyTop, 0.4)!,
              ],
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.35),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.record_voice_over_rounded,
                  color: accent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  caption,
                  style: AppTextStyles.bodyBold.copyWith(
                    fontSize: 15,
                    height: 1.3,
                    color: AppColors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.volume_up_rounded,
                size: 22,
                color: AppColors.white.withValues(alpha: 0.9),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Soft story card: icon badge + accent title on a clean white card,
/// all cards share the page accent (no colored header bands).
class _StoryCard extends StatelessWidget {
  final Color accent;
  final IconData icon;
  final String title;
  final String body;
  final VoidCallback onSpeak;

  const _StoryCard({
    required this.accent,
    required this.icon,
    required this.title,
    required this.body,
    required this.onSpeak,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: () {
          AppHapticFeedback.light();
          onSpeak();
        },
        borderRadius: BorderRadius.circular(24),
        splashColor: accent.withValues(alpha: 0.12),
        highlightColor: accent.withValues(alpha: 0.05),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(accent, AppColors.white, 0.92)!,
                AppColors.white,
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: accent.withValues(alpha: 0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.12),
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
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon, color: AppColors.white, size: 22),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyles.heading3.copyWith(
                        fontSize: 18,
                        color: accent,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.volume_up_rounded,
                    size: 20,
                    color: accent.withValues(alpha: 0.7),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                body,
                style: AppTextStyles.body.copyWith(
                  fontSize: 15.5,
                  height: 1.45,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Big bottom "Listen again" button — same pattern as other detail screens.
class _ListenPill extends StatelessWidget {
  final Color accent;
  final String label;
  final VoidCallback onTap;

  const _ListenPill({
    required this.accent,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: () {
          AppHapticFeedback.light();
          onTap();
        },
        borderRadius: BorderRadius.circular(28),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
              colors: [
                accent,
                Color.lerp(accent, AppColors.directionsSkyTop, 0.45)!,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.25),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.volume_up_rounded,
                  color: AppColors.white,
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  label,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompassNavBar extends StatelessWidget {
  final Color accent;
  final int index;
  final int total;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;

  const _CompassNavBar({
    required this.accent,
    required this.index,
    required this.total,
    this.onPrev,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.08),
              blurRadius: 14,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            _NavPill(
              accent: accent,
              icon: Icons.west_rounded,
              enabled: onPrev != null,
              onTap: onPrev,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'positionsDirections.progress'.tr(
                        namedArgs: {
                          'current': '${index + 1}',
                          'total': '$total',
                        },
                      ),
                      style: AppTextStyles.bodyBold.copyWith(
                        color: accent,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: (index + 1) / total,
                        minHeight: 7,
                        backgroundColor: accent.withValues(alpha: 0.15),
                        valueColor: AlwaysStoppedAnimation<Color>(accent),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _NavPill(
              accent: accent,
              icon: Icons.east_rounded,
              enabled: onNext != null,
              filled: true,
              onTap: onNext,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavPill extends StatelessWidget {
  final Color accent;
  final IconData icon;
  final bool enabled;
  final bool filled;
  final VoidCallback? onTap;

  const _NavPill({
    required this.accent,
    required this.icon,
    required this.enabled,
    this.filled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fg = !enabled
        ? accent.withValues(alpha: 0.4)
        : filled
            ? AppColors.white
            : accent;

    return Material(
      color: AppColors.transparent,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: enabled ? onTap : null,
        child: Ink(
          width: 64,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: enabled && filled
                ? LinearGradient(
                    colors: [
                      accent,
                      Color.lerp(accent, AppColors.directionsSkyTop, 0.4)!,
                    ],
                  )
                : null,
            color: enabled && filled ? null : accent.withValues(alpha: 0.12),
            boxShadow: enabled && filled
                ? [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Icon(icon, color: fg, size: 26),
        ),
      ),
    );
  }
}
