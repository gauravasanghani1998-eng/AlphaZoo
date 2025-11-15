import 'package:flutter/material.dart';
import '../../core/app_text_styles.dart';

/// Large letter display widget with decorative styling
class BigLetterWidget extends StatelessWidget {
  final String letter;
  final Color color;

  const BigLetterWidget({
    super.key,
    required this.letter,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withOpacity(0.7),
          ],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: Text(
          letter,
          style: AppTextStyles.detailLetter.copyWith(
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(3, 3),
                blurRadius: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

