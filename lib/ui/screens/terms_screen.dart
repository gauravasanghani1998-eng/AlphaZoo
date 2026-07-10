import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../utils/responsive.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.appBarTint.withValues(alpha: 0.95),
        elevation: 4,
        shadowColor: Colors.orange.withValues(alpha: 0.2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Terms & Conditions',
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
              Text(
                'Terms & Conditions',
                style: AppTextStyles.heading1,
              ),
              const SizedBox(height: 8),
              Text(
                'Last updated: March 2026',
                style: AppTextStyles.caption,
              ),
              const SizedBox(height: 16),
              _sectionBody(
                'These Terms & Conditions govern your use of the Kids Learning World mobile application. '
                'By installing or using the app, you agree to these terms.',
              ),
              const SizedBox(height: 16),
              _sectionTitle('1. Educational use only'),
              _sectionBody(
                'Kids Learning World is provided for personal, non‑commercial educational use. '
                'You may not use the app for any unlawful or harmful purpose.',
              ),
              const SizedBox(height: 12),
              _sectionTitle('2. Content and ownership'),
              _sectionBody(
                'All graphics, text, sounds and other content in Kids Learning World are owned by the developer or licensed for use in the app. '
                'You may not copy, redistribute, sell, or otherwise exploit the content except as allowed by normal use of the app.',
              ),
              const SizedBox(height: 12),
              _sectionTitle('3. No warranty'),
              _sectionBody(
                'The app is provided “as is” without any warranties of any kind. '
                'We do not guarantee that the app will be error‑free or available on all devices.',
              ),
              const SizedBox(height: 12),
              _sectionTitle('4. Limitation of liability'),
              _sectionBody(
                'To the maximum extent permitted by law, the developer is not liable for any direct or indirect damages '
                'arising from the use or inability to use the app, including loss of data or device issues.',
              ),
              const SizedBox(height: 12),
              _sectionTitle('5. Changes to the app and terms'),
              _sectionBody(
                'Features in Kids Learning World may change or be updated over time. We may update these Terms & Conditions as needed. '
                'Continued use of the app after changes means you accept the updated terms.',
              ),
              const SizedBox(height: 12),
              _sectionTitle('6. Children and supervision'),
              _sectionBody(
                'Kids Learning World is designed for children, but it should be used under the guidance of a parent, guardian or teacher. '
                'Adults are responsible for supervising children’s use of the app and the device.',
              ),
              const SizedBox(height: 12),
              _sectionTitle('7. Contact'),
              _sectionBody(
                'If you have any questions about these Terms & Conditions, you can contact the developer using the email address provided in the store listing.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _sectionTitle(String text) {
    return Text(
      text,
      style: AppTextStyles.heading3.copyWith(fontSize: 20),
    );
  }

  static Widget _sectionBody(String text) {
    return Text(
      text,
      style: AppTextStyles.body.copyWith(height: 1.6),
    );
  }
}

