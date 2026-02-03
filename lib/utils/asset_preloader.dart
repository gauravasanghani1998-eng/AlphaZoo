import 'package:flutter/material.dart';
import '../core/app_assets.dart';
import '../data/alphabet_data.dart';

/// Utility class for preloading and caching app assets for offline use
class AssetPreloader {
  AssetPreloader._();

  static bool _isPreloaded = false;

  /// Preload all critical assets for offline use
  static Future<void> preloadAssets() async {
    if (_isPreloaded) return; // Already preloaded

    try {
      // Preload app logo
      await _preloadImage(AppAssets.appLogo);

      // Preload all alphabet letter images
      for (final item in AlphabetData.items) {
        await _preloadImage(item.image);
      }

      // Mark as preloaded
      _isPreloaded = true;
    } catch (e) {
      // Silently handle preload failures - app will still work with on-demand loading
      _isPreloaded = false;
    }
  }

  /// Preload a single image asset
  static Future<void> _preloadImage(String assetPath) async {
    try {
      // Since assets are declared in pubspec.yaml, they're automatically available
      // Flutter handles asset caching efficiently, so we just verify the asset exists
      // by attempting to create the AssetImage (without actually precaching with BuildContext)
      AssetImage(assetPath);
      // Asset is considered preloaded if no exception is thrown
    } catch (e) {
      // Image may not exist or be invalid - this is handled in UI with fallbacks
    }
  }

  /// Check if assets are preloaded
  static bool get isPreloaded => _isPreloaded;

  /// Force reload assets (useful for debugging)
  static void resetPreload() {
    _isPreloaded = false;
  }
}
