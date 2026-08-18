import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../data/vehicles_data.dart';
import '../../utils/learning_detail_content.dart';
import '../../utils/responsive.dart';
import '../widgets/kid_learning_tile.dart';
import '../widgets/kid_module_scaffold.dart';
import '../widgets/kid_section_header.dart';
import 'kid_learning_detail_screen.dart';

/// Cars, buses, trains and more — simple names for kids.
class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  String _name(VehicleItem item) => item.nameKey.tr();

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final top = responsive.verticalPadding;

    return KidModuleScaffold(
      title: 'vehicles.title'.tr(),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(pad, top, pad, top + 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KidSectionHeader(
              emoji: '🚗',
              title: 'vehicles.header'.tr(),
              subtitle: 'vehicles.description'.tr(),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: responsive.moduleGridCrossAxisCount,
                crossAxisSpacing: responsive.gridSpacing,
                mainAxisSpacing: responsive.gridSpacing,
                childAspectRatio: 0.95,
              ),
              itemCount: VehiclesData.items.length,
              itemBuilder: (context, index) {
                final item = VehiclesData.items[index];
                final color = AppColors.getLetterColor(index);
                final name = _name(item);

                return KidLearningTile(
                  emoji: item.emoji,
                  label: name,
                  accentColor: color,
                  onTap: () => _openDetail(context, index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openDetail(BuildContext context, int index) {
    final pages = VehiclesData.items
        .map(
          (item) => LearningDetailContent.emojiItem(
            emoji: item.emoji,
            nameKey: item.nameKey,
            module: 'vehicles',
            subtitleKey: item.subtitleKey,
          ),
        )
        .toList();
    final colors = List.generate(
      VehiclesData.items.length,
      (i) => AppColors.getLetterColor(i),
    );

    KidLearningDetailScreen.open(
      context,
      moduleTitle: 'vehicles.title'.tr(),
      initialIndex: index,
      pages: pages,
      accentColors: colors,
    );
  }
}
