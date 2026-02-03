@echo off
echo ========================================
echo AlphaZoo Release Build Script
echo ========================================

echo.
echo Building Android APK...
flutter build apk --release

if %errorlevel% neq 0 (
    echo Android build failed!
    pause
    exit /b 1
)

echo.
echo Building Android App Bundle...
flutter build appbundle --release

if %errorlevel% neq 0 (
    echo Android App Bundle build failed!
    pause
    exit /b 1
)

echo.
echo Building iOS (requires macOS)...
flutter build ios --release

echo.
echo ========================================
echo Build completed successfully!
echo.
echo Files created:
echo - Android APK: build/app/outputs/flutter-apk/app-release.apk
echo - Android Bundle: build/app/outputs/bundle/release/app-release.aab
echo - iOS: build/ios/iphoneos/Runner.app (on macOS)
echo.
echo Next steps:
echo 1. Test the APK on Android devices
echo 2. Upload AAB to Google Play Console
echo 3. Build iOS on macOS and upload to App Store
echo ========================================
pause