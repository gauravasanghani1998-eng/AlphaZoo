# Changelog

All notable changes to AlphaZoo will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2025-11-15

### Removed
- **Audio functionality** - Removed all sound/audio features
  - Removed `audioplayers` dependency
  - Removed play button from detail screen
  - Removed sound field from AlphabetItem model
  - Removed assets/sounds/ folder
  - App now focuses purely on visual learning

### Changed
- Detail screen now shows only letter, image, word, and description
- Simplified navigation - removed audio playback button
- Updated documentation to reflect no-audio approach

## [1.0.0] - 2025-11-15

### Added
- Initial release of AlphaZoo
- Complete A-Z alphabet learning experience
- 4 main screens:
  - Animated splash screen with logo and Flame particle effects
  - Home screen with responsive grid of all 26 letters
  - Detail screen with letter information and image
  - About screen with app information and credits
- Features:
  - Hero animations between screens
  - Tap animations on letter tiles
  - Next/Previous navigation in detail screen
  - Responsive design for all screen sizes
  - Graceful error handling for missing assets
  - Kid-friendly UI with bright colors and custom fonts (Fredoka, Baloo 2)
- Optional integrations:
  - Flame engine for particle animations
  - Lottie animation support
- Complete documentation:
  - README.md with full app documentation
  - QUICKSTART.md for easy setup
  - SETUP_INSTRUCTIONS.md for detailed setup process
  - ASSETS_CHECKLIST.md to track asset additions
  - CONTRIBUTING.md for contributors
  - Asset folder READMEs with detailed instructions
- Clean, structured codebase:
  - Separated concerns (core, data, UI, utils)
  - Reusable widgets
  - Centralized color and text style management
  - Asset path management
  - Responsive utilities
- Complete Flutter project structure
- MIT License
- .gitignore configured for Flutter

### Technical Details
- Flutter SDK: >=3.0.0 <4.0.0
- Dependencies:
  - google_fonts: ^6.1.0
  - lottie: ^3.0.0
  - flame: ^1.16.0
- No external state management (uses setState)
- Portrait orientation only
- Supports Android and iOS

### Known Limitations
- Images not included (must be added by user)
- English language only
- Portrait mode only
- No audio functionality

## [Unreleased]

### Planned Features
- Multiple language support
- Letter tracing/writing practice
- Quiz mode
- Landscape mode support
- Parental dashboard
- Progress tracking
- More interactive animations

---

## Version History Notes

### Version Numbering
- Major.Minor.Patch format
- Major: Breaking changes or major new features
- Minor: New features, backward compatible
- Patch: Bug fixes, minor improvements

### Release Process
1. Update version in pubspec.yaml
2. Update CHANGELOG.md
3. Create git tag
4. Build release APK/IPA
5. Deploy to stores (if applicable)
