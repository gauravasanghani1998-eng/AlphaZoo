import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../utils/responsive.dart';

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
            ? const Color(0xFFFFF3D0).withOpacity(0.95)
            : Colors.transparent,
        elevation: _isScrolled ? 4 : 0,
        shadowColor: _isScrolled ? Colors.orange.withOpacity(0.2) : null,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'About',
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
                title: '🎓 AlphaZoo',
                icon: Icons.school_rounded,
                content:
                    'An interactive A-Z alphabet learning app designed for kids. '
                    'Each letter comes with colorful illustrations, fun words, and educational facts to make learning engaging and memorable!',
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                title: '📚 Learning Features',
                icon: Icons.library_books_rounded,
                content:
                    '• Visual Learning: Beautiful illustrations for each letter\n'
                    '• Fun Facts: Interesting trivia about words and objects\n'
                    '• Word Examples: Multiple words starting with each letter\n'
                    '• Letter Types: Learn vowels and consonants\n'
                    '• Interactive: Tap, swipe, and explore at your own pace',
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                title: '🎯 Educational Benefits',
                icon: Icons.stars_rounded,
                content:
                    '✓ Builds vocabulary and reading skills\n'
                    '✓ Improves letter recognition\n'
                    '✓ Enhances visual memory\n'
                    '✓ Develops phonetic awareness\n'
                    '✓ Encourages independent learning\n'
                    '✓ Suitable for ages 3-7 years',
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                title: '🎨 How to Use',
                icon: Icons.touch_app_rounded,
                content:
                    '1️⃣ Tap any letter on the home screen\n'
                    '2️⃣ Explore the colorful illustration\n'
                    '3️⃣ Read the word and description\n'
                    '4️⃣ Learn fun facts about each item\n'
                    '5️⃣ Use Next/Previous to browse letters\n'
                    '6️⃣ Enjoy random animations on every transition!',
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
          color: Colors.orange.withOpacity(0.2),
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
    return Center(
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
    );
  }
}

