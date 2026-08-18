import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/alphabet_data.dart';
import '../../data/native_script_data.dart';
import '../../data/number_stroke_data.dart';
import '../../data/numbers_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import '../models/trace_practice_kind.dart';
import '../widgets/kid_alphabet_style_detail.dart';
import '../widgets/letter_trace_board_widgets.dart';
import '../widgets/letter_trace_canvas.dart';

/// Chalkboard-style tracing practice with wooden frame UI.
class LetterTracePracticeScreen extends StatefulWidget {
  final TracePracticeKind kind;
  final int initialIndex;
  final String? nativeCategory;

  const LetterTracePracticeScreen({
    super.key,
    required this.kind,
    required this.initialIndex,
    this.nativeCategory,
  });

  @override
  State<LetterTracePracticeScreen> createState() =>
      _LetterTracePracticeScreenState();
}

class _LetterTracePracticeScreenState extends State<LetterTracePracticeScreen> {
  late int _currentIndex;
  bool _isUppercase = true;
  Color _traceColor = const Color(0xFFFFEB3B);
  bool _completed = false;
  final GlobalKey<LetterTraceCanvasState> _canvasKey =
      GlobalKey<LetterTraceCanvasState>();

  static const List<Color> _chalkColors = [
    Color(0xFFFFFFFF),
    Color(0xFFE53935),
    Color(0xFFFF9800),
    Color(0xFFFFEB3B),
    Color(0xFF43B56B),
    Color(0xFF1E88E5),
    Color(0xFF8E24AA),
  ];

  bool get _isAlphabet => widget.kind == TracePracticeKind.alphabet;
  bool get _isNumber => widget.kind == TracePracticeKind.number;

  String get _nativeCategory => widget.nativeCategory!;

  List<NativeScriptChar> get _nativeItems => NativeScriptData.charsForCategory(
        context.locale.languageCode,
        _nativeCategory,
      );

  NativeScriptChar get _nativeItem {
    final items = _nativeItems;
    if (_currentIndex >= 0 && _currentIndex < items.length) {
      return items[_currentIndex];
    }
    return items.first;
  }

  int get _itemCount {
    if (_isAlphabet) return AlphabetData.count;
    if (_isNumber) return NumberStrokeData.traceNumberCount;
    return _nativeItems.length;
  }

  AlphabetItem get _alphabetItem => AlphabetData.getItem(_currentIndex);

  int get _currentValue => _currentIndex + 1;

  String get _glyphs => NumbersData.glyphsKey.tr();

  String get _numberGlyph =>
      NumbersData.formatDigits(_currentValue, _glyphs);

  String get _numberName => 'numbers.names.$_currentValue'.tr();

  String get _traceLetter =>
      _isUppercase ? _alphabetItem.letter : _alphabetItem.letter.toLowerCase();

  String get _displayCharacter {
    if (_isAlphabet) return _traceLetter;
    if (_isNumber) return _numberGlyph;
    return _nativeItem.glyph;
  }

  String get _strokeGuideKey {
    if (_isAlphabet) return _traceLetter.toUpperCase();
    if (_isNumber) return '$_currentValue';
    return _nativeItem.id;
  }

