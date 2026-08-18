import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/stories_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import '../../utils/story_content_loader.dart';

/// Storybook reader — flowing story text, cover art, moral, read-aloud.
class StoryReaderScreen extends StatefulWidget {
  final int initialIndex;

  const StoryReaderScreen({
    super.key,
    required this.initialIndex,
  });

  @override
  State<StoryReaderScreen> createState() => _StoryReaderScreenState();
}

class _StoryReaderScreenState extends State<StoryReaderScreen>
    with SingleTickerProviderStateMixin {
  late int _index;
  late AnimationController _enter;
  late Animation<double> _fade;
  final ScrollController _scroll = ScrollController();

  /// True only while the full story read-aloud is active — not title intro TTS.
  final ValueNotifier<bool> _storyPlaying = ValueNotifier(false);

  StoryItem get _story => StoriesData.itemAt(_index);

  StoryContent get _content => StoryContentLoader.contentFor(_story.id);

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex.clamp(0, StoriesData.items.length - 1);
    _enter = AnimationController(
      duration: const Duration(milliseconds: 550),
      vsync: this,
    );
    _fade = CurvedAnimation(parent: _enter, curve: Curves.easeOut);
    _enter.forward();
    AppSpeech.isSpeaking.addListener(_onSpeechFlagChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) => _speakIntro());
  }

  @override
  void dispose() {
    AppSpeech.isSpeaking.removeListener(_onSpeechFlagChanged);
    AppSpeech.stop();
    _storyPlaying.dispose();
    _enter.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _onSpeechFlagChanged() {
    // When TTS finishes/stops, clear the story-play UI if it was on.
    if (!AppSpeech.isSpeaking.value && _storyPlaying.value) {
      _storyPlaying.value = false;
    }
  }

  void _speakIntro() {
    _storyPlaying.value = false;
    final c = _content;
    AppSpeech.speak(context, '${c.title}. ${c.subtitle}');
  }

  void _speakFull() {
    AppHapticFeedback.light();
    _storyPlaying.value = true;
    AppSpeech.speak(context, _content.fullSpeakText);
  }

  void _toggleStoryAudio() {
    if (_storyPlaying.value) {
      AppHapticFeedback.light();
      _storyPlaying.value = false;
      AppSpeech.stop();
    } else {
      // Stop title intro if still speaking, then play full story.
      AppSpeech.stop();
      _speakFull();
    }
  }

  void _goTo(int next) {
    if (next < 0 || next >= StoriesData.items.length) return;
    AppHapticFeedback.success();
    if (_scroll.hasClients) _scroll.jumpTo(0);
    setState(() => _index = next);
    _enter.reset();
    _fade = CurvedAnimation(parent: _enter, curve: Curves.easeOut);
    _enter.forward();
    _speakIntro();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final story = _story;
    final content = _content;
    final accent = story.accentColor;
    final topPad = MediaQuery.paddingOf(context).top;
    final total = StoriesData.items.length;

    return PopScope(
      onPopInvokedWithResult: (didPop, _) => AppSpeech.stop(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF8F0),
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                controller: _scroll,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: _StoryCover(
                      topPad: topPad,
                      story: story,
                      title: content.title,
                      subtitle: content.subtitle,
                      onBack: () {
                        AppSpeech.stop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      responsive.horizontalPadding,
                     16,
                      responsive.horizontalPadding,
                      16,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: FadeTransition(
                        opacity: _fade,
                        child: Column(
                          children: [
                            _ListenButton(
                              accent: accent,
                              playingListenable: _storyPlaying,
                              onToggle: _toggleStoryAudio,
                            ),
                            const SizedBox(height: 16),
                            _StoryBookPage(
                              paragraphs: content.paragraphs,
                              accent: accent,
                              onTap: _toggleStoryAudio,
                            ),
                            const SizedBox(height: 18),
                            _MoralPanel(
                              moral: content.moral,
                              accent: accent,
                              onSpeak: () {
                                AppHapticFeedback.light();
                                AppSpeech.speak(
                                  context,
                                  '${'stories.moralTitle'.tr()}. ${content.moral}',
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_index > 0 || _index < total - 1)
              _StorySwitcherBar(
                accent: accent,
                canPrev: _index > 0,
                canNext: _index < total - 1,
                onPrev: _index > 0 ? () => _goTo(_index - 1) : null,
                onNext:
                    _index < total - 1 ? () => _goTo(_index + 1) : null,
              ),
          ],
        ),
      ),
    );
  }
}

class _StoryCover extends StatelessWidget {
  final double topPad;
  final StoryItem story;
  final String title;
  final String subtitle;
  final VoidCallback onBack;

  const _StoryCover({
    required this.topPad,
    required this.story,
    required this.title,
    required this.subtitle,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 12 / 10,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                story.imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => ColoredBox(
                  color: story.accentColor.withValues(alpha: 0.25),
                  child: Center(
                    child: Text(
                      story.emoji,
                      style: const TextStyle(fontSize: 64),
                    ),
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.3),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.62),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: topPad + 8,
          left: 10,
          child: Material(
            color: Colors.white.withValues(alpha: 0.92),
            shape: const CircleBorder(),
            elevation: 2,
            child: InkWell(
              onTap: onBack,
              customBorder: const CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 18,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.heading1.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                  shadows: const [
                    Shadow(
                      color: Colors.black45,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.body.copyWith(
                    color: Colors.white.withValues(alpha: 0.95),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    shadows: const [
                      Shadow(color: Colors.black38, blurRadius: 6),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ListenButton extends StatelessWidget {
  final Color accent;
  final ValueListenable<bool> playingListenable;
  final VoidCallback onToggle;

  const _ListenButton({
    required this.accent,
    required this.playingListenable,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: playingListenable,
      builder: (context, playing, _) {
        final label = playing
            ? 'stories.tapToPause'.tr()
            : 'stories.readAloud'.tr();

        return Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              color: playing
                  ? accent.withValues(alpha: 0.2)
                  : accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(18),
              border: playing
                  ? Border.all(color: accent.withValues(alpha: 0.45), width: 2)
                  : null,
            ),
            child: InkWell(
              onTap: onToggle,
              borderRadius: BorderRadius.circular(18),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: accent,
                        shape: BoxShape.circle,
                        border: playing
                            ? Border.all(color: accent, width: 2)
                            : null,
                        boxShadow: [
                          BoxShadow(
                            color: accent.withValues(alpha: playing ? 0.25 : 0.4),
                            blurRadius: playing ? 12 : 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                      Icons.volume_up_rounded,
                        color:Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        label,
                        style: AppTextStyles.bodyBold.copyWith(
                          color: accent,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        playing
                            ? Icons.pause_circle_filled_rounded
                            : Icons.play_circle_fill_rounded,
                        key: ValueKey(playing),
                        color: accent,
                        size: 36,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// One open storybook page — all paragraphs flow together, no numbering.
class _StoryBookPage extends StatelessWidget {
  final List<String> paragraphs;
  final Color accent;
  final VoidCallback onTap;

  const _StoryBookPage({
    required this.paragraphs,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bodyStyle = GoogleFonts.lora(
      fontSize: 17,
      height: 1.75,
      color: const Color(0xFF3E2723),
      fontWeight: FontWeight.w500,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBF2),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: accent.withValues(alpha: 0.28),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.12),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: Colors.brown.withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 24, 22, 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < paragraphs.length; i++) ...[
                  if (i > 0) const SizedBox(height: 18),
                  _StoryParagraph(
                    text: paragraphs[i],
                    isFirst: i == 0,
                    style: bodyStyle,
                    accent: accent,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StoryParagraph extends StatelessWidget {
  final String text;
  final bool isFirst;
  final TextStyle style;
  final Color accent;

  const _StoryParagraph({
    required this.text,
    required this.isFirst,
    required this.style,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    if (!isFirst || text.isEmpty) {
      return Text(text, style: style, textAlign: TextAlign.justify);
    }

    final first = text.characters.first;
    final rest = text.characters.skip(1).toString();

    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        style: style,
        children: [
          TextSpan(
            text: first,
            style: style.copyWith(
              fontSize: 42,
              fontWeight: FontWeight.w700,
              color: accent,
              height: 1.0,
            ),
          ),
          TextSpan(text: rest),
        ],
      ),
    );
  }
}

class _MoralPanel extends StatelessWidget {
  final String moral;
  final Color accent;
  final VoidCallback onSpeak;

  const _MoralPanel({
    required this.moral,
    required this.accent,
    required this.onSpeak,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onSpeak,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFF8E1), Color(0xFFFFECB3)],
            ),
            border: Border.all(
              color: const Color(0xFFFFB300).withValues(alpha: 0.6),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFB300).withValues(alpha: 0.22),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('🌟', style: TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'stories.moralTitle'.tr(),
                      style: AppTextStyles.heading3.copyWith(
                        color: const Color(0xFFE65100),
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      moral,
                      style: GoogleFonts.lora(
                        fontSize: 16,
                        height: 1.55,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StorySwitcherBar extends StatelessWidget {
  final Color accent;
  final bool canPrev;
  final bool canNext;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;

  const _StorySwitcherBar({
    required this.accent,
    required this.canPrev,
    required this.canNext,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (canPrev)
              Expanded(
                child: _SwitcherBtn(
                  label: 'stories.prevStory'.tr(),
                  icon: Icons.arrow_back_rounded,
                  accent: accent,
                  onTap: onPrev!,
                ),
              ),
            if (canPrev && canNext) const SizedBox(width: 10),
            if (canNext)
              Expanded(
                child: _SwitcherBtn(
                  label: 'stories.nextStory'.tr(),
                  icon: Icons.arrow_forward_rounded,
                  accent: accent,
                  iconAfter: true,
                  onTap: onNext!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SwitcherBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color accent;
  final bool iconAfter;
  final VoidCallback onTap;

  const _SwitcherBtn({
    required this.label,
    required this.icon,
    required this.accent,
    required this.onTap,
    this.iconAfter = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: accent.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () {
          AppHapticFeedback.light();
          onTap();
        },
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!iconAfter) ...[
                Icon(icon, color: accent, size: 20),
                const SizedBox(width: 6),
              ],
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption.copyWith(
                    color: accent,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
              if (iconAfter) ...[
                const SizedBox(width: 6),
                Icon(icon, color: accent, size: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
