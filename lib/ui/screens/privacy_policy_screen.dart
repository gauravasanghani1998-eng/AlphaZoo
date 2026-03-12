import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../utils/responsive.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF3D0).withValues(alpha: 0.95),
        elevation: 4,
        shadowColor: Colors.orange.withValues(alpha: 0.2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Privacy Policy',
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
                'Privacy Policy',
                style: AppTextStyles.heading1,
              ),
              const SizedBox(height: 8),
              Text(
                'Last updated: March 2026',
                style: AppTextStyles.caption,
              ),
              const SizedBox(height: 16),
              Text(
                'Kids Learning World is an offline educational app for kids that helps them learn the alphabet, numbers, spelling, shapes, colors and everyday words in a fun and safe way.',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 16),
              _sectionTitle('1. No personal data collection'),
              _sectionBody(
                'Kids Learning World does not collect, store or share any personal information from children or adults. '
                'We do not ask you to create an account, log in, enter your name, email, phone number or any other identifying data.',
              ),
              const SizedBox(height: 12),
              _sectionTitle('2. Offline use'),
              _sectionBody(
                'The app is designed to work completely offline. Learning content is stored locally on your device, '
                'so no network connection is required for normal use.',
              ),
              const SizedBox(height: 12),
              _sectionTitle('3. Permissions and device data'),
              _sectionBody(
                'Kids Learning World may use system text‑to‑speech (TTS) on your device to read words aloud. '
                'This feature is handled by the operating system and we do not record or transmit any audio.\n\n'
                'We do not access your contacts, photos, location, microphone recordings, or any other sensitive data.',
              ),
              const SizedBox(height: 12),
              _sectionTitle('4. No ads or tracking'),
              _sectionBody(
                'The app does not contain third‑party advertising, analytics SDKs, or tracking technologies. '
                'We do not use cookies or similar technologies to profile users.',
              ),
              const SizedBox(height: 12),
              _sectionTitle('5. Children’s privacy'),
              _sectionBody(
                'Kids Learning World is built for young learners. We have intentionally minimized data use and avoided any features '
                'that require children to share personal information. Parents and guardians are encouraged to supervise '
                'device use and help children understand safe use of apps.',
              ),
              const SizedBox(height: 12),
              _sectionTitle('6. Changes to this policy'),
              _sectionBody(
                'If we ever change how the app handles data, we will update this Privacy Policy inside the app and in the '
                'store listing. Any material changes will be clearly communicated so you can review them before continuing to use the app.',
              ),
              const SizedBox(height: 12),
              _sectionTitle('7. Contact'),
              _sectionBody(
                'If you have any questions about this Privacy Policy, you can contact the developer using the email address provided in the store listing.',
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

