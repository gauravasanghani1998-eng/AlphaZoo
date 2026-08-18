import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/community_helpers_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';

/// Detail palette follows each helper's accent — AppBar/bg are not fixed mint.
class CommunityHelpersDetailScreen extends StatefulWidget {
  final int initialIndex;

  const CommunityHelpersDetailScreen({
    super.key,
    required this.initialIndex,
  });

  @override
  State<CommunityHelpersDetailScreen> createState() =>
      _CommunityHelpersDetailScreenState();
}

class _CommunityHelpersDetailScreenState
    extends State<CommunityHelpersDetailScreen>
    with SingleTickerProviderStateMixin {
  late int _index;
  late AnimationController _enter;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  final ScrollController _scroll = ScrollController();

  CommunityHelperItem get _item => CommunityHelpersData.items[_index];

  String get _name => _item.nameKey.tr();

  String get _subtitle => _item.subtitleKey.tr();

  String get _id {
    final parts = _item.nameKey.split('.');
    return parts.isNotEmpty ? parts.last : _item.nameKey;
  }

  String get _about => 'communityHelpers.detail.$_id.about'
      .tr(namedArgs: {'name': _name});

  String get _funFact => 'communityHelpers.detail.$_id.funFact'
      .tr(namedArgs: {'name': _name});

  String get _try =>
      'communityHelpers.detail.$_id.try'.tr(namedArgs: {'name': _name});

  Color get _accent => AppColors.helpersAccent(_index);

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex.clamp(0, CommunityHelpersData.items.length - 1);
    _enter = AnimationController(
      duration: const Duration(milliseconds: 420),
      vsync: this,
    );
    _setupAnims();
    _enter.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) => _speakName());
  }

  void _setupAnims() {
    _fade = CurvedAnimation(parent: _enter, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _enter, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    AppSpeech.stop();
    _enter.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _speakName() => AppSpeech.speak(context, _name);

  void _speakPart(String title, String body) {
    final t = title.trim();
    final b = body.trim();
    AppSpeech.speak(context, t.isEmpty ? b : '$t. $b');
  }

  void _goTo(int next) {
    if (next < 0 || next >= CommunityHelpersData.items.length) return;
    AppHapticFeedback.success();
    if (_scroll.hasClients) _scroll.jumpTo(0);
    setState(() => _index = next);
    _enter.reset();
    _setupAnims();
    _enter.forward();
    _speakName();
  }

  @override
  Widget build(BuildContext context) {
    final pad = context.responsive.horizontalPadding;
    final total = CommunityHelpersData.items.length;
    final accent = _accent;
    final aboutTitle = 'learningDetail.aboutTitle'.tr();
    final funTitle = 'learningDetail.funFactTitle'.tr();
    final tryTitle = 'learningDetail.tryTitle'.tr();

    return PopScope(
      onPopInvokedWithResult: (didPop, result) => AppSpeech.stop(),
      child: Scaffold(
        backgroundColor: AppColors.goodHabitsDetailBg,
        appBar: AppBar(
          backgroundColor: accent,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: Colors.white,
            onPressed: () {
              AppSpeech.stop();
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            _name,
            style: AppTextStyles.heading3.copyWith(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: FadeTransition(
                opacity: _fade,
                child: SlideTransition(
                  position: _slide,
                  child: SingleChildScrollView(
                    controller: _scroll,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(pad, 14, pad, 22),
                    child: Column(
                      children: [
                        _HelperHeroCard(
                          accent: accent,
                          emoji: _item.emoji,
                          name: _name,
                          subtitle: _subtitle,
                          helperOf: 'communityHelpers.helperOf'.tr(
                            namedArgs: {
                              'current': '${_index + 1}',
                              'total': '$total',
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        _AboutPanel(
                          accent: accent,
                          title: aboutTitle,
                          body: _about,
                          onSpeak: () => _speakPart(aboutTitle, _about),
                        ),
                        const SizedBox(height: 14),
                        _FunPanel(
                          accent: accent,
                          title: funTitle,
                          body: _funFact,
                          onSpeak: () => _speakPart(funTitle, _funFact),
                        ),
                        const SizedBox(height: 14),
                        _TryPanel(
                          accent: accent,
                          title: tryTitle,
                          body: _try,
                          onSpeak: () => _speakPart(tryTitle, _try),
                        ),
                        const SizedBox(height: 18),
                        _HearNameButton(
                          accent: accent,
                          label: 'communityHelpers.hearName'.tr(),
                          onTap: _speakName,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _PrevNextBar(
              accent: accent,
              canPrev: _index > 0,
              canNext: _index < total - 1,
              onPrev: _index > 0 ? () => _goTo(_index - 1) : null,
              onNext: _index < total - 1 ? () => _goTo(_index + 1) : null,
            ),
          ],
        ),
      ),
    );
  }
}

/// Light pastel gradient hero — soft, not dark solid accent.
class _HelperHeroCard extends StatelessWidget {
  final Color accent;
  final String emoji;
  final String name;
  final String subtitle;
  final String helperOf;

  const _HelperHeroCard({
    required this.accent,
    required this.emoji,
    required this.name,
    required this.subtitle,
    required this.helperOf,
  });

  @override
  Widget build(BuildContext context) {
    final lightA = Color.lerp(accent, Colors.white, 0.42)!;
    final lightB = Color.lerp(accent, const Color(0xFFFFF6E8), 0.28)!;
    final lightC = Color.lerp(accent, const Color(0xFFFFB74D), 0.35)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [lightA, lightB, lightC],
        ),
        border: Border.all(color: accent.withValues(alpha: 0.28), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.16),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: accent.withValues(alpha: 0.2)),
              ),
              child: Text(
                helperOf,
                style: AppTextStyles.caption.copyWith(
                  color: accent,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: accent.withValues(alpha: 0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: accent.withValues(alpha: 0.14),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 36)),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.heading2.copyWith(
              fontSize: 20,
              height: 1.15,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: accent.withValues(alpha: 0.22)),
            ),
            child: Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.caption.copyWith(
                color: accent,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Matches Good Habits `_WhyPanel` colors / sizes.
class _AboutPanel extends StatelessWidget {
  final Color accent;
  final String title;
  final String body;
  final VoidCallback onSpeak;

  const _AboutPanel({
    required this.accent,
    required this.title,
    required this.body,
    required this.onSpeak,
  });

  @override
  Widget build(BuildContext context) {
    return _TapSpeak(
      onSpeak: onSpeak,
      child: Container(
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
                    Icons.handshake_rounded,
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
    );
  }
}

/// Matches Good Habits `_SparkTipPanel`.
class _FunPanel extends StatelessWidget {
  final Color accent;
  final String title;
  final String body;
  final VoidCallback onSpeak;

  const _FunPanel({
    required this.accent,
    required this.title,
    required this.body,
    required this.onSpeak,
  });

  @override
  Widget build(BuildContext context) {
    final tipColor = Color.lerp(accent, AppColors.accent, 0.55)!;

    return _TapSpeak(
      onSpeak: onSpeak,
      child: Stack(
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
                        gradient: LinearGradient(colors: [tipColor, accent]),
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
                            accent,
                            AppColors.goodHabitsTipTitleWarm,
                            0.3,
                          ),
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
          Positioned(
            top: -8,
            right: 28,
            child: Transform.rotate(
              angle: 0.2,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: tipColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('✨', style: TextStyle(fontSize: 14)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Matches Good Habits `_TryMissionPanel` (without remember footer).
class _TryPanel extends StatelessWidget {
  final Color accent;
  final String title;
  final String body;
  final VoidCallback onSpeak;

  const _TryPanel({
    required this.accent,
    required this.title,
    required this.body,
    required this.onSpeak,
  });

  @override
  Widget build(BuildContext context) {
    return _TapSpeak(
      onSpeak: onSpeak,
      child: Container(
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
                  child: Icon(Icons.flag_rounded, color: accent, size: 26),
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
    );
  }
}

class _TapSpeak extends StatelessWidget {
  final VoidCallback onSpeak;
  final Widget child;

  const _TapSpeak({required this.onSpeak, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          AppHapticFeedback.light();
          onSpeak();
        },
        borderRadius: BorderRadius.circular(26),
        child: child,
      ),
    );
  }
}

class _HearNameButton extends StatelessWidget {
  final Color accent;
  final String label;
  final VoidCallback onTap;

  const _HearNameButton({
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
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.28),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.volume_up_rounded, color: Colors.white, size: 22),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyBold.copyWith(
                    color: Colors.white,
                    fontSize: 15,
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

class _PrevNextBar extends StatelessWidget {
  final Color accent;
  final bool canPrev;
  final bool canNext;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;

  const _PrevNextBar({
    required this.accent,
    required this.canPrev,
    required this.canNext,
    this.onPrev,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: accent.withValues(alpha: 0.15)),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: _NavBtn(
                accent: accent,
                enabled: canPrev,
                label: 'nav.previous'.tr(),
                icon: Icons.arrow_back_rounded,
                isNext: false,
                onTap: onPrev,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _NavBtn(
                accent: accent,
                enabled: canNext,
                label: 'nav.next'.tr(),
                icon: Icons.arrow_forward_rounded,
                isNext: true,
                onTap: onNext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBtn extends StatelessWidget {
  final Color accent;
  final bool enabled;
  final String label;
  final IconData icon;
  final bool isNext;
  final VoidCallback? onTap;

  const _NavBtn({
    required this.accent,
    required this.enabled,
    required this.label,
    required this.icon,
    required this.isNext,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.45,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(18),
          child: Ink(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
            decoration: BoxDecoration(
              color: enabled
                  ? accent
                  : Color.alphaBlend(
                      accent.withValues(alpha: 0.1),
                      Colors.white,
                    ),
              borderRadius: BorderRadius.circular(18),
              border: enabled
                  ? null
                  : Border.all(color: accent.withValues(alpha: 0.28), width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: isNext
                  ? [
                      Flexible(
                        child: Text(
                          label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyBold.copyWith(
                            color: enabled ? Colors.white : accent,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        icon,
                        size: 18,
                        color: enabled ? Colors.white : accent,
                      ),
                    ]
                  : [
                      Icon(
                        icon,
                        size: 18,
                        color: enabled ? Colors.white : accent,
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyBold.copyWith(
                            color: enabled ? Colors.white : accent,
                            fontSize: 14,
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
