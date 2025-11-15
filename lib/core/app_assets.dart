/// Central asset path management
class AppAssets {
  AppAssets._();

  // Base paths
  static const String _imagesPath = 'assets/images';
  static const String _lottiePath = 'assets/lottie';
  static const String _flamePath = 'assets/flame';
  
  // App branding
  static const String appLogo = '$_imagesPath/app_logo.png';
  static const String placeholder = '$_imagesPath/placeholder.png';
  
  // Letter images
  static String letterImage(String letter) => '$_imagesPath/${letter.toLowerCase()}.png';
  
  // Lottie animations (optional)
  static const String lottieSplash = '$_lottiePath/splash.json';
  static const String lottieStars = '$_lottiePath/stars.json';
  
  // Flame assets (optional)
  static const String flameParticle = '$_flamePath/particle.png';
  static const String flameStar = '$_flamePath/star.png';
  
  /// Check if an asset exists (simplified - actual implementation would need platform checks)
  static bool assetExists(String path) {
    // This is a placeholder - in production, you'd use proper asset checking
    return true;
  }
}
