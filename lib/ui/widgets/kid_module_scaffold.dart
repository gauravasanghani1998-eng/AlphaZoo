import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

/// Standard learning-screen shell: soft blobs, cream app bar, padded body.
class KidModuleScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;

  const KidModuleScaffold({
    super.key,
    required this.title,
    required this.child,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(title),
        actions: actions,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 40,
            right: -36,
            child: _DecorBlob(
              color: AppColors.accent.withValues(alpha: 0.22),
              size: 120,
            ),
          ),
          Positioned(
            bottom: 100,
            left: -48,
            child: _DecorBlob(
              color: AppColors.secondary.withValues(alpha: 0.14),
              size: 100,
            ),
          ),
          Positioned(
            top: 180,
            left: -24,
            child: _DecorBlob(
              color: AppColors.primary.withValues(alpha: 0.12),
              size: 72,
            ),
          ),
          SafeArea(child: child),
        ],
      ),
    );
  }
}

class _DecorBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _DecorBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
