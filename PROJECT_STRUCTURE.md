# AlphaZoo - Project Structure

Complete overview of the project file organization.

## Directory Tree

```
AlphaZoo/
├── android/                      # Android platform files
├── ios/                          # iOS platform files
├── lib/                          # Main application code
│   ├── main.dart                 # App entry point
│   ├── core/                     # Core app configuration
│   │   ├── app_colors.dart       # Color palette
│   │   ├── app_text_styles.dart  # Typography styles
│   │   └── app_assets.dart       # Asset path management
│   ├── data/                     # Data models and sources
│   │   └── alphabet_data.dart    # Static alphabet data (26 letters)
│   ├── ui/                       # User interface components
│   │   ├── screens/              # Full-screen pages
│   │   │   ├── splash_screen.dart   # Animated splash with logo
│   │   │   ├── home_screen.dart     # Letter grid
│   │   │   ├── detail_screen.dart   # Letter details & audio
│   │   │   └── about_screen.dart    # App information
│   │   └── widgets/              # Reusable UI components
│   │       ├── alphabet_tile.dart      # Grid tile widget
│   │       ├── play_button.dart        # Audio play button
│   │       └── big_letter_widget.dart  # Large letter display
│   └── utils/                    # Utility functions
│       └── responsive.dart       # Responsive layout helpers
├── assets/                       # Static assets
│   ├── images/                   # Image files
│   │   ├── README.txt            # Image setup instructions
│   │   ├── app_logo.png          # App logo (REQUIRED)
│   │   ├── placeholder.png       # Fallback image (optional)
│   │   └── [a-z].png             # 26 letter images (REQUIRED)
│   ├── sounds/                   # Audio files
│   │   ├── README.txt            # Audio setup instructions
│   │   └── [a-z].mp3             # 26 letter sounds (optional)
│   ├── lottie/                   # Lottie animations (optional)
│   │   └── README.txt            # Lottie setup instructions
│   ├── flame/                    # Flame sprites (optional)
│   │   └── README.txt            # Flame setup instructions
│   └── ASSETS_CHECKLIST.md       # Asset tracking checklist
├── scripts/                      # Helper scripts
│   ├── setup.bat                 # Windows setup script
│   ├── setup.sh                  # macOS/Linux setup script
│   ├── build_release.bat         # Windows build script
│   └── build_release.sh          # macOS/Linux build script
├── tools/                        # Development tools
│   └── image_extractor_guide.md  # Guide for extracting letter images
├── test/                         # Unit and widget tests
│   └── widget_test.dart          # Default widget test
├── .gitignore                    # Git ignore rules
├── pubspec.yaml                  # Project dependencies
├── pubspec.lock                  # Locked dependency versions
├── README.md                     # Main documentation
├── QUICKSTART.md                 # Quick start guide
├── SETUP_INSTRUCTIONS.md         # Detailed setup guide
├── PROJECT_STRUCTURE.md          # This file
├── CHANGELOG.md                  # Version history
├── CONTRIBUTING.md               # Contribution guidelines
├── LICENSE                       # MIT License
└── analysis_options.yaml         # Linter configuration
```

## File Descriptions

### Core Application Files

#### `lib/main.dart`
- App entry point
- Configures MaterialApp
- Sets up theme and navigation
- Initializes app-wide settings

#### `lib/core/app_colors.dart`
- Centralized color definitions
- Kid-friendly color palette
- Letter-specific color rotation
- Shadow colors

#### `lib/core/app_text_styles.dart`
- Typography definitions using Google Fonts
- Consistent text styling
- Uses Fredoka and Baloo 2 fonts
- Sizes for different UI elements

#### `lib/core/app_assets.dart`
- Asset path management
- Centralized asset references
- Helper functions for asset paths

### Data Layer

#### `lib/data/alphabet_data.dart`
- AlphabetItem model class
- Static list of 26 letters
- Associated words and descriptions
- Image and sound file references

### UI Layer

#### `lib/ui/screens/splash_screen.dart`
- Animated splash screen
- App logo display
- Optional Flame particle effects
- Auto-navigation to home

#### `lib/ui/screens/home_screen.dart`
- Grid of 26 letter tiles
- Responsive layout
- Staggered entrance animations
- Navigation to detail screen

#### `lib/ui/screens/detail_screen.dart`
- Large letter display with Hero animation
- Letter image
- Word and description
- Audio playback button
- Next/Previous navigation

#### `lib/ui/screens/about_screen.dart`
- App information
- Usage instructions
- Customization guide
- Credits and version info

#### `lib/ui/widgets/alphabet_tile.dart`
- Individual letter tile for grid
- Tap animation
- Color from palette
- Hero tag for transition

#### `lib/ui/widgets/play_button.dart`
- Audio playback button
- Pulse animation when playing
- Visual state feedback

