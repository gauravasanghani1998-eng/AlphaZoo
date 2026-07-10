import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/native_script_data.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/learning_detail_content.dart';
import '../../utils/responsive.dart';
import '../widgets/kid_module_scaffold.dart';
import '../widgets/kid_pill_selector.dart';
import '../widgets/kid_section_header.dart';
import 'kid_learning_detail_screen.dart';

class NativeScriptScreen extends StatefulWidget {
  const NativeScriptScreen({super.key});

  @override
  State<NativeScriptScreen> createState() => _NativeScriptScreenState();
}

class _NativeScriptScreenState extends State<NativeScriptScreen> {
  String _tab = 'swar';

  List<NativeScriptChar> get _items {
    final lang = context.locale.languageCode;
    return _tab == 'swar'
        ? NativeScriptData.swarFor(lang)
        : NativeScriptData.kakkoFor(lang);
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final top = responsive.verticalPadding;
    final isSwar = _tab == 'swar';
    final items = _items;

    return KidModuleScaffold(
      title: 'nativeScript.title'.tr(),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(pad, top, pad, top + 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KidSectionHeader(
              emoji: isSwar ? '🔤' : '📝',
              title: 'nativeScript.header'.tr(),
              subtitle: isSwar
                  ? 'nativeScript.tapSwar'.tr()
                  : 'nativeScript.tapKakko'.tr(),
            ),
            const SizedBox(height: 14),
            KidPillSelector(
              labels: [
                'nativeScript.tabSwar'.tr(),
                'nativeScript.tabKakko'.tr(),
              ],
              selectedIndex: isSwar ? 0 : 1,
              onSelected: (index) =>
                  setState(() => _tab = index == 0 ? 'swar' : 'kakko'),
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
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final color = AppColors.getLetterColor(index);

                return _NativeScriptCard(
                  item: item,
                  color: color,
                  onTap: () => _openDetail(context, index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openDetail(BuildContext context, int itemIndex) {
    final items = _items;
    if (itemIndex < 0 || itemIndex >= items.length) return;

    final letterSize = (context.responsive.width * 0.2).clamp(52.0, 76.0);
    final category = _tab;

    final pages = items.map((item) {
      final index = items.indexOf(item);
      final color = AppColors.getLetterColor(index);
      return LearningDetailContent.scriptChar(
        id: item.id,
        glyph: item.glyph,
        roman: item.romanKey.tr(),
        category: category,
        accentColor: color,
        heroFontSize: letterSize,
        uiLanguageCode: context.locale.languageCode,
      );
    }).toList();

    final colors =
        List.generate(items.length, (i) => AppColors.getLetterColor(i));

    KidLearningDetailScreen.open(
      context,
      moduleTitle: 'nativeScript.title'.tr(),
      initialIndex: itemIndex,
      pages: pages,
      accentColors: colors,
    );
  }
}

class _NativeScriptCard extends StatelessWidget {
  final NativeScriptChar item;
  final Color color;
  final VoidCallback onTap;

  const _NativeScriptCard({
    required this.item,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final radius = context.responsive.cardRadius.clamp(16.0, 20.0);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          AppHapticFeedback.light();
          onTap();
        },
        borderRadius: BorderRadius.circular(radius),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                color.withValues(alpha: 0.12),
              ],
            ),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: color.withValues(alpha: 0.45),
              width: 2.5,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.22),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  item.glyph,
                  style: AppTextStyles.heading2.copyWith(
                    color: color,
                    fontSize: 26,
                    height: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
