import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../utils/responsive.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final title = 'legal.privacy.title'.tr();

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
          title,
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
              Text(title, style: AppTextStyles.heading1),
              const SizedBox(height: 8),
              Text(
                'legal.privacy.lastUpdated'.tr(),
                style: AppTextStyles.caption,
              ),
              const SizedBox(height: 16),
              Text('legal.privacy.intro'.tr(), style: AppTextStyles.body),
              const SizedBox(height: 16),
              _sectionTitle('legal.privacy.s1Title'.tr()),
              _sectionBody('legal.privacy.s1Body'.tr()),
              const SizedBox(height: 12),
              _sectionTitle('legal.privacy.s2Title'.tr()),
              _sectionBody('legal.privacy.s2Body'.tr()),
              const SizedBox(height: 12),
              _sectionTitle('legal.privacy.s3Title'.tr()),
              _sectionBody('legal.privacy.s3Body'.tr()),
              const SizedBox(height: 12),
              _sectionTitle('legal.privacy.s4Title'.tr()),
              _sectionBody('legal.privacy.s4Body'.tr()),
              const SizedBox(height: 12),
              _sectionTitle('legal.privacy.s5Title'.tr()),
              _sectionBody('legal.privacy.s5Body'.tr()),
              const SizedBox(height: 12),
              _sectionTitle('legal.privacy.s6Title'.tr()),
              _sectionBody('legal.privacy.s6Body'.tr()),
              const SizedBox(height: 12),
              _sectionTitle('legal.privacy.s7Title'.tr()),
              _sectionBody('legal.privacy.s7Body'.tr()),
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
