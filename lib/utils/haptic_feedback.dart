import 'package:vibration/vibration.dart';

/// Utility class for haptic feedback across the app
class AppHapticFeedback {
  AppHapticFeedback._();

  /// Check if device supports vibration
  static Future<bool> get _hasVibrator async {
    return await Vibration.hasVibrator();
  }

  /// Light feedback for general interactions (taps, selections)
  static Future<void> light() async {
    if (await _hasVibrator) {
      Vibration.vibrate(duration: 50, amplitude: 50);
    }
  }

  /// Medium feedback for important actions (navigation, learning moments)
  static Future<void> medium() async {
    if (await _hasVibrator) {
      Vibration.vibrate(duration: 100, amplitude: 100);
    }
  }

  /// Heavy feedback for significant achievements (completing letters, milestones)
  static Future<void> heavy() async {
    if (await _hasVibrator) {
      Vibration.vibrate(duration: 150, amplitude: 150);
    }
  }

  /// Success feedback for positive learning moments
  static Future<void> success() async {
    if (await _hasVibrator) {
      Vibration.vibrate(pattern: [0, 50, 50, 50]);
    }
  }

  /// Error feedback for incorrect actions (if implemented)
  static Future<void> error() async {
    if (await _hasVibrator) {
      Vibration.vibrate(pattern: [0, 100, 50, 100]);
    }
  }
}
