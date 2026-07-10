import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../data/weather_seasons_data.dart';
import '../../utils/learning_detail_content.dart';
import '../../utils/responsive.dart';
import '../widgets/kid_learning_tile.dart';
import '../widgets/kid_module_scaffold.dart';
import '../widgets/kid_pill_selector.dart';
import '../widgets/kid_section_header.dart';
import 'kid_learning_detail_screen.dart';

/// Weather words + seasons — tap to hear the name in the app language.
class WeatherSeasonsScreen extends StatefulWidget {
  const WeatherSeasonsScreen({super.key});

  @override
  State<WeatherSeasonsScreen> createState() => _WeatherSeasonsScreenState();
}

class _WeatherSeasonsScreenState extends State<WeatherSeasonsScreen> {
  static const _tabs = ['weather', 'season'];
  int _tabIndex = 0;

  String get _tab => _tabs[_tabIndex];

  List<WeatherSeasonItem> get _items => WeatherSeasonsData.items
      .where((e) => e.category == _tab)
      .toList(growable: false);

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final top = responsive.verticalPadding;

    return KidModuleScaffold(
      title: 'weather.title'.tr(),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(pad, top, pad, top + 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KidSectionHeader(
              emoji: _tabIndex == 0 ? '☀️' : '🍂',
              title: 'weather.header'.tr(),
              subtitle: _tabIndex == 0
                  ? 'weather.subtitleWeather'.tr()
                  : 'weather.subtitleSeason'.tr(),
            ),
            const SizedBox(height: 14),
            KidPillSelector(
              labels: [
                '☀️ ${'weather.tabWeather'.tr()}',
                '🍂 ${'weather.tabSeason'.tr()}',
              ],
              selectedIndex: _tabIndex,
              onSelected: (index) => setState(() => _tabIndex = index),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: responsive.moduleGridCrossAxisCount,
                crossAxisSpacing: responsive.gridSpacing,
                mainAxisSpacing: responsive.gridSpacing,
                childAspectRatio: 0.92,
              ),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                final color =
                    AppColors.getLetterColor(index + (_tab == 'season' ? 8 : 0));
                final name = item.nameKey.tr();

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
    final pages = _items
        .map(
          (item) => LearningDetailContent.emojiItem(
            emoji: item.emoji,
            nameKey: item.nameKey,
            module: 'weather',
            dialogHintKey: 'weather.dialog.hint',
          ),
        )
        .toList();
    final colors = List.generate(
      _items.length,
      (i) => AppColors.getLetterColor(i + (_tab == 'season' ? 8 : 0)),
    );

    KidLearningDetailScreen.open(
      context,
      moduleTitle: 'weather.title'.tr(),
      initialIndex: index,
      pages: pages,
      accentColors: colors,
    );
  }
}
