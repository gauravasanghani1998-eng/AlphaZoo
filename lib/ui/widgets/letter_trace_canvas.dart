import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/letter_stroke_data.dart';
import '../../data/native_script_data.dart';
import '../../data/native_script_stroke_data.dart';
import '../../data/number_stroke_data.dart';
import '../models/trace_practice_kind.dart';

class _ColoredStroke {
  final List<Offset> points;
  final Color color;

  const _ColoredStroke({required this.points, required this.color});
}

/// Measure a single letter at [fontSize].
TextPainter _measureLetter(String letter, double fontSize) {
  return TextPainter(
    text: TextSpan(
      text: letter,
      style: GoogleFonts.nunito(
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
      ),
    ),
    textDirection: TextDirection.ltr,
  )..layout();
}

bool _letterFitsCanvas(String letter, double fontSize, Size size) {
  if (size == Size.zero) return false;

  const edgeInset = 2.0;
  final maxW = size.width - edgeInset * 2;
  final maxH = size.height - edgeInset * 2;
  final tp = _measureLetter(letter, fontSize);
  final strokeBleed = fontSize * 0.048 * 0.5 + 1.5;

  return tp.width + strokeBleed * 2 <= maxW &&
      tp.height + strokeBleed * 2 <= maxH;
}

/// Largest font size that fits [letter] inside [size] with a small margin.
double _maxLetterFontSize(String letter, Size size) {
  if (size == Size.zero) return 48;

  double lo = 12;
  double hi = math.max(size.width, size.height) * 1.35;

  while (hi - lo > 0.25) {
    final mid = (lo + hi) / 2;
    if (_letterFitsCanvas(letter, mid, size)) {
      lo = mid;
    } else {
      hi = mid;
    }
  }
  return lo;
}

/// Lowercase letters scale up to match capital width & height on the board.
double _displayLetterFontSize(String letter, Size size) {
  final upper = letter.toUpperCase();
  final capitalSize = _maxLetterFontSize(upper, size);
  if (letter == upper) return capitalSize;

  final upperTp = _measureLetter(upper, capitalSize);
  final lowerTp = _measureLetter(letter, capitalSize);

  final scaleW = upperTp.width / math.max(lowerTp.width, 1);
  final scaleH = upperTp.height / math.max(lowerTp.height, 1);
  // Match the larger dimension so lowercase fills the same box as capital.
  var scaledSize = capitalSize * math.max(scaleW, scaleH);

  while (scaledSize > 12 && !_letterFitsCanvas(letter, scaledSize, size)) {
    scaledSize -= 1.0;
  }
  return scaledSize;
}

/// Interactive letter-tracing canvas: outline + finger paint clipped to letter.
class LetterTraceCanvas extends StatefulWidget {
  final String letter;
  final TracePracticeKind kind;
  final String? strokeGuideKey;
  final NativeScriptFamily? nativeFamily;
  final Color traceColor;
  final Color boardColor;
  final Color letterFillColor;
  final Color outlineColor;
  final bool showNotebookLines;
  final VoidCallback? onCompleted;
  final VoidCallback? onStrokeAdvanced;

  const LetterTraceCanvas({
    super.key,
    required this.letter,
    this.kind = TracePracticeKind.alphabet,
    this.strokeGuideKey,
    this.nativeFamily,
    required this.traceColor,
    this.boardColor = const Color(0xFFFFFDF5),
    this.letterFillColor = Colors.white,
    this.outlineColor = const Color(0xFF8B5E3C),
    this.showNotebookLines = true,
    this.onCompleted,
    this.onStrokeAdvanced,
  });

  @override
  State<LetterTraceCanvas> createState() => LetterTraceCanvasState();
}

class LetterTraceCanvasState extends State<LetterTraceCanvas> {
  final List<_ColoredStroke> _userStrokes = [];
  List<Offset> _activeStroke = [];
  Color? _activeStrokeColor;

  int _currentStrokeIndex = 0;
  int _checkpointIndex = 0;
  bool _completed = false;

  late List<List<Offset>> _guideStrokes;
  late List<List<Offset>> _checkpoints;

  static const double _brushWidth = 4;
  static const double _hitRadius = 36;
  static const double _nativeHitRadius = 44;

  @override
  void initState() {
    super.initState();
    _loadGuides();
  }

