# AlphaZoo - Quick Start Guide

Get AlphaZoo running in 5 minutes! ⚡

## Prerequisites

- Flutter SDK installed ([Get Flutter](https://flutter.dev/docs/get-started/install))
- Android Studio or VS Code with Flutter extensions
- Android device/emulator or iOS device/simulator

## Step 1: Clone/Download Project

You already have the project files!

## Step 2: Install Dependencies

Open a terminal in the project directory and run:

```bash
flutter pub get
```

## Step 3: Add Assets

### REQUIRED: App Logo

Save the provided app logo image as:
```
assets/images/app_logo.png
```

### REQUIRED: Letter Images

You need 26 images named `a.png` through `z.png` in the `assets/images/` folder.

**Quick Options:**

**Option A - Extract from Collection**
Use the provided A-Z collection image and extract individual letters:
- See `tools/image_extractor_guide.md` for detailed instructions
- Use GIMP, Photoshop, or Photopea (free)
- Save each letter as `a.png`, `b.png`, etc.

**Option B - Use Placeholders for Testing**
Create simple placeholder images to test the app first:
- Use any 26 images (can be anything for now)
- Rename them `a.png` through `z.png`
- Place in `assets/images/`

**Option C - Skip for Now**
The app will show fallback icons if images are missing. You can test the basic functionality without them.

### OPTIONAL: Audio Files

Add MP3 files for each letter:
```
assets/sounds/a.mp3
assets/sounds/b.mp3
...
assets/sounds/z.mp3
```

The app works without these, but the play button will be disabled.

## Step 4: Run the App

### Using Command Line

```bash
# Connect your device or start an emulator, then:
flutter run
```

### Using VS Code

1. Open Command Palette (Ctrl+Shift+P / Cmd+Shift+P)
2. Type "Flutter: Select Device"
3. Choose your device
4. Press F5 or click "Run > Start Debugging"

### Using Android Studio

1. Select your device from the device dropdown
2. Click the green Run button (▶️)

## Step 5: Test the App

You should see:
1. ✨ Animated splash screen with app logo
2. 🔤 Grid of 26 letters (A-Z)
3. Tap any letter to see details
4. 🎵 Play button (works if audio files added)
5. ⬅️ ➡️ Next/Previous buttons to navigate

## Troubleshooting

### "SDK version mismatch"
The pubspec.yaml is set to work with Flutter SDK >=3.0.0. If you have an older version:
```bash
flutter upgrade
```

### "Assets not found"
1. Verify files are in correct folders:
   - Images: `assets/images/`
   - Sounds: `assets/sounds/`
2. Check file names are lowercase
3. Run:
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

### "Build failed"
1. Clean and rebuild:
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```
2. Check Flutter doctor:
   ```bash
   flutter doctor -v
   ```

### "Images not showing"
The app has fallback icons. If you want to see actual images:
1. Add at least one image (e.g., `a.png`)
2. Restart the app
3. Navigate to that letter

### "Sound not playing"
1. Check file format is MP3
2. Check file name is lowercase (e.g., `a.mp3`)
3. Try with a different audio file
4. On iOS, ensure audio session is configured properly

## Next Steps

Once the app is running:

1. ✅ Add all 26 letter images
2. ✅ Add audio files for pronunciation
3. ✅ Customize colors in `lib/core/app_colors.dart`
4. ✅ Customize fonts in `lib/core/app_text_styles.dart`
5. ✅ Update letter descriptions in `lib/data/alphabet_data.dart`
6. ✅ Build release version:
   ```bash
   flutter build apk --release  # Android
   flutter build ios --release  # iOS
   ```

## Full Documentation

For detailed information, see:

- `README.md` - Complete documentation
- `SETUP_INSTRUCTIONS.md` - Detailed setup guide
- `tools/image_extractor_guide.md` - Image extraction help
- `assets/ASSETS_CHECKLIST.md` - Asset tracking checklist
- `CONTRIBUTING.md` - Contribution guidelines

## Common Commands

```bash
# Install dependencies
flutter pub get

# Run in debug mode
flutter run

# Run in release mode
flutter run --release

# Build APK (Android)
flutter build apk --release

# Build App Bundle (Android)
flutter build appbundle --release

# Build iOS
flutter build ios --release

# Check for issues
flutter doctor

# Analyze code
flutter analyze

# Clean build cache
flutter clean

# Update dependencies
flutter pub upgrade
```

## Need Help?

1. Check the documentation files listed above
2. Review the code comments
3. Check `flutter doctor` output
4. Create an issue on the repository

## Success! 🎉

If you see the colorful letter grid, congratulations! AlphaZoo is running!

Now add your assets and customize the app to make it your own.

Happy coding! 🚀

