# AlphaZoo

A colorful and interactive A-Z alphabet learning app for kids, built with Flutter.

## Features

- 🎨 Beautiful, kid-friendly UI with bright colors
- 🔤 Complete A-Z alphabet with images and descriptions
- 📚 Educational content for each letter
- ✨ Smooth animations using Flutter and optional Flame engine
- 📱 Fully responsive design for all screen sizes
- 🏠 4 screens: Splash, Home (grid), Detail, About
- 🎯 No external dependencies - works completely offline

## Screenshots

> Add your app screenshots here after building

## Getting Started

### Prerequisites

- Flutter SDK 3.x or higher
- Dart 3.x or higher
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone this repository:
```bash
git clone <your-repo-url>
cd AlphaZoo
```

2. Install dependencies:
```bash
flutter pub get
```

3. Add your assets (see [Adding Assets](#adding-assets) below)

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── core/
│   ├── app_colors.dart         # Color palette
│   ├── app_text_styles.dart    # Typography styles
│   └── app_assets.dart         # Asset path management
├── data/
│   └── alphabet_data.dart      # Static alphabet data (26 letters)
├── ui/
│   ├── screens/
│   │   ├── splash_screen.dart  # Animated splash with logo
│   │   ├── home_screen.dart    # Grid of all letters
│   │   ├── detail_screen.dart  # Letter detail with sound
│   │   └── about_screen.dart   # App information
│   └── widgets/
│       ├── alphabet_tile.dart  # Grid tile widget
│       ├── play_button.dart    # Audio play button
│       └── big_letter_widget.dart # Large letter display
└── utils/
    └── responsive.dart          # Responsive layout utilities

assets/
├── images/
│   ├── app_logo.png            # App logo
│   ├── placeholder.png         # Fallback image
│   ├── a.png ... z.png         # Letter images
├── sounds/
│   └── a.mp3 ... z.mp3         # Letter sounds (optional)
├── lottie/                      # Lottie animations (optional)
└── flame/                       # Flame sprites (optional)
```

## Adding Assets

### Images

1. Prepare 26 letter images named `a.png`, `b.png`, ... `z.png`
2. Place them in `assets/images/`
3. Ensure each image is:
   - High quality (PNG format recommended)
   - Appropriately sized (500x500px or similar)
   - Kid-friendly illustrations

### App Logo

1. Replace `assets/images/app_logo.png` with your logo
2. Recommended size: 512x512px, transparent background
3. Update app icon using `flutter_launcher_icons` or manually

### Sounds

1. Prepare 26 audio files named `a.mp3`, `b.mp3`, ... `z.mp3`
2. Place them in `assets/sounds/`
3. Keep files small (5-10 seconds, compressed MP3)
4. The app will gracefully handle missing sound files

### Verifying Assets

After adding assets, run:
```bash
flutter pub get
flutter clean
flutter run
```

## Dependencies

This app uses minimal, carefully selected packages:

- `google_fonts: ^6.1.0` - Kid-friendly fonts (Fredoka, Baloo 2)
- `lottie: ^3.0.0` - Optional Lottie animations
- `flame: ^1.16.0` - Optional 2D animations (particles, stars)

## Building for Production

### Android

```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

### Update App Icon

1. Install `flutter_launcher_icons`:
```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1

flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/images/app_logo.png"
```

2. Generate icons:
```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

## Optional Features

### Flame Animations

The app includes optional Flame engine integration for:
- Floating particles in splash screen
- Stars and sparkles in detail screen
- Background parallax effects

These animations work without additional assets but can be enhanced with custom sprites in `assets/flame/`.

### Lottie Animations

You can add Lottie JSON files to `assets/lottie/` for:
- Splash screen animations
- Decorative elements
- Loading indicators

The app works perfectly without Lottie files.

## Customization

### Changing Colors

Edit `lib/core/app_colors.dart`:
```dart
static const Color primary = Color(0xFF4ECDC4);  // Change this
static const Color secondary = Color(0xFFFF6B9D); // And this
```

### Changing Fonts

Edit `lib/core/app_text_styles.dart`:
```dart
static TextStyle get heading1 => GoogleFonts.fredoka(  // Change font
  fontSize: 32,
  fontWeight: FontWeight.bold,
);
```

### Updating Letter Content

Edit `lib/data/alphabet_data.dart`:
```dart
AlphabetItem(
  letter: 'A',
  word: 'Apple',  // Change word
  description: 'Your description here',  // Change description
),
```

## Error Handling

The app gracefully handles:
- Missing image files → Shows placeholder
- Missing sound files → Disables play button with message
- Network issues → N/A (fully local app)
- Invalid assets → Fallback to default UI elements

## Performance

- Optimized animations (60 FPS)
- Lazy loading of assets
- Efficient memory management
- No unnecessary rebuilds

## Known Limitations

- Sounds must be manually added (not included by default)
- Images must be manually added (not included by default)
- Portrait orientation only
- English language only (easily extendable)

## Future Enhancements

- [ ] Add more languages
- [ ] Include tracing/writing practice
- [ ] Add quiz mode
- [ ] Include animal sounds
- [ ] Add parental dashboard
- [ ] Landscape mode support

## Contributing

Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## License

This project is licensed under the MIT License - see LICENSE file for details.

## Credits

- Built with Flutter 3.x
- Uses Google Fonts (Fredoka, Baloo 2)
- Audio playback via audioplayers package
- Optional animations via Flame engine
- Made with ❤️ for curious kids

## Support

For issues or questions:
- Open an issue on GitHub
- Check existing documentation
- Review the code comments

## Version History

- **1.0.0** (Initial Release)
  - Complete A-Z alphabet
  - 4 screens with animations
  - Audio playback support
  - Responsive design
  - Optional Flame/Lottie animations

---

**Happy Learning! 🎉**
