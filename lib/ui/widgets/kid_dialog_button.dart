import 'package:flutter/material.dart';

import '../../core/app_text_styles.dart';

class KidDialogDoneButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color accentColor;

  const KidDialogDoneButton({
    super.key,
    required this.onPressed,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: accentColor,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        icon: const Icon(Icons.check_rounded, size: 26),
        label: Text(
          'OK',
          style: AppTextStyles.button.copyWith(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

/// Rounded prev / next row for number dialogs.
class KidDialogNavRow extends StatelessWidget {
  final bool canPrev;
  final bool canNext;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;
  final String prevLabel;
  final String nextLabel;
  final Color accentColor;

  const KidDialogNavRow({
    super.key,
    required this.canPrev,
    required this.canNext,
    this.onPrev,
    this.onNext,
    required this.prevLabel,
    required this.nextLabel,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (canPrev)
          Expanded(
            child: _NavChip(
              label: prevLabel,
              icon: Icons.arrow_back_rounded,
              color: accentColor,
              onTap: onPrev!,
            ),
          )
        else
          const Expanded(child: SizedBox()),
        const SizedBox(width: 12),
        if (canNext)
          Expanded(
            child: _NavChip(
              label: nextLabel,
              icon: Icons.arrow_forward_rounded,
              color: accentColor,
              onTap: onNext!,
              iconAfter: true,
            ),
          )
        else
          const Expanded(child: SizedBox()),
      ],
    );
  }
}

class _NavChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool iconAfter;

  const _NavChip({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
    this.iconAfter = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withValues(alpha: 0.4), width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!iconAfter) ...[
                Icon(icon, color: color, size: 22),
                const SizedBox(width: 6),
              ],
              Flexible(
                child: Text(
                  label,
                  style: AppTextStyles.bodyBold.copyWith(
                    color: color,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (iconAfter) ...[
                const SizedBox(width: 6),
                Icon(icon, color: color, size: 22),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