#### `lib/ui/widgets/big_letter_widget.dart`
- Large circular letter display
- Gradient background
- Shadow effects

### Utilities

#### `lib/utils/responsive.dart`
- Screen size utilities
- Responsive layout helpers
- Grid configuration
- Padding and spacing calculations

### Assets

#### `assets/images/`
- App logo
- Letter images (a.png - z.png)
- Placeholder for missing images

#### `assets/sounds/`
- Letter pronunciation audio (a.mp3 - z.mp3)
- Optional but recommended

#### `assets/lottie/`
- Optional Lottie animations
- JSON format
- Enhances visual appeal

#### `assets/flame/`
- Optional Flame sprites
- PNG format
- For particle effects

### Documentation

#### `README.md`
- Comprehensive app documentation
- Features overview
- Setup instructions
- Customization guide

#### `QUICKSTART.md`
- Fast setup guide
- Essential steps only
- Troubleshooting tips

#### `SETUP_INSTRUCTIONS.md`
- Detailed setup process
- Asset preparation
- Configuration options
- Testing checklist

#### `PROJECT_STRUCTURE.md`
- This file
- Complete file organization
- Purpose of each file

#### `CHANGELOG.md`
- Version history
- Release notes
- Planned features

#### `CONTRIBUTING.md`
- Contribution guidelines
- Code style rules
- PR process

#### `LICENSE`
- MIT License
- Usage rights

### Scripts

#### `scripts/setup.bat` / `scripts/setup.sh`
- Automated setup
- Dependency installation
- Cache cleaning

#### `scripts/build_release.bat` / `scripts/build_release.sh`
- Automated release build
- APK generation
- Build verification

### Configuration Files

#### `pubspec.yaml`
- Package dependencies
- Asset declarations
- App metadata
- SDK version constraints

#### `analysis_options.yaml`
- Dart linter configuration
- Code quality rules

#### `.gitignore`
- Git ignore rules
- Build artifacts
- IDE files

## Code Organization Principles

### Separation of Concerns
- **Core**: App-wide configuration
- **Data**: Models and data sources
- **UI**: Visual components
- **Utils**: Helper functions

### State Management
- Uses `setState` only (no external packages)
- State contained in StatefulWidgets
- No global state management

### Widget Composition
- Small, focused widgets
- Reusable components
- Clear widget hierarchy

### Asset Management
- Centralized in `app_assets.dart`
- Type-safe asset references
- Easy to update paths

### Responsive Design
- Utilities in `responsive.dart`
- Adaptive layouts
- Works on all screen sizes

## Dependencies

### Production
- `audioplayers: ^6.0.0` - Audio playback
- `google_fonts: ^6.1.0` - Custom fonts
- `lottie: ^3.0.0` - Lottie animations
- `flame: ^1.16.0` - 2D animations

### Development
- `flutter_test` - Testing framework
- `flutter_lints: ^5.0.0` - Linting rules

## Build Outputs

### Android
```
build/app/outputs/flutter-apk/
├── app-release.apk          # Release APK
└── app-debug.apk            # Debug APK
```

### iOS
```
build/ios/iphoneos/
└── Runner.app               # iOS app bundle
```

## Testing Structure

```
test/
├── widget_test.dart         # Widget tests
├── unit/                    # Unit tests (to be added)
└── integration/             # Integration tests (to be added)
```

## Customization Points

### Visual Customization
- Colors: `lib/core/app_colors.dart`
- Fonts: `lib/core/app_text_styles.dart`
- Assets: `assets/` directories

### Content Customization
- Letter data: `lib/data/alphabet_data.dart`
- Words and descriptions
- Image and sound file references

### Behavior Customization
- Animation durations: In screen files
- Grid layout: `lib/utils/responsive.dart`
- Navigation: `lib/ui/screens/` files

## Adding New Features

### Adding a New Screen
1. Create file in `lib/ui/screens/`
2. Define StatefulWidget
3. Add navigation from existing screens
4. Update relevant widgets

### Adding New Widgets
1. Create file in `lib/ui/widgets/`
2. Define StatelessWidget or StatefulWidget
3. Import and use in screens

### Adding New Assets
1. Place files in `assets/` subdirectories
2. Update `pubspec.yaml` if needed
3. Add references in `app_assets.dart`
4. Use in widgets

## Performance Considerations

- Images lazy-loaded
- Animations optimized (60 FPS)
- Minimal widget rebuilds
- Efficient state management

## Future Structure

Potential additions:
```
lib/
├── services/               # API services (if needed)
├── models/                 # Additional data models
├── animations/             # Custom animations
└── l10n/                   # Localization files
```

## Questions?

See documentation files:
- README.md for general info
- SETUP_INSTRUCTIONS.md for setup
- CONTRIBUTING.md for contributions

