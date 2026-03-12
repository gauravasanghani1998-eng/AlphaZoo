import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../utils/responsive.dart';
import '../../utils/haptic_feedback.dart';
import 'about_screen.dart';
import 'alphabet_screen.dart';
import 'numbers_screen.dart';
import 'spelling_screen.dart';
import 'shapes_colors_screen.dart';
import 'everyday_words_screen.dart';

/// Home screen displaying all 26 letters in a grid
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animationController.forward();

    // Listen to scroll for app bar color change
    _scrollController.addListener(() {
      final scrolled = _scrollController.offset > 20;
      if (scrolled != _isScrolled) {
        setState(() {
          _isScrolled = scrolled;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(
            horizontal: responsive.horizontalPadding,
            vertical: responsive.verticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAlphabetSection(context, responsive),
              const SizedBox(height: 24),
              _buildLearningShortcuts(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Build app bar with scroll-based color change
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final appTitle = 'Kids Learning World';
    final subtitle = 'exploreSubtitle'.tr();
    return AppBar(
      backgroundColor: _isScrolled
          ? const Color(0xFFFFF3D0).withValues(alpha: 0.95)
          : Colors.transparent,
      elevation: _isScrolled ? 4 : 0,
      shadowColor: _isScrolled ? Colors.orange.withValues(alpha: 0.2) : null,
      toolbarHeight: 72,
      title: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: Image.asset(
              'assets/images/app_logo.png',
              height: 36,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.menu_book_rounded,
                  color: AppColors.primary,
                  size: 36,
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  appTitle,
                  style: AppTextStyles.heading2.copyWith(
                    color: AppColors.primary,
                    fontSize: 20,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        _buildLanguageButton(context),
        IconButton(
          icon: const Icon(Icons.info_outline, color: AppColors.primary),
          onPressed: () {
            AppHapticFeedback.light();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AboutScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  /// Language selector button in the home app bar
  Widget _buildLanguageButton(BuildContext context) {
    return IconButton(
      tooltip: 'Language',
      icon: const Icon(
        Icons.language_rounded,
        color: AppColors.primary,
      ),
      onPressed: () => _showLanguageSheet(context),
    );
  }

  void _showLanguageSheet(BuildContext context) {
    final currentCode = context.locale.languageCode;

    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'languageSheet.title'.tr(),
                    style: AppTextStyles.heading3,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'languageSheet.subtitle'.tr(),
                    style: AppTextStyles.body.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...context.supportedLocales.map((locale) {
                    final code = locale.languageCode;
                    final isSelected = code == currentCode;
                    return ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 0),
                      leading: Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: isSelected ? AppColors.primary : Colors.grey,
                      ),
                      title: Text(
                        _languageName(code),
                        style: AppTextStyles.bodyBold,
                      ),
                      onTap: () {
                        context.setLocale(Locale(code));
                        Navigator.of(context).pop();
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Alphabet section on home
  Widget _buildAlphabetSection(BuildContext context, Responsive responsive) {
    final title = 'homeTitle'.tr();
    final subtitle = 'homeSubtitle'.tr();
    return FadeTransition(
      opacity: _animationController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.heading1,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }

  /// Group of shortcut cards for extra learning sections, shown in a grid.
  Widget _buildLearningShortcuts(BuildContext context) {
    final responsive = context.responsive;

    final items = [
      (
        icon: Icons.sort_by_alpha_rounded,
        color: AppColors.primary,
        title: 'homeTitle'.tr(),
        subtitle: 'homeSubtitle'.tr(),
        onTap: () {
          AppHapticFeedback.medium();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AlphabetScreen(),
            ),
          );
        }
      ),
      (
        icon: Icons.filter_1_rounded,
        color: Colors.orange,
        title: 'shortcuts.numbersTitle'.tr(),
        subtitle: 'shortcuts.numbersSubtitle'.tr(),
        onTap: () {
          AppHapticFeedback.medium();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NumbersScreen(),
            ),
          );
        }
      ),
      (
        icon: Icons.spellcheck_rounded,
        color: AppColors.secondary,
        title: 'shortcuts.spellingTitle'.tr(),
        subtitle: 'shortcuts.spellingSubtitle'.tr(),
        onTap: () {
          AppHapticFeedback.medium();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SpellingScreen(),
            ),
          );
        }
      ),
      (
        icon: Icons.category_rounded,
        color: AppColors.getLetterColor(2),
        title: 'shortcuts.shapesColorsTitle'.tr(),
        subtitle: 'shortcuts.shapesColorsSubtitle'.tr(),
        onTap: () {
          AppHapticFeedback.medium();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ShapesColorsScreen(),
            ),
          );
        }
      ),
      (
        icon: Icons.calendar_today_rounded,
        color: AppColors.getLetterColor(5),
        title: 'shortcuts.daysTitle'.tr(),
        subtitle: 'shortcuts.daysSubtitle'.tr(),
        onTap: () {
          AppHapticFeedback.medium();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const EverydayWordsScreen(
                initialTab: 'days',
                showTabs: false,
              ),
            ),
          );
        }
      ),
      (
        icon: Icons.date_range_rounded,
        color: AppColors.getLetterColor(7),
        title: 'shortcuts.monthsTitle'.tr(),
        subtitle: 'shortcuts.monthsSubtitle'.tr(),
        onTap: () {
          AppHapticFeedback.medium();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const EverydayWordsScreen(
                initialTab: 'months',
                showTabs: false,
              ),
            ),
          );
        }
      ),
      (
        icon: Icons.family_restroom_rounded,
        color: AppColors.getLetterColor(9),
        title: 'shortcuts.familyTitle'.tr(),
        subtitle: 'shortcuts.familySubtitle'.tr(),
        onTap: () {
          AppHapticFeedback.medium();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const EverydayWordsScreen(
                initialTab: 'family',
                showTabs: false,
              ),
            ),
          );
        }
      ),
      (
        icon: Icons.emoji_people_rounded,
        color: AppColors.getLetterColor(11),
        title: 'shortcuts.greetingsTitle'.tr(),
        subtitle: 'shortcuts.greetingsSubtitle'.tr(),
        onTap: () {
          AppHapticFeedback.medium();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const EverydayWordsScreen(
                initialTab: 'greetings',
                showTabs: false,
              ),
            ),
          );
        }
      ),
    ];

    final crossAxisCount =
        responsive.gridCrossAxisCount.clamp(2, 3); // 2–3 big cards per row
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth >= 600;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: responsive.gridSpacing,
        mainAxisSpacing: responsive.gridSpacing,
        // On phones, make cards noticeably taller so text fits without scaling.
        childAspectRatio: isWide ? 4 / 3 : 0.6,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _ShortcutCard(
          icon: item.icon,
          iconColor: item.color,
          title: item.title,
          subtitle: item.subtitle,
          onTap: item.onTap,
        );
      },
    );
  }

  String _languageName(String code) {
    switch (code) {
      case 'hi':
        return 'हिंदी (Hindi)';
      case 'mr':
        return 'मराठी (Marathi)';
      case 'pa':
        return 'ਪੰਜਾਬੀ (Punjabi)';
      case 'ta':
        return 'தமிழ் (Tamil)';
      case 'gu':
        return 'ગુજરાતી (Gujarati)';
      case 'en':
      default:
        return 'English';
    }
  }

}

/// Reusable small shortcut card used in the home header
class _ShortcutCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ShortcutCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              iconColor.withValues(alpha: 0.15),
              Colors.white,
            ],
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: iconColor.withValues(alpha: 0.35),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: iconColor.withValues(alpha: 0.18),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyBold.copyWith(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(
                fontSize: 11,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
