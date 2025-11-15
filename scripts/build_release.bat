@echo off
REM AlphaZoo Build Script for Windows
REM Build release APK for Android

echo ========================================
echo   AlphaZoo - Build Release APK
echo ========================================
echo.

echo Cleaning previous builds...
flutter clean
echo.

echo Getting dependencies...
flutter pub get
echo.

echo Building release APK...
flutter build apk --release
echo.

if %ERRORLEVEL% EQU 0 (
    echo ========================================
    echo   Build Successful!
    echo ========================================
    echo.
    echo Your APK is located at:
    echo build\app\outputs\flutter-apk\app-release.apk
    echo.
) else (
    echo ========================================
    echo   Build Failed!
    echo ========================================
    echo.
    echo Check the error messages above.
)

pause

