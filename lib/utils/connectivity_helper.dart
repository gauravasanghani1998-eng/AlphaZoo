import 'package:connectivity_plus/connectivity_plus.dart';

/// Utility class for handling connectivity and offline support
class ConnectivityHelper {
  ConnectivityHelper._();

  static final Connectivity _connectivity = Connectivity();

  /// Check if device has internet connectivity
  static Future<bool> get isOnline async {
    try {
      final results = await _connectivity.checkConnectivity();
      return results.isNotEmpty &&
          results.any((result) => result != ConnectivityResult.none);
    } catch (e) {
      // If connectivity check fails, assume offline to be safe
      return false;
    }
  }

  /// Get current connectivity status
  static Future<ConnectivityResult> get connectivityStatus async {
    try {
      final results = await _connectivity.checkConnectivity();
      return results.isNotEmpty ? results.first : ConnectivityResult.none;
    } catch (e) {
      return ConnectivityResult.none;
    }
  }

  /// Listen to connectivity changes (returns a stream)
  static Stream<ConnectivityResult> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.map((results) =>
        results.isNotEmpty ? results.first : ConnectivityResult.none);
  }

  /// Check if app is fully functional offline
  static bool get isOfflineCapable => true; // App works completely offline

  /// Get user-friendly connectivity message
  static Future<String> getConnectivityMessage() async {
    final online = await isOnline;
    return online
        ? 'Connected - Full features available'
        : 'Offline mode - All features available locally';
  }
}
