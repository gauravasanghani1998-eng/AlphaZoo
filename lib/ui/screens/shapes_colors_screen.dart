import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/shapes_colors_data.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import '../../utils/app_speech.dart';

/// Screen that shows both Shapes and Colors with a simple toggle.
class ShapesColorsScreen extends StatefulWidget {
  const ShapesColorsScreen({super.key});

  @override
  State<ShapesColorsScreen> createState() => _ShapesColorsScreenState();
}

class _ShapesColorsScreenState extends State<ShapesColorsScreen> {
  String _tab = 'shapes'; // 'shapes' or 'colors'

  String _localizedShapeName(String englishName) {
    final key =
        'shapes.name.${englishName.toLowerCase().replaceAll(' ', '_')}';
    final translated = key.tr();
    return translated == key ? englishName : translated;
  }

  String _localizedColorName(String englishName) {
    final key =
        'colors.name.${englishName.toLowerCase().replaceAll(' ', '_')}';
    final translated = key.tr();
    return translated == key ? englishName : translated;
  }

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
          'shapesColorsHeader'.tr(),
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
                'shapesColorsHeader'.tr(),
                style: AppTextStyles.heading1.copyWith(
                  fontSize:
                      (responsive.width * 0.07).clamp(22.0, 30.0),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _tab == 'shapes'
                    ? 'shapesTapShape'.tr()
                    : 'shapesTapColor'.tr(),
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 16),
              _buildTabs(),
              const SizedBox(height: 20),
              Expanded(
                child: _tab == 'shapes'
                    ? _buildShapesGrid(responsive)
                    : _buildColorsGrid(responsive),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        _buildTabButton('shapes', '⬛ ${'shapes.tabShapes'.tr()}'),
        const SizedBox(width: 8),
        _buildTabButton('colors', '🎨 ${'shapes.tabColors'.tr()}'),
      ],
    );
  }

  Widget _buildTabButton(String tab, String label) {
    final isSelected = _tab == tab;
    final color =
        tab == 'shapes' ? AppColors.secondary : AppColors.getLetterColor(2);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (_tab == tab) return;
          AppHapticFeedback.light();
          setState(() => _tab = tab);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: color.withValues(alpha: 0.7),
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.bodyBold.copyWith(
                color: isSelected ? Colors.white : color,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShapesGrid(Responsive responsive) {
    final shapes = ShapesColorsData.shapes;
    final crossAxisCount = responsive.gridCrossAxisCount.clamp(2, 4);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: responsive.gridSpacing,
        mainAxisSpacing: responsive.gridSpacing,
        childAspectRatio: 1.0,
      ),
      itemCount: shapes.length,
      itemBuilder: (context, index) {
        final item = shapes[index];
        final color = AppColors.getLetterColor(index);
        final localizedName = _localizedShapeName(item.name);

        return GestureDetector(
          onTap: () => _showSimpleNameDialog(
            title: localizedName,
            emoji: item.emoji,
            color: color,
            message: 'shapes.shapeMessage'
                .tr(namedArgs: {'name': localizedName}),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: color.withValues(alpha: 0.4),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.emoji,
                      style: const TextStyle(fontSize: 40),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      localizedName,
                      style: AppTextStyles.bodyBold,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildColorsGrid(Responsive responsive) {
    final colors = ShapesColorsData.colors;
    final crossAxisCount = responsive.gridCrossAxisCount.clamp(2, 4);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: responsive.gridSpacing,
        mainAxisSpacing: responsive.gridSpacing,
        childAspectRatio: 1.0,
      ),
      itemCount: colors.length,
      itemBuilder: (context, index) {
        final item = colors[index];
        final localizedName = _localizedColorName(item.name);

        return GestureDetector(
          onTap: () => _showSimpleNameDialog(
            title: localizedName,
            emoji: '🎨',
            color: item.color,
            message: 'shapes.colorMessage'
                .tr(namedArgs: {'name': localizedName}),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: item.color.withValues(alpha: 0.7),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: item.color.withValues(alpha: 0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: item.color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      localizedName,
                      style: AppTextStyles.bodyBold,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showSimpleNameDialog({
    required String title,
    required String emoji,
    required Color color,
    required String message,
  }) {
    AppHapticFeedback.medium();

    // Speak the title (shape or color name) when dialog opens.
    AppSpeech.speak(context, title);

    showDialog<void>(
      context: context,
      builder: (context) {
        final responsive = context.responsive;
        final maxWidth = responsive.width * 0.9;
        final maxHeight = responsive.height * 0.8;
        final emojiFontSize =
            (responsive.width * 0.12).clamp(36.0, 64.0); // responsive size

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
              maxHeight: maxHeight,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        color.withValues(alpha: 0.15),
                        Colors.white,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: color.withValues(alpha: 0.4),
                      width: 3,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: AppTextStyles.heading3
                                    .copyWith(color: color),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              color: AppColors.textSecondary,
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          emoji,
                          style: TextStyle(fontSize: emojiFontSize),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          message,
                          style: AppTextStyles.body.copyWith(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

