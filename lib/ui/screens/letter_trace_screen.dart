import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/native_script_data.dart';
import '../../data/numbers_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import '../widgets/home_play_background.dart';
import 'letter_trace_alphabet_screen.dart';
import 'letter_trace_native_script_screen.dart';
import 'letter_trace_numbers_screen.dart';

/// Hub: choose Alphabets, Numbers, or Swar/Kakko inside Trace & Write.
class LetterTraceScreen extends StatefulWidget {
  const LetterTraceScreen({super.key});

  @override
  State<LetterTraceScreen> createState() => _LetterTraceScreenState();
}

class _LetterTraceScreenState extends State<LetterTraceScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _enter;

  @override
  void initState() {
    super.initState();
    _enter = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
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
    final glyphs = NumbersData.glyphsKey.tr();
    final numberRange = NumbersData.formatDigitRange(1, 100, glyphs);
    final lang = context.locale.languageCode;
    final showNativeScript = NativeScriptData.supportsTraceLocale(lang);
    final swar = NativeScriptData.swarFor(lang);
    final scriptBadge = swar.isNotEmpty ? swar.first.glyph : 'अ';

    final categories = <_TraceCategory>[
      _TraceCategory(
        title: 'letterTrace.sections.alphabets.title'.tr(),
        subtitle: 'letterTrace.sections.alphabets.subtitle'.tr(),
        badge: 'A',
        color: const Color(0xFFFF6B6B),
        softFill: const Color(0xFFFFF5F5),
        onTap: () => _open(context, const LetterTraceAlphabetScreen()),
      ),
      _TraceCategory(
        title: 'letterTrace.sections.numbers.title'.tr(),
        subtitle: 'letterTrace.sections.numbers.subtitle'.tr(
          namedArgs: {'range': numberRange},
        ),
        badge: NumbersData.formatDigits(1, glyphs),
        color: const Color(0xFF4D96FF),
        softFill: const Color(0xFFF3F7FF),
        onTap: () => _open(context, const LetterTraceNumbersScreen()),
      ),
      if (showNativeScript)
        _TraceCategory(
          title: 'letterTrace.sections.nativeScript.title'.tr(),
          subtitle: 'letterTrace.sections.nativeScript.hubSubtitle'.tr(),
          badge: scriptBadge,
          color: const Color(0xFF43B56B),
          softFill: const Color(0xFFF2FAF4),
          onTap: () => _open(context, const LetterTraceNativeScriptScreen()),
        ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('letterTrace.title'.tr()),
      ),
      body: HomePlayBackground(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.fromLTRB(pad, 12, pad, 28),
            children: [
              _TraceHubHero(
                title: 'letterTrace.title'.tr(),
                subtitle: 'letterTrace.hubSubtitle'.tr(),
              ),
              const SizedBox(height: 18),
              for (var i = 0; i < categories.length; i++) ...[
                if (i > 0) const SizedBox(height: 12),
                _StaggerIn(
                  controller: _enter,
                  index: i,
                  child: _TraceCategoryCard(category: categories[i]),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _open(BuildContext context, Widget screen) {
    AppHapticFeedback.medium();
    AppSpeech.stop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => screen),
    );
  }
}

class _TraceCategory {
  final String title;
  final String subtitle;
  final String badge;
  final Color color;
  final Color softFill;
  final VoidCallback onTap;

  const _TraceCategory({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.color,
    required this.softFill,
    required this.onTap,
  });
}

class _TraceHubHero extends StatelessWidget {
  final String title;
  final String subtitle;

  const _TraceHubHero({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final titleSize =
        (context.responsive.width * 0.07).clamp(24.0, 32.0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFF3D0),
            Color(0xFFE8FBF8),
            Color(0xFFFFE8F0),
          ],
        ),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.55),
          width: 2.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.22),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -8,
            top: -10,
            child: Icon(
              Icons.draw_rounded,
              size: 72,
              color: AppColors.secondary.withValues(alpha: 0.16),
            ),
          ),
          Positioned(
            right: 36,
            bottom: -4,
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 28,
              color: AppColors.primary.withValues(alpha: 0.28),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.25),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.edit_rounded,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 6),
                    Text('✍️', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: AppTextStyles.heading1.copyWith(
                  fontSize: titleSize,
                  color: AppColors.textPrimary,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: AppTextStyles.body.copyWith(
                  fontSize: 15,
                  height: 1.35,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TraceCategoryCard extends StatefulWidget {
  final _TraceCategory category;

  const _TraceCategoryCard({required this.category});

  @override
  State<_TraceCategoryCard> createState() => _TraceCategoryCardState();
}

class _TraceCategoryCardState extends State<_TraceCategoryCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.category;

    return AnimatedScale(
      scale: _pressed ? 0.98 : 1,
      duration: const Duration(milliseconds: 100),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: c.onTap,
          onHighlightChanged: (v) => setState(() => _pressed = v),
          child: Ink(
            decoration: BoxDecoration(
              color: c.softFill,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: c.color.withValues(alpha: 0.38),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: c.color.withValues(alpha: 0.14),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
              child: Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: c.color.withValues(alpha: 0.4),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: c.color.withValues(alpha: 0.16),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          c.badge,
                          style: AppTextStyles.heading2.copyWith(
                            color: c.color,
                            fontSize: 24,
                            height: 1,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          c.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.heading3.copyWith(
                            fontSize: 17,
                            height: 1.2,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          c.subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.body.copyWith(
                            fontSize: 12.5,
                            height: 1.3,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: c.color.withValues(alpha: 0.85),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StaggerIn extends StatelessWidget {
  final AnimationController controller;
  final int index;
  final Widget child;

  const _StaggerIn({
    required this.controller,
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final start = (0.1 * index).clamp(0.0, 0.45);
    final end = (start + 0.5).clamp(0.0, 1.0);
    final animation = CurvedAnimation(
      parent: controller,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.08),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
