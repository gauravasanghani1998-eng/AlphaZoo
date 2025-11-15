# AlphaZoo Setup Instructions

## Quick Start Guide

Follow these steps to get AlphaZoo running on your device:

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Add Required Assets

#### App Logo (REQUIRED)
The app logo image has been provided in the prompt. Save it as:
```
assets/images/app_logo.png
```

#### Letter Images (REQUIRED for full functionality)
You have two options:

**Option A: Extract from provided collection**
The A-Z alphabet illustration image provided shows all 26 letters. You can:
1. Use an image editor (Photoshop, GIMP, etc.)
2. Crop each letter individually
3. Save as `a.png`, `b.png`, ... `z.png` in `assets/images/`
4. Recommended size: 500x500px per letter

**Option B: Use your own images**
1. Create or source 26 kid-friendly images
2. Name them `a.png` through `z.png` (lowercase)
3. Place in `assets/images/`

**Option C: Create placeholder**
For testing, you can create simple placeholder images or the app will show a fallback icon.

#### Placeholder Image (OPTIONAL)
Create a simple placeholder image:
```
assets/images/placeholder.png
```
Or the app will use a default icon when images are missing.

#### Audio Files (OPTIONAL but recommended)
Add MP3 files for each letter:
```
assets/sounds/a.mp3
assets/sounds/b.mp3
...
assets/sounds/z.mp3
```

The app works without audio files, but the play button will be disabled.

### 3. Run the App

```bash
# For development
flutter run

# For release (Android)
flutter build apk --release

# For release (iOS)
flutter build ios --release
```

## Detailed Asset Setup

### Creating a Simple Placeholder

You can create a simple colored square as a placeholder using any image editor:
- Size: 500x500px
- Format: PNG
- Color: Any bright color
- Save as: `assets/images/placeholder.png`

### Letter Image Requirements

Each letter image should:
- Represent the letter clearly (e.g., A = Apple, B = Ball)
- Be bright and colorful (kid-friendly)
- Have high quality (minimum 500x500px)
- Be in PNG format (transparency supported)
- Match the word in `lib/data/alphabet_data.dart`

### Audio Requirements

Each audio file should:
- Be 3-5 seconds long
- Contain clear pronunciation of the letter
- Be in MP3 format
- Be compressed (64-128 kbps for smaller app size)
- Named in lowercase (a.mp3, not A.mp3)

## Customization

### Changing Letter Words/Descriptions

Edit `lib/data/alphabet_data.dart`:

```dart
AlphabetItem(
  letter: 'A',
  image: AppAssets.letterImage('a'),
  sound: AppAssets.letterSound('a'),
  word: 'Apple',              // Change this
  description: 'Your text',   // Change this
),
```

### Changing Colors

Edit `lib/core/app_colors.dart`:

```dart
static const Color primary = Color(0xFF4ECDC4);    // Main color
static const Color secondary = Color(0xFFFF6B9D);  // Accent color
static const Color accent = Color(0xFFFFC75F);     // Button color
```

### Changing Fonts

Edit `lib/core/app_text_styles.dart` to use different Google Fonts.

## Troubleshooting

### Images Not Showing
- Check file names are lowercase (a.png not A.png)
- Verify files are in `assets/images/`
- Run `flutter pub get` and `flutter clean`
- Rebuild the app

### Sounds Not Playing
- Check file names are lowercase (a.mp3 not A.mp3)
- Verify files are in `assets/sounds/`
- Check MP3 format is compatible
- Android: Ensure files are properly compressed

### Build Errors
```bash
flutter clean
flutter pub get
flutter run
```

### Assets Not Loading
- Check `pubspec.yaml` has assets listed
- Ensure proper indentation in `pubspec.yaml`
- Run `flutter pub get` after any pubspec changes

## Optional Enhancements

### Add Lottie Animations
1. Download animations from LottieFiles.com
2. Place JSON files in `assets/lottie/`
3. Update splash_screen.dart to use them

### Add Flame Sprites
1. Create small sprite images (32x32 to 128x128px)
2. Place in `assets/flame/`
3. The app already includes basic Flame particle effects

### Update App Icon
```bash
# Add to pubspec.yaml dev_dependencies:
flutter_launcher_icons: ^0.13.1

# Add configuration:
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/images/app_logo.png"

# Run:
flutter pub get
flutter pub run flutter_launcher_icons
```

## Testing Checklist

- [ ] App launches with splash screen
- [ ] All 26 letters visible in grid
- [ ] Tap animation works on tiles
- [ ] Detail screen opens with Hero animation
- [ ] Images load correctly
- [ ] Play button works (if sounds added)
- [ ] Next/Previous navigation works
- [ ] About screen accessible
- [ ] App handles missing assets gracefully
- [ ] Responsive on different screen sizes

## Support

For issues:
1. Check this documentation
2. Review code comments in `lib/` files
3. Check asset paths in `lib/core/app_assets.dart`
4. Verify file names and locations

## Next Steps

1. Add all 26 letter images
2. Record or source audio files
3. Test on device
4. Customize colors/fonts if desired
5. Build release version
6. Deploy to stores

Happy building! 🎉