  @override
  void didUpdateWidget(covariant LetterTraceCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.letter != widget.letter ||
        oldWidget.kind != widget.kind ||
        oldWidget.strokeGuideKey != widget.strokeGuideKey ||
        oldWidget.nativeFamily != widget.nativeFamily) {
      reset();
      _loadGuides();
    }
  }

  void _loadGuides() {
    if (widget.kind == TracePracticeKind.nativeScript) {
      final guideKey = widget.strokeGuideKey ?? widget.letter;
      final family = widget.nativeFamily ?? NativeScriptFamily.devanagari;
      _guideStrokes = NativeScriptStrokeData.strokesFor(
        guideKey,
        family: family,
      );
      _checkpoints = _guideStrokes
          .map((s) => NativeScriptStrokeData.resamplePolyline(s, segments: 20))
          .toList();
      return;
    }

    if (widget.kind == TracePracticeKind.number) {
      final guideKey = widget.strokeGuideKey ?? widget.letter;
      final value = int.tryParse(guideKey);
      _guideStrokes = value != null
          ? NumberStrokeData.strokesForValue(value)
          : NumberStrokeData.strokesFor(guideKey);
      _checkpoints = _guideStrokes
          .map((s) => NumberStrokeData.resamplePolyline(s, segments: 20))
          .toList();
      return;
    }

    final guideKey = widget.strokeGuideKey ?? widget.letter.toUpperCase();
    _guideStrokes = LetterStrokeData.strokesFor(guideKey);
    _checkpoints = _guideStrokes
        .map((s) => LetterStrokeData.resamplePolyline(s, segments: 20))
        .toList();
  }

  void reset() {
    setState(() {
      _userStrokes.clear();
      _activeStroke = [];
      _activeStrokeColor = null;
      _currentStrokeIndex = 0;
      _checkpointIndex = 0;
      _completed = false;
    });
  }

  bool get isCompleted => _completed;

  double get progress {
    if (_checkpoints.isEmpty) return 0;
    var done = 0;
    for (var i = 0; i < _currentStrokeIndex; i++) {
      done += _checkpoints[i].length;
    }
    done += _checkpointIndex;
    final total = _checkpoints.fold<int>(0, (sum, c) => sum + c.length);
    return total == 0 ? 0 : done / total;
  }

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _activeStrokeColor = widget.traceColor;
      _activeStroke = [details.localPosition];
      _advanceCheckpoints(details.localPosition);
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _activeStroke.add(details.localPosition);
      _advanceCheckpoints(details.localPosition);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (_activeStroke.isNotEmpty) {
      setState(() {
        _userStrokes.add(
          _ColoredStroke(
            points: List<Offset>.from(_activeStroke),
            color: _activeStrokeColor ?? widget.traceColor,
          ),
        );
        _activeStroke = [];
        _activeStrokeColor = null;
      });
    }
  }

  void _advanceCheckpoints(Offset point) {
    if (_currentStrokeIndex >= _checkpoints.length) return;

    final letterRect = _letterRectForSize(_lastSize);
    if (letterRect == null) return;

    final checks = _checkpoints[_currentStrokeIndex];
    final hitRadius = widget.kind == TracePracticeKind.nativeScript
        ? _nativeHitRadius
        : _hitRadius;
    while (_checkpointIndex < checks.length) {
      final target = _mapNormalized(checks[_checkpointIndex], letterRect);
      if ((point - target).distance > hitRadius) break;
      _checkpointIndex++;
      widget.onStrokeAdvanced?.call();
    }

    if (_checkpointIndex >= checks.length) {
      _currentStrokeIndex++;
      _checkpointIndex = 0;
      if (!_completed && _currentStrokeIndex >= _checkpoints.length) {
        _completed = true;
        widget.onCompleted?.call();
      }
    }
  }

  Size _lastSize = Size.zero;

  Rect? _letterRectForSize(Size size) {
    if (size == Size.zero) return null;
    final tp = _textPainterFor(size);
    final textW = tp.width;
    final textH = tp.height;
    final center = Offset(size.width / 2, size.height / 2);
    return Rect.fromCenter(
      center: center,
      width: textW,
      height: textH,
    );
  }

  TextPainter _textPainterFor(Size size) {
    final fontSize = _displayLetterFontSize(widget.letter, size);
    final tp = TextPainter(
      text: TextSpan(
        text: widget.letter,
        style: GoogleFonts.nunito(
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    return tp;
  }

  Offset _mapNormalized(Offset n, Rect letterRect) {
    return Offset(
      letterRect.left + n.dx * letterRect.width,
      letterRect.top + n.dy * letterRect.height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        _lastSize = size;
        return GestureDetector(
          onPanStart: _onPanStart,
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          child: CustomPaint(
            size: size,
            painter: _LetterTracePainter(
              letter: widget.letter,
              boardColor: widget.boardColor,
              letterFillColor: widget.letterFillColor,
              outlineColor: widget.outlineColor,
              showNotebookLines: widget.showNotebookLines,
              userStrokes: _userStrokes,
              activeStroke: _activeStroke,
              activeStrokeColor: _activeStrokeColor ?? widget.traceColor,
              completed: _completed,
              brushWidth: _brushWidth,
            ),
          ),
        );
      },
    );
  }
}

class _LetterTracePainter extends CustomPainter {
  final String letter;
  final Color boardColor;
  final Color letterFillColor;
  final Color outlineColor;
  final bool showNotebookLines;
  final List<_ColoredStroke> userStrokes;
  final List<Offset> activeStroke;
  final Color activeStrokeColor;
  final bool completed;
  final double brushWidth;

  _LetterTracePainter({
    required this.letter,
    required this.boardColor,
    required this.letterFillColor,
    required this.outlineColor,
    required this.showNotebookLines,
    required this.userStrokes,
    required this.activeStroke,
    required this.activeStrokeColor,
    required this.completed,
    required this.brushWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (showNotebookLines) {
      _drawNotebookLines(canvas, size);
    } else {
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = boardColor,
      );
      _drawChalkTexture(canvas, size);
    }

    final fontSize = _displayLetterFontSize(letter, size);
    final fillTp = _letterPainter(letter, fontSize, letterFillColor);

    // Stroke width is 2× visible border — white fill covers the inner half.
    final outlineStrokeWidth = math.max(4.0, fontSize * 0.048);
    final outlinePaint = Paint()
      ..color = outlineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = outlineStrokeWidth
      ..strokeJoin = StrokeJoin.bevel
      ..strokeMiterLimit = 1.0
      ..strokeCap = StrokeCap.round;

    final outlineTp = _letterStrokePainter(letter, fontSize, outlinePaint);

    final letterOffset = Offset(
      (size.width - fillTp.width) / 2,
      (size.height - fillTp.height) / 2,
    );
    final letterRect = Rect.fromLTWH(
      letterOffset.dx,
      letterOffset.dy,
      fillTp.width,
      fillTp.height,
    );

    // Full outline (outer + inner holes) — bevel join avoids corner spikes.
    outlineTp.paint(canvas, letterOffset);

    final bounds = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.saveLayer(bounds, Paint());

    // Letter fill masks trace area; covers inner stroke spikes in the body.
    fillTp.paint(canvas, letterOffset);

    for (final stroke in userStrokes) {
      final tracePaint = Paint()
        ..color = stroke.color
        ..strokeWidth = brushWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke
        ..blendMode = BlendMode.srcIn;
      _drawStroke(canvas, stroke.points, tracePaint);
    }
    if (activeStroke.length > 1) {
      final tracePaint = Paint()
        ..color = activeStrokeColor
        ..strokeWidth = brushWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke
        ..blendMode = BlendMode.srcIn;
      _drawStroke(canvas, activeStroke, tracePaint);
    }

    canvas.restore();

    if (completed) {
      _drawCompletionGlow(canvas, letterRect);
    }
  }

  TextPainter _letterStrokePainter(String char, double fontSize, Paint stroke) {
    return TextPainter(
      text: TextSpan(
        text: char,
        style: GoogleFonts.nunito(
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          foreground: stroke,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
  }

  TextPainter _letterPainter(String char, double fontSize, Color color) {
    return TextPainter(
      text: TextSpan(
        text: char,
        style: GoogleFonts.nunito(
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          color: color,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
  }

  void _drawChalkTexture(Canvas canvas, Size size) {
    final dust = Paint()..color = Colors.white.withValues(alpha: 0.03);
    for (var i = 0; i < 18; i++) {
      final x = (i * 47.0) % size.width;
      final y = (i * 31.0) % size.height;
      canvas.drawCircle(Offset(x, y), 1.2 + (i % 3), dust);
    }
  }

  void _drawNotebookLines(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = boardColor,
    );
    final linePaint = Paint()
      ..color = const Color(0xFFB8D4E8).withValues(alpha: 0.35)
      ..strokeWidth = 1.2;
    const spacing = 28.0;
    for (var y = spacing; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
    final marginPaint = Paint()
      ..color = const Color(0xFFFF9999).withValues(alpha: 0.45)
      ..strokeWidth = 1.5;
    canvas.drawLine(
      Offset(size.width * 0.08, 0),
      Offset(size.width * 0.08, size.height),
      marginPaint,
    );
  }

  void _drawStroke(Canvas canvas, List<Offset> points, Paint paint) {
    if (points.length < 2) return;
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(path, paint);
  }

  void _drawCompletionGlow(Canvas canvas, Rect letterRect) {
    canvas.drawRect(
      letterRect.inflate(12),
      Paint()
        ..color = const Color(0xFF43B56B).withValues(alpha: 0.15)
        ..maskFilter = const ui.MaskFilter.blur(ui.BlurStyle.normal, 16),
    );
  }

  @override
  bool shouldRepaint(covariant _LetterTracePainter oldDelegate) {
    return oldDelegate.letter != letter ||
        oldDelegate.userStrokes != userStrokes ||
        oldDelegate.activeStroke != activeStroke ||
        oldDelegate.activeStrokeColor != activeStrokeColor ||
        oldDelegate.completed != completed;
  }
}
