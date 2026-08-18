import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import '../models/learning_detail_page.dart';
import '../widgets/kid_alphabet_style_detail.dart';

class KidLearningDetailScreen extends StatefulWidget {
  final String moduleTitle;
  final int initialIndex;
  final List<LearningDetailPage> pages;
  final List<Color>? accentColors;

  const KidLearningDetailScreen({
    super.key,
    required this.moduleTitle,
    required this.initialIndex,
    required this.pages,
    this.accentColors,
  });

  static Future<void> open(
    BuildContext context, {
    required String moduleTitle,
    required int initialIndex,
    required List<LearningDetailPage> pages,
    List<Color>? accentColors,
  }) {
    AppHapticFeedback.medium();
    return Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (context, animation, secondary) => KidLearningDetailScreen(
          moduleTitle: moduleTitle,
          initialIndex: initialIndex,
          pages: pages,
          accentColors: accentColors,
        ),
        transitionsBuilder: (context, animation, secondary, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  @override
  State<KidLearningDetailScreen> createState() =>
      _KidLearningDetailScreenState();
}

class _KidLearningDetailScreenState extends State<KidLearningDetailScreen>
    with TickerProviderStateMixin {
  late int _index;
  late AnimationController _animController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex.clamp(0, widget.pages.length - 1);
    _animController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _setupAnimations();
    _animController.forward();
    _scrollController.addListener(() {
      final scrolled = _scrollController.offset > 30;
      if (scrolled != _isScrolled) setState(() => _isScrolled = scrolled);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _speakCurrent());
  }

  void _setupAnimations() {
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeIn),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    AppSpeech.stop();
    _animController.dispose();
    _scaleController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _leaveScreen() {
    AppSpeech.stop();
    Navigator.of(context).pop();
  }

  LearningDetailPage get _page => widget.pages[_index];

  Color get _color {
    if (widget.accentColors != null && _index < widget.accentColors!.length) {
      return widget.accentColors![_index];
    }
    return AppColors.getLetterColor(_index);
  }

  String get _encouragement =>
      'learningDetail.encouragement.${_index % 6}'.tr();

  void _speakCurrent() => AppSpeech.speak(
        context,
        _page.speakText,
        languageCode: _page.speakLanguageCode,
      );

  void _speakSection(String title, String body) {
    AppSpeech.speakMixed(
      context,
      KidAlphabetStyleDetail.sectionSpeakText(title, body),
      scriptLanguageCode: _page.speakLanguageCode,
    );
  }

  void _goTo(int newIndex) {
    if (newIndex < 0 || newIndex >= widget.pages.length) return;
    AppHapticFeedback.success();
    if (_scrollController.hasClients) _scrollController.jumpTo(0);
    setState(() => _index = newIndex);
    _animController.reset();
    _setupAnimations();
    _animController.forward();
    _speakCurrent();
  }

  String _sectionTitle(String? customKey, String defaultKey) {
    if (customKey != null && customKey.isNotEmpty) return customKey.tr();
    return defaultKey.tr();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final page = _page;
    final appBarTitle = _isScrolled
        ? (page.oppositePairLayout && page.subtitle != null
            ? '${page.title} · ${page.subtitle}'
            : page.title)
        : widget.moduleTitle;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        AppSpeech.stop();
      },
      child: Scaffold(
      backgroundColor: KidAlphabetStyleDetail.creamBackground,
      appBar: KidAlphabetStyleDetail.appBar(
        isScrolled: _isScrolled,
        accentColor: _color,
        title: appBarTitle,
        onBack: _leaveScreen,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.horizontalPadding,
                  vertical: 8,
                ),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        KidAlphabetStyleDetail.progress(
                          accentColor: _color,
                          currentIndex: _index,
                          totalCount: widget.pages.length,
                        ),
                        const SizedBox(height: 16),
                        KidAlphabetStyleDetail.encouragement(
                          accentColor: _color,
                          message: _encouragement,
                          onSpeak: () =>
                              AppSpeech.speak(context, _encouragement),
                        ),
                        const SizedBox(height: 16),
                        _buildHero(context, page),
                        const SizedBox(height: 16),
                        if (page.oppositePairLayout &&
                            page.subtitle != null &&
                            page.subtitle!.trim().isNotEmpty)
                          KidAlphabetStyleDetail.oppositeTitleRow(
                            context: context,
                            left: page.title,
                            right: page.subtitle!,
                            accentColor: _color,
                          )
                        else ...[
                          KidAlphabetStyleDetail.titleText(
                            text: page.title,
                            accentColor: _color,
                          ),
                        ],
                        if (page.extraSections != null &&
                            page.extraSections!.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          ...page.extraSections!,
                        ],
                        if (page.about.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          KidAlphabetStyleDetail.heartDivider(_color),
                          const SizedBox(height: 16),
                          KidAlphabetStyleDetail.aboutCard(
                            accentColor: _color,
                            title: _sectionTitle(
                              page.aboutTitle,
                              'learningDetail.aboutTitle',
                            ),
                            body: page.about,
                            onSpeak: () => _speakSection(
                              _sectionTitle(
                                page.aboutTitle,
                                'learningDetail.aboutTitle',
                              ),
                              page.about,
                            ),
                          ),
                        ],
                        if (page.funFact.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          KidAlphabetStyleDetail.heartDivider(_color),
                          const SizedBox(height: 16),
                          KidAlphabetStyleDetail.funFactCard(
                            accentColor: _color,
                            title: _sectionTitle(
                              page.funFactTitle,
                              'learningDetail.funFactTitle',
                            ),
                            body: page.funFact,
                            onSpeak: () => _speakSection(
                              _sectionTitle(
                                page.funFactTitle,
                                'learningDetail.funFactTitle',
                              ),
                              page.funFact,
                            ),
                          ),
                        ],
                        if (page.exampleWords != null &&
                            page.exampleWords!.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          KidAlphabetStyleDetail.heartDivider(_color),
                          const SizedBox(height: 16),
                          KidAlphabetStyleDetail.exampleWordsSection(
                            accentColor: _color,
                            title: page.exampleWordsTitle ??
                                'nativeScript.exampleWordsTitle'
                                    .tr(namedArgs: {'name': page.title}),
                            words: page.exampleWords!,
                            onSpeakWord: (word) => AppSpeech.speak(
                              context,
                              word,
                              languageCode: _page.speakLanguageCode,
                            ),
                          ),
                        ],
                        if (page.tryThis.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          KidAlphabetStyleDetail.heartDivider(_color),
                          const SizedBox(height: 16),
                          KidAlphabetStyleDetail.tryCard(
                            accentColor: _color,
                            title: _sectionTitle(
                              page.tryTitle,
                              'learningDetail.tryTitle',
                            ),
                            body: page.tryThis,
                            onSpeak: () => _speakSection(
                              _sectionTitle(
                                page.tryTitle,
                                'learningDetail.tryTitle',
                              ),
                              page.tryThis,
                            ),
                          ),
                        ],
                        const SizedBox(height: 20),
                        KidAlphabetStyleDetail.listenAgainButton(
                          accentColor: _color,
                          onPressed: _speakCurrent,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            KidAlphabetStyleDetail.navigationBar(
              responsive: responsive,
              accentColor: _color,
              canPrevious: _index > 0,
              canNext: _index < widget.pages.length - 1,
              onPrevious: _index > 0 ? () => _goTo(_index - 1) : null,
              onNext: _index < widget.pages.length - 1
                  ? () => _goTo(_index + 1)
                  : null,
              scaleAnimation: _scaleController,
            ),
          ],
        ),
      ),
    ),
    );
  }

  Widget _buildHero(BuildContext context, LearningDetailPage page) {
    final responsive = context.responsive;
    final emojiSize =
        responsive.emojiSize(factor: 0.30, min: 88, max: 118);

    if (page.hero != null) {
      if (!page.heroInCircle) {
        return page.hero!;
      }
      return KidAlphabetStyleDetail.circleHero(
        accentColor: _color,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: page.hero!,
        ),
      );
    }

    final emoji = page.emoji ?? '⭐';
    return KidAlphabetStyleDetail.circleHero(
      accentColor: _color,
      heroTag: 'kid_detail_${page.title}_$_index',
      child: Text(
        emoji,
        style: TextStyle(fontSize: emojiSize),
      ),
    );
  }
}
