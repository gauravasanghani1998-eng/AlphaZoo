import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/number_stroke_data.dart';
import '../../data/numbers_data.dart';
import '../../ui/models/trace_practice_kind.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import '../widgets/kid_module_scaffold.dart';
import '../widgets/kid_pill_selector.dart';
import '../widgets/kid_section_header.dart';
import 'letter_trace_practice_screen.dart';

class _NumberRange {
  final int start;
  final int end;

  const _NumberRange(this.start, this.end);
}

/// 1–100 number grid inside Trace & Write → Numbers (localized glyphs).
class LetterTraceNumbersScreen extends StatefulWidget {
  const LetterTraceNumbersScreen({super.key});

  @override
  State<LetterTraceNumbersScreen> createState() =>
      _LetterTraceNumbersScreenState();
}

class _LetterTraceNumbersScreenState extends State<LetterTraceNumbersScreen> {
  static const _ranges = <_NumberRange>[
    _NumberRange(1, 26),
    _NumberRange(27, 52),
    _NumberRange(53, 78),
    _NumberRange(79, 100),
  ];

  int _selectedRangeIndex = 0;

  List<NumberItem> get _currentItems {
    final range = _ranges[_selectedRangeIndex];
    return NumbersData.range(range.start, range.end);
  }

  String get _glyphs => NumbersData.glyphsKey.tr();

  String get _fullRangeLabel =>
      NumbersData.formatDigitRange(1, NumberStrokeData.traceNumberCount, _glyphs);

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final top = responsive.verticalPadding;

    return KidModuleScaffold(
      title: 'letterTrace.sections.numbers.title'.tr(),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(pad, top, pad, top + 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KidSectionHeader(
              emoji: '🔢',
              title: 'letterTrace.sections.numbers.title'.tr(),
              subtitle: 'letterTrace.sections.numbers.subtitle'.tr(
                namedArgs: {'range': _fullRangeLabel},
              ),
            ),
            const SizedBox(height: 16),
            KidPillSelector(
              labels: _ranges
                  .map((r) =>
                      NumbersData.formatDigitRange(r.start, r.end, _glyphs))
                  .toList(),
              selectedIndex: _selectedRangeIndex,
              onSelected: (index) =>
                  setState(() => _selectedRangeIndex = index),
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
              itemCount: _currentItems.length,
              itemBuilder: (context, index) {
                final item = _currentItems[index];
                final glyph = NumbersData.formatDigits(item.value, _glyphs);
                final color = AppColors.getLetterColor((item.value - 1) % 26);
                final name = item.nameKey.tr();

                return _TraceNumberTile(
                  glyph: glyph,
                  name: name,
                  color: color,
                  onTap: () {
                    AppHapticFeedback.light();
                    AppSpeech.speak(
                      context,
                      'letterTrace.numberSpeakStart'.tr(
                        namedArgs: {'digit': glyph},
                      ),
                    );
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            LetterTracePracticeScreen(
                          kind: TracePracticeKind.number,
                          initialIndex: item.value - 1,
                        ),
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

class _TraceNumberTile extends StatelessWidget {
  final String glyph;
  final String name;
  final Color color;
  final VoidCallback onTap;

  const _TraceNumberTile({
    required this.glyph,
    required this.name,
    required this.color,
    required this.onTap,
  });

  double _glyphFontSize() {
    if (glyph.length > 2) return 22;
    if (glyph.length > 1) return 26;
    return 32;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
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
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    glyph,
                    style: AppTextStyles.heading2.copyWith(
                      color: color,
                      fontSize: _glyphFontSize(),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  name,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
