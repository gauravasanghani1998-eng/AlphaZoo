import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/alphabet_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import '../widgets/alphabet_tile.dart';
import 'detail_screen.dart';

/// Dedicated screen showing all 26 letters in a grid.
class AlphabetScreen extends StatelessWidget {
  const AlphabetScreen({super.key});

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
          'homeTitle'.tr(),
          style: AppTextStyles.heading3.copyWith(color: AppColors.primary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: responsive.horizontalPadding,
            vertical: responsive.verticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'homeSubtitle'.tr(),
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: responsive.gridCrossAxisCount,
                    crossAxisSpacing: responsive.gridSpacing,
                    mainAxisSpacing: responsive.gridSpacing,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: AlphabetData.count,
                  itemBuilder: (context, index) {
                    final item = AlphabetData.getItem(index);
                    return AlphabetTile(
                      item: item,
                      index: index,
                      onTap: () {
                        AppHapticFeedback.light();
                        AppSpeech.speak(
                          context,
                          '${item.letter}. ${item.word}',
                        );
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, animation,
                                    secondaryAnimation) =>
                                DetailScreen(initialIndex: index),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

