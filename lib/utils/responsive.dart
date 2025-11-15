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
}

/// Extension to use Responsive directly from BuildContext
extension ResponsiveExtension on BuildContext {
  Responsive get responsive => Responsive(this);
}

