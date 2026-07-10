import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../utils/responsive.dart';
import '../widgets/home_play_background.dart';
import 'privacy_policy_screen.dart';
import 'terms_screen.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutCardConfig {
  final String titleKey;
  final String bodyKey;
  final int colorIndex;
  final bool isParagraph;

  const _AboutCardConfig({
    required this.titleKey,
    required this.bodyKey,
    required this.colorIndex,
    this.isParagraph = false,
  });
}

class _AboutScreenState extends State<AboutScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  late AnimationController _bounceController;
  late AnimationController _fadeController;
  late Animation<double> _bounceAnimation;

  static const _cards = [
    _AboutCardConfig(
      titleKey: 'about.appCard.title',
      bodyKey: 'about.appCard.body',
      colorIndex: 0,
      isParagraph: true,
    ),
    _AboutCardConfig(
      titleKey: 'about.features.title',
      bodyKey: 'about.features.body',
      colorIndex: 2,
    ),
    _AboutCardConfig(
      titleKey: 'about.benefits.title',
      bodyKey: 'about.benefits.body',
      colorIndex: 4,
    ),
    _AboutCardConfig(
      titleKey: 'about.offline.title',
      bodyKey: 'about.offline.body',
      colorIndex: 6,
    ),
    _AboutCardConfig(
      titleKey: 'about.howToUse.title',
      bodyKey: 'about.howToUse.body',
      colorIndex: 8,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _bounceAnimation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..forward();

    _scrollController.addListener(() {
      final scrolled = _scrollController.offset > 20;
      if (scrolled != _isScrolled) setState(() => _isScrolled = scrolled);
    });
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _fadeController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: _isScrolled
            ? AppColors.appBarTint.withValues(alpha: 0.97)
            : Colors.transparent,
        elevation: _isScrolled ? 4 : 0,
        shadowColor: Colors.orange.withValues(alpha: 0.2),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.primary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'about.title'.tr(),
          style: AppTextStyles.heading3.copyWith(color: AppColors.primary),
        ),
        centerTitle: true,
      ),
      body: HomePlayBackground(
        child: SafeArea(
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: _fadeController,
              curve: Curves.easeOut,
            ),
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.fromLTRB(
                responsive.horizontalPadding,
                8,
                responsive.horizontalPadding,
                responsive.verticalPadding + 12,
              ),
              child: Column(
                children: [
                  _buildHero(),
                  const SizedBox(height: 22),
                  ..._cards.asMap().entries.map((entry) {
                    final index = entry.key;
                    final card = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(bottom: index < _cards.length - 1 ? 16 : 0),
                      child: _buildInfoCard(
                        title: card.titleKey.tr(),
                        content: card.bodyKey.tr(),
                        accent: AppColors.getLetterColor(card.colorIndex),
                        isParagraph: card.isParagraph,
                      ),
                    );
                  }),
                  const SizedBox(height: 28),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Center(
      child: AnimatedBuilder(
        animation: _bounceAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, -_bounceAnimation.value),
            child: child,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.accent.withValues(alpha: 0.55),
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Image.asset(
            'assets/images/app_logo.png',
            width: 82,
            height: 82,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.menu_book_rounded,
              size: 82,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String content,
    required Color accent,
    bool isParagraph = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: accent.withValues(alpha: 0.38),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.16),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.heading3.copyWith(
              fontSize: 17,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 14),
          if (isParagraph)
            Text(
              content,
              style: AppTextStyles.body.copyWith(
                height: 1.55,
                color: AppColors.textPrimary,
              ),
            )
          else
            _buildContentLines(content, accent),
        ],
      ),
    );
  }

  Widget _buildContentLines(String content, Color accent) {
    final lines = content
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    return Column(
      children: [
        for (var i = 0; i < lines.length; i++) ...[
          if (i > 0) const SizedBox(height: 8),
          _buildContentLine(lines[i], accent, i),
        ],
      ],
    );
  }

  Widget _buildContentLine(String line, Color accent, int index) {
    final isCheck = line.startsWith('✓');
    final isNumbered = RegExp(r'^\d').hasMatch(line);
    final isBullet = line.startsWith('•');

    String text = line;
    if (isCheck) text = line.substring(1).trim();
    if (isBullet) text = line.substring(1).trim();
    if (isNumbered) {
      final match = RegExp(r'^(\d+️⃣?)\s*').firstMatch(line);
      if (match != null) text = line.substring(match.end).trim();
    }

    Widget leading;
    if (isNumbered) {
      leading = Container(
        width: 26,
        height: 26,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.18),
          shape: BoxShape.circle,
          border: Border.all(color: accent.withValues(alpha: 0.5)),
        ),
        child: Text(
          '${index + 1}',
          style: AppTextStyles.bodyBold.copyWith(
            fontSize: 13,
            color: accent,
          ),
        ),
      );
    } else if (isCheck) {
      leading = Icon(Icons.check_circle_rounded, color: accent, size: 22);
    } else {
      leading = Container(
        width: 10,
        height: 10,
        margin: const EdgeInsets.only(left: 6, right: 6),
        decoration: BoxDecoration(
          color: accent,
          shape: BoxShape.circle,
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          leading,
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.body.copyWith(
                height: 1.45,
                fontSize: 14.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Center(
          child: Column(
            children: [
              Text(
                'about.version'.tr(),
                style: AppTextStyles.caption,
              ),
              const SizedBox(height: 8),
              Text(
                'about.footer'.tr(),
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 8,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.7),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyScreen(),
                  ),
                );
              },
              child: Text(
                'about.privacyPolicy'.tr(),
                style: AppTextStyles.bodyBold.copyWith(fontSize: 14),
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.7),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TermsScreen(),
                  ),
                );
              },
              child: Text(
                'about.terms'.tr(),
                style: AppTextStyles.bodyBold.copyWith(fontSize: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
