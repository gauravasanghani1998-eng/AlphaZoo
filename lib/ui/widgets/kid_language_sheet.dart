import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../utils/app_speech.dart';

/// Playful language picker for the home screen.
void showKidLanguageSheet(BuildContext context) {
  final currentCode = context.locale.languageCode;
  final locales = context.supportedLocales;

  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (sheetContext) {
      final maxHeight = MediaQuery.sizeOf(sheetContext).height * 0.72;

      return SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
                child: Column(
                  children: [
                    const Text('🌍', style: TextStyle(fontSize: 32)),
                    const SizedBox(height: 6),
                    Text(
                      'languageSheet.title'.tr(),
                      style: AppTextStyles.heading2.copyWith(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'languageSheet.subtitle'.tr(),
                      style: AppTextStyles.body.copyWith(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: locales.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final locale = locales[index];
                    final code = locale.languageCode;
                    final isSelected = code == currentCode;

                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          final next = Locale(code);
                          context.setLocale(next);
                          AppSpeech.resetLanguageCache();
                          AppSpeech.warmUp(next);
                          Navigator.of(sheetContext).pop();
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: Ink(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withValues(alpha: 0.12)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.primary.withValues(alpha: 0.18),
                              width: isSelected ? 2 : 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                _languageFlag(code),
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  _languageName(code),
                                  style: AppTextStyles.bodyBold.copyWith(
                                    fontSize: 15,
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  Icons.check_circle_rounded,
                                  color: AppColors.primary,
                                  size: 22,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

String _languageFlag(String code) {
  switch (code) {
    case 'hi':
    case 'mr':
    case 'pa':
    case 'ta':
    case 'gu':
      return '🇮🇳';
    case 'en':
    default:
      return '🇬🇧';
  }
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
