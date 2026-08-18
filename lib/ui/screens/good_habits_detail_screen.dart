import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/good_habits_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';

/// Playful habit detail — kid storybook look, no per-habit image assets.
class GoodHabitsDetailScreen extends StatefulWidget {
  final GoodHabitCategory category;
  final int initialIndex;
  final Color accentColor;

  const GoodHabitsDetailScreen({
    super.key,
    required this.category,
    required this.initialIndex,
    required this.accentColor,
  });

  @override
  State<GoodHabitsDetailScreen> createState() => _GoodHabitsDetailScreenState();
}

class _GoodHabitsDetailScreenState extends State<GoodHabitsDetailScreen>
    with TickerProviderStateMixin {
  late int _index;
  late AnimationController _enter;
  late AnimationController _bobble;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  final ScrollController _scroll = ScrollController();

  GoodHabitItem get _habit => widget.category.habits[_index];

  String get _name => _habit.nameKey.tr();

  String get _about =>
      'goodHabits.categories.${widget.category.id}.detail.${_habit.id}.about'
          .tr(namedArgs: {'name': _name});

  String get _tip =>
      'goodHabits.categories.${widget.category.id}.detail.${_habit.id}.funFact'
          .tr(namedArgs: {'name': _name});

  String get _try =>
      'goodHabits.categories.${widget.category.id}.detail.${_habit.id}.try'
          .tr(namedArgs: {'name': _name});

  String get _encouragement => 'goodHabits.encouragement.${_index % 6}'.tr();

  /// Each habit gets its own joyful tint when flipping pages.
  Color get _pageAccent => AppColors.goodHabitsPageAccent(
        categoryAccent: widget.accentColor,
        habitIndex: _index,
      );

  Color get _pageAccentSoft => Color.lerp(_pageAccent, AppColors.white, 0.55)!;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex.clamp(0, widget.category.habits.length - 1);
    _enter = AnimationController(
      duration: const Duration(milliseconds: 620),
      vsync: this,
    );
    _bobble = AnimationController(
      duration: const Duration(milliseconds: 2200),
      vsync: this,
    )..repeat(reverse: true);
    _setupAnims();
    _enter.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) => _speakCurrent());
  }

  void _setupAnims() {
    _fade = CurvedAnimation(parent: _enter, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _enter, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    AppSpeech.stop();
    _enter.dispose();
    _bobble.dispose();
    _scroll.dispose();
    super.dispose();
  }

  /// Entry / listen-again / page change — habit title only.
  void _speakCurrent() => AppSpeech.speak(context, _name);

  /// Speaks a section card (title + body) when that card's speaker is tapped.
  void _speakPart(String title, String body) {
    final t = title.trim();
    final b = body.trim();
    final text = t.isEmpty ? b : '$t. $b';
    AppSpeech.speak(context, text);
  }

  void _goTo(int next) {
    if (next < 0 || next >= widget.category.habits.length) return;
    AppHapticFeedback.success();
    if (_scroll.hasClients) _scroll.jumpTo(0);
    setState(() => _index = next);
    _enter.reset();
    _setupAnims();
    _enter.forward();
    _speakCurrent();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final accent = _pageAccent;
    final total = widget.category.habits.length;
    final topPad = MediaQuery.paddingOf(context).top;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        AppSpeech.stop();
      },
      child: Scaffold(
        backgroundColor: AppColors.goodHabitsDetailBg,
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                controller: _scroll,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: _HeroZone(
                      topPad: topPad,
                      accent: accent,
                      soft: _pageAccentSoft,
                      emoji: widget.category.emoji,
                      categoryTitle: widget.category.titleKey.tr(),
                      number: _index + 1,
                      total: total,
                      name: _name,
                      encouragement: _encouragement,
                      bobble: _bobble,
                      onBack: () {
                        AppSpeech.stop();
                        Navigator.of(context).pop();
                      },
                      onSpeakEncourage: () =>
                          AppSpeech.speak(context, _encouragement),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      responsive.horizontalPadding,
                      8,
                      responsive.horizontalPadding,
                      24,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: FadeTransition(
                        opacity: _fade,
                        child: SlideTransition(
                          position: _slide,
                          child: Column(
                            children: [
                              _MissionBadge(
                                accent: accent,
                                label: 'goodHabits.starBadge'.tr(),
                              ),
                              const SizedBox(height: 14),
                              _WhyPanel(
                                accent: accent,
                                title: 'goodHabits.whyTitle'.tr(),
                                body: _about,
                                onSpeak: () => _speakPart(
                                  'goodHabits.whyTitle'.tr(),
                                  _about,
                                ),
                              ),
                              const SizedBox(height: 14),
                              _SparkTipPanel(
                                accent: accent,
                                title: 'goodHabits.tipTitle'.tr(),
                                body: _tip,
                                onSpeak: () => _speakPart(
                                  'goodHabits.tipTitle'.tr(),
                                  _tip,
                                ),
                              ),
                              const SizedBox(height: 14),
                              _TryMissionPanel(
                                accent: accent,
                                title: 'goodHabits.tryTitle'.tr(),
                                body: _try,
                                remember: 'goodHabits.rememberTitle'.tr(),
                                name: _name,
                                onSpeak: () => _speakPart(
                                  'goodHabits.tryTitle'.tr(),
                                  _try,
                                ),
                              ),
                              const SizedBox(height: 18),
                              _ListenPill(
                                accent: accent,
                                label: 'goodHabits.listenAgain'.tr(),
                                onTap: _speakCurrent,
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _PlayNavBar(
              accent: accent,
              canPrev: _index > 0,
              canNext: _index < total - 1,
              progress: 'goodHabits.progress'.tr(
                namedArgs: {
                  'current': '${_index + 1}',
                  'total': '$total',
                },
              ),
              onPrev: _index > 0 ? () => _goTo(_index - 1) : null,
              onNext: _index < total - 1 ? () => _goTo(_index + 1) : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroZone extends StatelessWidget {
  final double topPad;
  final Color accent;
  final Color soft;
  final String emoji;
  final String categoryTitle;
  final int number;
  final int total;
  final String name;
  final String encouragement;
  final Animation<double> bobble;
  final VoidCallback onBack;
  final VoidCallback onSpeakEncourage;

  const _HeroZone({
    required this.topPad,
    required this.accent,
    required this.soft,
    required this.emoji,
    required this.categoryTitle,
    required this.number,
    required this.total,
    required this.name,
    required this.encouragement,
    required this.bobble,
    required this.onBack,
    required this.onSpeakEncourage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Wavy colored sky
        ClipPath(
          clipper: _WaveClipper(),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(16, topPad + 6, 16, 78),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  accent,
                  Color.lerp(accent, AppColors.accent, 0.35)!,
                  soft,
                ],
                stops: const [0.0, 0.55, 1.0],
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _RoundIconBtn(
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: onBack,
                    ),
                    Expanded(
                      child: Text(
                        categoryTitle,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.heading3.copyWith(
                          color: AppColors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 42),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _GlassPill(
                      child: Text(
                        'goodHabits.progress'.tr(
                          namedArgs: {
                            'current': '$number',
                            'total': '$total',
                          },
                        ),
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const Spacer(),
                    AnimatedBuilder(
                      animation: bobble,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, -4 + bobble.value * 8),
                          child: child,
                        );
                      },
                      child: Text(emoji, style: const TextStyle(fontSize: 34)),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading1.copyWith(
                    color: AppColors.white,
                    fontSize: 28,
                    height: 1.15,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.18),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                GestureDetector(
                  onTap: onSpeakEncourage,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.white.withValues(alpha: 0.35),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.auto_awesome,
                            color: accent,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            encouragement,
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.white,
                              fontSize: 13.5,
                              height: 1.3,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: topPad + 90,
          left: 18,
          child: _Dot(color: AppColors.white.withValues(alpha: 0.55), size: 10),
        ),
        Positioned(
          top: topPad + 130,
          right: 28,
          child: _Dot(
              color: AppColors.goodHabitsSparkDot.withValues(alpha: 0.8),
              size: 14),
        ),
        Positioned(
          top: topPad + 70,
          right: 70,
          child: _Dot(color: AppColors.white.withValues(alpha: 0.4), size: 7),
        ),
      ],
    );
  }
}

class _MissionBadge extends StatelessWidget {
  final Color accent;
  final String label;

  const _MissionBadge({required this.accent, required this.label});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: accent.withValues(alpha: 0.35), width: 2),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.18),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.emoji_events_rounded, color: accent, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyles.body.copyWith(
                color: accent,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WhyPanel extends StatelessWidget {
  final Color accent;
  final String title;
  final String body;
  final VoidCallback onSpeak;

  const _WhyPanel({
    required this.accent,
    required this.title,
    required this.body,
    required this.onSpeak,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.lerp(accent, AppColors.white, 0.88)!,
            AppColors.white,
          ],
        ),
        border: Border.all(color: accent.withValues(alpha: 0.22), width: 2),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.1),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: AppColors.white,
                  size: 24,
                ),
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
              _SpeakHintIcon(accent: accent),
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
    );

    return _TapToSpeak(radius: 26, onSpeak: onSpeak, child: card);
  }
}

class _SparkTipPanel extends StatelessWidget {
  final Color accent;
  final String title;
  final String body;
  final VoidCallback onSpeak;

  const _SparkTipPanel({
    required this.accent,
    required this.title,
    required this.body,
    required this.onSpeak,
  });

  @override
  Widget build(BuildContext context) {
    final tipColor = Color.lerp(accent, AppColors.accent, 0.55)!;

    final card = Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
          decoration: BoxDecoration(
            color: AppColors.goodHabitsTipCardBg,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color: accent.withValues(alpha: 0.22),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: tipColor.withValues(alpha: 0.2),
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
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [tipColor, accent],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.lightbulb_rounded,
                      color: AppColors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyles.heading3.copyWith(
                        fontSize: 18,
                        color: Color.lerp(
                            accent, AppColors.goodHabitsTipTitleWarm, 0.3),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _SpeakHintIcon(accent: accent),
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
        Positioned(
          top: -8,
          right: 28,
          child: Transform.rotate(
            angle: 0.2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: tipColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '✨',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ),
      ],
    );

    return _TapToSpeak(radius: 26, onSpeak: onSpeak, child: card);
  }
}

class _TryMissionPanel extends StatelessWidget {
  final Color accent;
  final String title;
  final String body;
  final String remember;
  final String name;
  final VoidCallback onSpeak;

  const _TryMissionPanel({
    required this.accent,
    required this.title,
    required this.body,
    required this.remember,
    required this.name,
    required this.onSpeak,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: accent.withValues(alpha: 0.22), width: 2),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.1),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: accent.withValues(alpha: 0.35),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.flag_rounded,
                  color: accent,
                  size: 26,
                ),
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
              _SpeakHintIcon(accent: accent),
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
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: accent.withValues(alpha: 0.08),
              border: Border.all(
                color: accent.withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle_rounded, color: accent, size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyles.body.copyWith(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                      children: [
                        TextSpan(
                          text: '$remember: ',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        TextSpan(
                          text: name,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: accent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return _TapToSpeak(radius: 26, onSpeak: onSpeak, child: card);
  }
}

/// Small speaker hint on each card so kids know a tap will read it aloud.
class _SpeakHintIcon extends StatelessWidget {
  final Color accent;

  const _SpeakHintIcon({required this.accent});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.volume_up_rounded,
      size: 20,
      color: accent.withValues(alpha: 0.7),
    );
  }
}

/// Makes a story card tappable: light haptic + speaks its title and body,
/// matching the tap-to-hear behaviour of other detail screens.
class _TapToSpeak extends StatelessWidget {
  final double radius;
  final VoidCallback onSpeak;
  final Widget child;

  const _TapToSpeak({
    required this.radius,
    required this.onSpeak,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          AppHapticFeedback.light();
          onSpeak();
        },
        borderRadius: BorderRadius.circular(radius),
        child: child,
      ),
    );
  }
}

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
      color: Colors.transparent,
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
                Color.lerp(accent, AppColors.habitsDaily, 0.35)!,
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

class _PlayNavBar extends StatelessWidget {
  final Color accent;
  final bool canPrev;
  final bool canNext;
  final String progress;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;

  const _PlayNavBar({
    required this.accent,
    required this.canPrev,
    required this.canNext,
    required this.progress,
    this.onPrev,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 14),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 14,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            _NavCircle(
              accent: accent,
              enabled: canPrev,
              icon: Icons.arrow_back_rounded,
              onTap: onPrev,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      progress,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w800,
                        color: accent,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _NavCircle(
              accent: accent,
              enabled: canNext,
              icon: Icons.arrow_forward_rounded,
              filled: true,
              onTap: onNext,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavCircle extends StatelessWidget {
  final Color accent;
  final bool enabled;
  final IconData icon;
  final bool filled;
  final VoidCallback? onTap;

  const _NavCircle({
    required this.accent,
    required this.enabled,
    required this.icon,
    this.filled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = !enabled
        ? accent.withValues(alpha: 0.18)
        : filled
            ? accent
            : Color.lerp(AppColors.white, accent, 0.12)!;
    final fg = !enabled
        ? AppColors.white.withValues(alpha: 0.7)
        : filled
            ? AppColors.white
            : accent;

    return Material(
      color: bg,
      shape: const CircleBorder(),
      elevation: enabled && filled ? 3 : 0,
      shadowColor: accent.withValues(alpha: 0.4),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: enabled ? onTap : null,
        child: SizedBox(
          width: 52,
          height: 52,
          child: Icon(icon, color: fg, size: 26),
        ),
      ),
    );
  }
}

class _RoundIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _RoundIconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white.withValues(alpha: 0.22),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(icon, color: AppColors.white, size: 20),
        ),
      ),
    );
  }
}

class _GlassPill extends StatelessWidget {
  final Widget child;

  const _GlassPill({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.35)),
      ),
      child: child,
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  final double size;

  const _Dot({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height - 36)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height,
        size.width * 0.5,
        size.height - 22,
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height - 44,
        size.width,
        size.height - 18,
      )
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
