import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/positions_directions_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import 'positions_directions_detail_screen.dart';

/// Positions & Directions hub — a seven-stop sky adventure.
class PositionsDirectionsScreen extends StatefulWidget {
  const PositionsDirectionsScreen({super.key});

  @override
  State<PositionsDirectionsScreen> createState() =>
      _PositionsDirectionsScreenState();
}

class _PositionsDirectionsScreenState extends State<PositionsDirectionsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _drift;

  @override
  void initState() {
    super.initState();
    _drift = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    AppSpeech.stop();
    _drift.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final items = PositionsDirectionsData.items;
    final columns = responsive.width < 600 ? 2 : 3;

    return Scaffold(
      backgroundColor: AppColors.directionsHubBg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _SkyHeader(drift: _drift)),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(pad, 18, pad, 28),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: responsive.gridSpacing,
                mainAxisSpacing: responsive.gridSpacing,
                childAspectRatio: 0.92,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = items[index];
                  return _LeafTile(
                    index: index,
                    emoji: item.emoji,
                    label: item.nameKey.tr(),
                    accent: AppColors.directionsAccent(index),
                    onTap: () => _openDetail(context, index),
                  );
                },
                childCount: items.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openDetail(BuildContext context, int index) {
    AppHapticFeedback.medium();
    AppSpeech.interruptPlayback();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PositionsDirectionsDetailScreen(initialIndex: index),
      ),
    );
  }
}

class _SkyHeader extends StatelessWidget {
  final Animation<double> drift;

  const _SkyHeader({required this.drift});

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, topPad + 8, 16, 26),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.directionsSkyTop,
            AppColors.directionsSkyMid,
            AppColors.directionsSkyBottom,
          ],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(38)),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedBuilder(
            animation: drift,
            builder: (context, _) {
              return Positioned(
                right: 10 + drift.value * 14,
                top: 4,
                child: const Text('☁️', style: TextStyle(fontSize: 30)),
              );
            },
          ),
          AnimatedBuilder(
            animation: drift,
            builder: (context, _) {
              return Positioned(
                left: 24 - drift.value * 10,
                top: 52,
                child: Text(
                  '☁️',
                  style: TextStyle(
                    fontSize: 22,
                    color: AppColors.white.withValues(alpha: 0.8),
                  ),
                ),
              );
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Material(
                    color: AppColors.white.withValues(alpha: 0.3),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        AppSpeech.stop();
                        Navigator.of(context).pop();
                      },
                      child: const SizedBox(
                        width: 42,
                        height: 42,
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  AnimatedBuilder(
                    animation: drift,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: -0.18 + drift.value * 0.36,
                        child: child,
                      );
                    },
                    child: const Text('🧭', style: TextStyle(fontSize: 44)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'positionsDirections.header'.tr(),
                style: AppTextStyles.heading1.copyWith(
                  color: AppColors.white,
                  fontSize: 26,
                  shadows: [
                    Shadow(
                      color: AppColors.black.withValues(alpha: 0.18),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  'positionsDirections.description'.tr(),
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.directionsCompass,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Leaf-shaped tile: alternating big corner radii give the grid a playful,
/// petal-like rhythm no other module uses.
class _LeafTile extends StatelessWidget {
  final int index;
  final String emoji;
  final String label;
  final Color accent;
  final VoidCallback onTap;

  const _LeafTile({
    required this.index,
    required this.emoji,
    required this.label,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final even = index.isEven;
    final radius = BorderRadius.only(
      topLeft: Radius.circular(even ? 34 : 16),
      topRight: Radius.circular(even ? 16 : 34),
      bottomLeft: Radius.circular(even ? 16 : 34),
      bottomRight: Radius.circular(even ? 34 : 16),
    );

    return Material(
      color: AppColors.white,
      borderRadius: radius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          AppHapticFeedback.light();
          onTap();
        },
        splashColor: accent.withValues(alpha: 0.14),
        highlightColor: accent.withValues(alpha: 0.06),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: accent.withValues(alpha: 0.35), width: 2),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(accent, AppColors.white, 0.9)!,
                AppColors.white,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: accent.withValues(alpha: 0.35),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(emoji, style: const TextStyle(fontSize: 30)),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyBold.copyWith(
                    color: Color.lerp(accent, AppColors.black, 0.25),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
