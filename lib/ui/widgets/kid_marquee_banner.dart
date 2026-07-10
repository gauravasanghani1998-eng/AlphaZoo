import 'package:flutter/material.dart';

/// Single-line horizontally scrolling text (marquee / ticker style).
class KidMarqueeBanner extends StatefulWidget {
  const KidMarqueeBanner({
    super.key,
    required this.text,
    this.style,
    this.speed = 52,
    this.gap = 72,
    this.height = 44,
  });

  final String text;
  final TextStyle? style;
  final double speed;
  final double gap;
  final double height;

  @override
  State<KidMarqueeBanner> createState() => _KidMarqueeBannerState();
}

class _KidMarqueeBannerState extends State<KidMarqueeBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _segmentWidth = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void didUpdateWidget(covariant KidMarqueeBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _segmentWidth = 0;
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startScroll(double segmentWidth) {
    if (!mounted || segmentWidth <= 0) return;
    if ((segmentWidth - _segmentWidth).abs() < 1) return;
    _segmentWidth = segmentWidth;
    final seconds = segmentWidth / widget.speed;
    _controller
      ..duration =
          Duration(milliseconds: (seconds * 1000).round().clamp(8000, 60000))
      ..repeat();
  }

  double _textWidth(TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: widget.text, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    return painter.width;
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ??
        const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        );
    final segment = _textWidth(style) + widget.gap;

    return SizedBox(
      height: widget.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxW = constraints.maxWidth;
          if (!maxW.isFinite || maxW <= 0) {
            return const SizedBox.shrink();
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) _startScroll(segment);
          });

          // Stack + Positioned: wide Row is clipped, no RenderFlex overflow.
          return ClipRect(
            child: SizedBox(
              width: maxW,
              height: widget.height,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final dx = -_controller.value * segment;
                  return Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      Positioned(
                        left: dx,
                        top: 0,
                        height: widget.height,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _line(style),
                            SizedBox(width: widget.gap),
                            _line(style),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _line(TextStyle style) {
    return Text(
      widget.text,
      style: style,
      maxLines: 1,
      softWrap: false,
    );
  }
}
