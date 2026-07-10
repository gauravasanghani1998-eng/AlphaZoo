import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../utils/responsive.dart';
import 'kid_dialog_button.dart';

/// Kid-friendly detail popup — big emoji, large OK button.
class LearningItemDialog extends StatelessWidget {
  final String emoji;
  final String title;
  final String hint;
  final String tapAgainMessage;
  final Color accentColor;

  const LearningItemDialog({
    super.key,
    required this.emoji,
    required this.title,
    required this.hint,
    required this.tapAgainMessage,
    required this.accentColor,
  });

  static Future<void> show(
    BuildContext context, {
    required String emoji,
    required String title,
    required String hint,
    required String tapAgainMessage,
    required Color accentColor,
  }) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) => LearningItemDialog(
        emoji: emoji,
        title: title,
        hint: hint,
        tapAgainMessage: tapAgainMessage,
        accentColor: accentColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final emojiSize = responsive.emojiSize(factor: 0.16, min: 56, max: 88);

    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  accentColor.withValues(alpha: 0.16),
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: accentColor.withValues(alpha: 0.45),
                width: 3,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.heading2.copyWith(
                      color: accentColor,
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Text(emoji, style: TextStyle(fontSize: emojiSize)),
                  const SizedBox(height: 16),
                  Text(
                    hint,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 18,
                      height: 1.45,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    tapAgainMessage,
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  KidDialogDoneButton(
                    accentColor: accentColor,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
