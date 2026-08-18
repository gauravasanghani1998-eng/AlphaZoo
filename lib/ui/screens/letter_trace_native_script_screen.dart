import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/native_script_data.dart';
import '../../ui/models/trace_practice_kind.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import '../widgets/kid_module_scaffold.dart';
import '../widgets/kid_pill_selector.dart';
import '../widgets/kid_section_header.dart';
import 'letter_trace_practice_screen.dart';

/// Swar & Kakko grid for Trace & Write (gu / hi / mr / ta / pa).
class LetterTraceNativeScriptScreen extends StatefulWidget {
  const LetterTraceNativeScriptScreen({super.key});

  @override
  State<LetterTraceNativeScriptScreen> createState() =>
      _LetterTraceNativeScriptScreenState();
}

class _LetterTraceNativeScriptScreenState
    extends State<LetterTraceNativeScriptScreen> {
  String _tab = 'swar';

  List<NativeScriptChar> get _items {
    final lang = context.locale.languageCode;
    return NativeScriptData.charsForCategory(lang, _tab);
  }

  void _speakStart(NativeScriptChar item) {
    AppSpeech.speakMixed(
      context,
      'letterTrace.practicePrompt'.tr(
        namedArgs: {'letter': item.glyph},
      ),
      scriptLanguageCode:
          NativeScriptData.speakLocaleFor(context.locale.languageCode),
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final top = responsive.verticalPadding;
    final isSwar = _tab == 'swar';
    final items = _items;

    return KidModuleScaffold(
      title: 'letterTrace.sections.nativeScript.title'.tr(),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(pad, top, pad, top + 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KidSectionHeader(
              emoji: isSwar ? '🔤' : '📝',
              title: 'letterTrace.sections.nativeScript.title'.tr(),
              subtitle: isSwar
                  ? 'letterTrace.sections.nativeScript.swarSubtitle'.tr()
                  : 'letterTrace.sections.nativeScript.kakkoSubtitle'.tr(),
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

                return _NativeTraceCard(
                  item: item,
                  color: color,
                  onTap: () {
                    AppHapticFeedback.light();
                    _speakStart(item);
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            LetterTracePracticeScreen(
                          kind: TracePracticeKind.nativeScript,
                          initialIndex: index,
                          nativeCategory: _tab,
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

class _NativeTraceCard extends StatelessWidget {
  final NativeScriptChar item;
  final Color color;
  final VoidCallback onTap;

  const _NativeTraceCard({
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
        onTap: onTap,
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
