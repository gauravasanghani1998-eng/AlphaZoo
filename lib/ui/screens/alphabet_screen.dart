import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/alphabet_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import '../widgets/alphabet_tile.dart';
import '../widgets/kid_module_scaffold.dart';
import '../widgets/kid_section_header.dart';
import 'detail_screen.dart';

class AlphabetScreen extends StatelessWidget {
  const AlphabetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final top = responsive.verticalPadding;

    return KidModuleScaffold(
      title: 'home.title'.tr(),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(pad, top, pad, top + 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KidSectionHeader(
              emoji: '🔤',
              title: 'home.title'.tr(),
              subtitle: 'home.subtitle'.tr(),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            DetailScreen(initialIndex: index),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
