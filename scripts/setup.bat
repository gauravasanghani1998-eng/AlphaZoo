@echo off
REM AlphaZoo Setup Script for Windows
REM This script helps set up the Flutter project

echo ========================================
echo   AlphaZoo - Setup Script
echo ========================================
echo.

echo [1/3] Checking Flutter installation...
flutter --version
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Flutter is not installed or not in PATH
    echo Please install Flutter from: https://flutter.dev
    pause
    exit /b 1
)
echo Flutter found!
echo.

echo [2/3] Installing dependencies...
flutter pub get
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to get dependencies
    pause
    exit /b 1
)
echo Dependencies installed!
echo.

echo [3/3] Cleaning build cache...
flutter clean
echo Build cache cleaned!
echo.

echo ========================================
echo   Setup Complete!
echo ========================================
echo.
echo Next steps:
echo 1. Add your assets (images and sounds)
echo 2. Run: flutter run
echo.
echo For detailed instructions, see:
echo - QUICKSTART.md
echo - SETUP_INSTRUCTIONS.md
echo.
pause

