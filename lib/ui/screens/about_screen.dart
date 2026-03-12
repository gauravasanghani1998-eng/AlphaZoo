import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../utils/responsive.dart';
import 'privacy_policy_screen.dart';
import 'terms_screen.dart';

/// About screen with app information and credits
class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
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
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: _isScrolled
            ? const Color(0xFFFFF3D0).withValues(alpha: 0.95)
            : Colors.transparent,
        elevation: _isScrolled ? 4 : 0,
        shadowColor: _isScrolled ? Colors.orange.withValues(alpha: 0.2) : null,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'about.title'.tr(),
          style: AppTextStyles.heading3.copyWith(color: AppColors.primary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController, // Attach scroll controller
          padding: EdgeInsets.symmetric(
            horizontal: responsive.horizontalPadding,
            vertical: responsive.verticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLogo(),
              const SizedBox(height: 32),
              _buildInfoCard(
                title: 'about.appCardTitle'.tr(),
                icon: Icons.school_rounded,
                content: 'about.appCardBody'.tr(),
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                title: 'about.featuresTitle'.tr(),
                icon: Icons.library_books_rounded,
                content: 'about.featuresBody'.tr(),
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                title: 'about.benefitsTitle'.tr(),
                icon: Icons.stars_rounded,
                content: 'about.benefitsBody'.tr(),
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                title: 'about.offlineTitle'.tr(),
                icon: Icons.wifi_off_rounded,
                content: 'about.offlineBody'.tr(),
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                title: 'about.howToUseTitle'.tr(),
                icon: Icons.touch_app_rounded,
                content: 'about.howToUseBody'.tr(),
              ),
              const SizedBox(height: 32),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  /// Build app logo
  Widget _buildLogo() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowDark,
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Image.asset(
          'assets/images/app_logo.png',
          width: 100,
          height: 100,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.menu_book_rounded,
              size: 100,
              color: AppColors.primary,
            );
          },
        ),
      ),
    );
  }

  /// Build information card with icon
  Widget _buildInfoCard({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            const Color(0xFFFFFBF0),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 15,
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
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.heading3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: AppTextStyles.body.copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }

  /// Build footer
  Widget _buildFooter() {
    return Column(
      children: [
        Center(
          child: Column(
            children: [
              Text(
                'Version 1.0.0',
                style: AppTextStyles.caption,
              ),
              const SizedBox(height: 8),
              Text(
                'Made with ❤️ for curious kids',
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
                'Privacy Policy',
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
                'Terms & Conditions',
                style: AppTextStyles.bodyBold.copyWith(fontSize: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
