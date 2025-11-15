#!/bin/bash
# AlphaZoo Setup Script for macOS/Linux
# This script helps set up the Flutter project

echo "========================================"
echo "  AlphaZoo - Setup Script"
echo "========================================"
echo

echo "[1/3] Checking Flutter installation..."
if ! command -v flutter &> /dev/null; then
    echo "ERROR: Flutter is not installed or not in PATH"
    echo "Please install Flutter from: https://flutter.dev"
    exit 1
fi
flutter --version
echo "Flutter found!"
echo

echo "[2/3] Installing dependencies..."
flutter pub get
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to get dependencies"
    exit 1
fi
echo "Dependencies installed!"
echo

echo "[3/3] Cleaning build cache..."
flutter clean
echo "Build cache cleaned!"
echo

echo "========================================"
echo "  Setup Complete!"
echo "========================================"
echo
echo "Next steps:"
echo "1. Add your assets (images and sounds)"
echo "2. Run: flutter run"
echo
echo "For detailed instructions, see:"
echo "- QUICKSTART.md"
echo "- SETUP_INSTRUCTIONS.md"
echo

