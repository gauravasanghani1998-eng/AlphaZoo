import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../utils/responsive.dart';

/// About screen with app information and credits
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                title: 'AlphaZoo',
                content:
                    'An interactive A-Z alphabet learning app designed for kids. '
                    'Each letter comes with colorful illustrations, fun words, and sounds to make learning engaging and memorable!',
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                title: 'How to Use',
                content:
                    '• Tap any letter on the home screen to explore it\n'
                    '• Press the play button to hear the letter sound\n'
                    '• Use Next/Previous buttons to navigate between letters\n'
                    '• All content is stored locally - no internet needed!',
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                title: 'Customization',
                content:
                    'You can replace the images and sounds:\n\n'
                    '1. Add images as assets/images/a.png through z.png\n'
                    '2. Add sounds as assets/sounds/a.mp3 through z.mp3\n'
                    '3. Update pubspec.yaml to reference your assets\n'
                    '4. Run flutter pub get and rebuild the app',
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                title: 'Technology',
                content:
                    'Built with Flutter 3.x\n'
                    'Packages: audioplayers, google_fonts, lottie, flame\n'
                    'Uses local assets only (no API calls)\n'
                    'Responsive design for all screen sizes',
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

  /// Build information card
  Widget _buildInfoCard({
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.heading3,
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: AppTextStyles.body,
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