  Color get _accent => AppColors.getLetterColor(_currentIndex % 26);

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    WidgetsBinding.instance.addPostFrameCallback((_) => _speakPrompt());
  }

  void _speakPrompt() {
    if (_isAlphabet) {
      AppSpeech.speak(
        context,
        'letterTrace.practicePrompt'.tr(
          namedArgs: {'letter': _traceLetter},
        ),
      );
      return;
    }

    if (_isNumber) {
      AppSpeech.speak(
        context,
        'letterTrace.numberPracticePrompt'.tr(
          namedArgs: {'digit': _numberGlyph},
        ),
      );
      return;
    }

    AppSpeech.speakMixed(
      context,
      'letterTrace.practicePrompt'.tr(
        namedArgs: {'letter': _nativeItem.glyph},
      ),
      scriptLanguageCode:
          NativeScriptData.speakLocaleFor(context.locale.languageCode),
    );
  }

  void _onCompleted() {
    if (_completed) return;
    setState(() => _completed = true);
    AppHapticFeedback.success();
    if (_isAlphabet) {
      AppSpeech.speak(
        context,
        'letterTrace.completed'.tr(
          namedArgs: {'letter': _traceLetter, 'word': _alphabetItem.word},
        ),
      );
    } else if (_isNumber) {
      AppSpeech.speak(
        context,
        'letterTrace.numberCompleted'.tr(
          namedArgs: {'digit': _numberGlyph, 'name': _numberName},
        ),
      );
    } else {
      AppSpeech.speak(
        context,
        'letterTrace.nativeCompleted'.tr(
          namedArgs: {'letter': _nativeItem.glyph},
        ),
        languageCode:
            NativeScriptData.speakLocaleFor(context.locale.languageCode),
      );
    }
  }

  void _reset() {
    AppHapticFeedback.light();
    _canvasKey.currentState?.reset();
    setState(() => _completed = false);
  }

  void _goToIndex(int index) {
    if (index < 0 || index >= _itemCount) return;
    setState(() {
      _currentIndex = index;
      _completed = false;
    });
    _speakPrompt();
  }

  void _setUppercase(bool upper) {
    if (_isUppercase == upper) return;
    AppHapticFeedback.light();
    setState(() {
      _isUppercase = upper;
      _completed = false;
    });
    _canvasKey.currentState?.reset();
    _speakPrompt();
  }

  String _appBarTitle() {
    if (_isAlphabet) {
      return 'letterTrace.practiceTitle'.tr(
        namedArgs: {'letter': _traceLetter},
      );
    }
    if (_isNumber) {
      return 'letterTrace.numberPracticeTitle'.tr(
        namedArgs: {'digit': _numberGlyph},
      );
    }
    return 'letterTrace.nativePracticeTitle'.tr(
      namedArgs: {'letter': _nativeItem.glyph},
    );
  }

  String _progressLabel() {
    if (_isNumber) return '$_currentValue/$_itemCount';
    return '${_currentIndex + 1}/$_itemCount';
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Scaffold(
      backgroundColor: KidAlphabetStyleDetail.creamBackground,
      appBar: KidAlphabetStyleDetail.appBar(
        isScrolled: false,
        accentColor: _accent,
        title: _appBarTitle(),
        onBack: () => Navigator.of(context).pop(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(child: _buildBoardBody(responsive)),
            const SizedBox(height: 18),
            _buildColorPicker(),
            const SizedBox(height: 18),
            KidAlphabetStyleDetail.navigationBar(
              responsive: responsive,
              accentColor: _accent,
              canPrevious: _currentIndex > 0,
              canNext: _currentIndex < _itemCount - 1,
              onPrevious:
                  _currentIndex > 0 ? () => _goToIndex(_currentIndex - 1) : null,
              onNext: _currentIndex < _itemCount - 1
                  ? () => _goToIndex(_currentIndex + 1)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 8, 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: _accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _accent.withValues(alpha: 0.4)),
            ),
            child: Text(
              _progressLabel(),
              style: AppTextStyles.bodyBold.copyWith(
                color: _accent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
          if (_completed)
            const Padding(
              padding: EdgeInsets.only(right: 6),
              child: Icon(Icons.check_circle_rounded, color: Color(0xFF43B56B)),
            ),
          LetterTraceCompactAction(
            icon: Icons.refresh_rounded,
            label: 'letterTrace.reset'.tr(),
            color: AppColors.accent,
            onTap: _reset,
          ),
        ],
      ),
    );
  }

  Widget _buildBoardBody(Responsive responsive) {
    final leftRailWidth = responsive.isTablet ? 64.0 : 52.0;
    final rightRailWidth = responsive.isTablet ? 75.0 : 60.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        children: [
          Positioned.fill(child: _buildCanvasArea()),
          Positioned(
            left: 10,
            top: 10,
            bottom: 10,
            width: leftRailWidth,
            child: _buildLeftRail(),
          ),
          if (_isAlphabet)
            Positioned(
              right: 10,
              top: 10,
              bottom: 10,
              width: rightRailWidth,
              child: _buildRightRail(),
            ),
        ],
      ),
    );
  }

  Widget _buildLeftRail() {
    return Column(
      children: [
        LetterTraceLetterBadge(
          upper: _isAlphabet ? _alphabetItem.letter : _displayCharacter,
          lower: _alphabetItem.letter.toLowerCase(),
          showCasePair: _isAlphabet,
        ),
        const Spacer(),
        LetterTraceCompactAction(
          icon: Icons.volume_up_rounded,
          label: 'letterTrace.hearAgain'.tr(),
          color: const Color(0xFFFFB74D),
          onTap: () {
            AppHapticFeedback.light();
            _speakPrompt();
          },
        ),
      ],
    );
  }

  Widget _buildRightRail() {
    return Column(
      children: [
        LetterTraceWoodPlankButton(
          label: 'A~Z',
          selected: _isUppercase,
          labelColors: const [Color(0xFFE53935), Color(0xFFFF9800)],
          onTap: () => _setUppercase(true),
        ),
        const SizedBox(height: 5),
        LetterTraceWoodPlankButton(
          label: 'a~z',
          selected: !_isUppercase,
          labelColors: const [Color(0xFF43B56B), Color(0xFF8E24AA)],
          onTap: () => _setUppercase(false),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildCanvasArea() {
    return SizedBox.expand(
      child: LetterTraceWoodenFrame(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LetterTraceCanvas(
            key: _canvasKey,
            letter: _displayCharacter,
            kind: widget.kind,
            strokeGuideKey: _strokeGuideKey,
            nativeFamily: widget.kind == TracePracticeKind.nativeScript
                ? NativeScriptData.familyFor(context.locale.languageCode)
                : null,
            traceColor: _traceColor,
            boardColor: LetterTraceBoardTheme.chalkGreen,
            letterFillColor: LetterTraceBoardTheme.chalkGreen,
            outlineColor: Colors.white,
            showNotebookLines: false,
            onCompleted: _onCompleted,
            onStrokeAdvanced: AppHapticFeedback.light,
          ),
        ),
      ),
    );
  }

  Widget _buildColorPicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _chalkColors.map((color) {
          final selected = color == _traceColor;
          final borderColor = color == Colors.white
              ? Colors.white70
              : Colors.transparent;
          return GestureDetector(
            onTap: () {
              AppHapticFeedback.light();
              setState(() => _traceColor = color);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 36,
              height: 36,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? _accent : borderColor,
                  width: selected ? 3 : 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: selected ? 8 : 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: selected
                  ? Icon(
                      Icons.check_rounded,
                      color: color == Colors.white
                          ? LetterTraceBoardTheme.chalkGreen
                          : Colors.white,
                      size: 18,
                    )
                  : null,
            ),
          );
        }).toList(),
      ),
    );
  }
}
