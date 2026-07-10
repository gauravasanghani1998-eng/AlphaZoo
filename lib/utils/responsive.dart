import 'package:flutter/material.dart';

/// Responsive utility for adaptive layouts
class Responsive {
  final BuildContext context;

  Responsive(this.context);

  /// Screen width
  double get width => MediaQuery.of(context).size.width;

  /// Screen height
  double get height => MediaQuery.of(context).size.height;

  /// Is mobile device
  bool get isMobile => width < 600;

  /// Is tablet device
  bool get isTablet => width >= 600 && width < 900;

  /// Is desktop device
  bool get isDesktop => width >= 900;

  /// Safe area padding
  EdgeInsets get padding => MediaQuery.of(context).padding;

  /// Calculate responsive value based on screen width
  double wp(double percentage) => width * percentage / 100;

  /// Calculate responsive value based on screen height
  double hp(double percentage) => height * percentage / 100;

  /// Get grid cross axis count based on screen size
  int get gridCrossAxisCount {
    if (width < 400) return 3;
    if (width < 600) return 4;
    if (width < 900) return 5;
    return 6;
  }

  /// Get grid spacing
  double get gridSpacing {
    if (width < 400) return 12.0;
    if (width < 600) return 16.0;
    return 20.0;
  }

  /// Get card border radius
  double get cardRadius {
    if (width < 400) return 16.0;
    if (width < 600) return 20.0;
    return 24.0;
  }

  /// Get horizontal padding
  double get horizontalPadding {
    if (width < 400) return 16.0;
    if (width < 600) return 20.0;
    if (width < 900) return 32.0;
    return 48.0;
  }

  /// Get vertical padding
  double get verticalPadding {
    if (width < 400) return 16.0;
    if (width < 600) return 20.0;
    return 24.0;
  }

  /// Bigger tiles for picture + word modules (body, family, vehicles…).
  int get moduleGridCrossAxisCount {
    if (width < 400) return 2;
    if (width < 700) return 3;
    if (width < 900) return 4;
    return 5;
  }

  /// Home play grid — 2 big tiles on phones (easier for little fingers).
  int get homePlayCrossAxisCount {
    if (width < 600) return 2;
    if (width < 900) return 3;
    return 4;
  }

  /// Taller play cards so module images can be prominent.
  double get homePlayAspectRatio {
    final count = homePlayCrossAxisCount;
    final gap = gridSpacing + 6;
    final cellWidth =
        (width - horizontalPadding * 2 - gap * (count - 1)) / count;
    // Keep room for a larger image preview + title.
    const targetHeight = 198.0;
    return cellWidth / targetHeight;
  }

  /// Large emoji size for learning tiles.
  double emojiSize({double factor = 0.1, double min = 36, double max = 52}) {
    return (width * factor).clamp(min, max);
  }
}

/// Extension to use Responsive directly from BuildContext
extension ResponsiveExtension on BuildContext {
  Responsive get responsive => Responsive(this);
}

