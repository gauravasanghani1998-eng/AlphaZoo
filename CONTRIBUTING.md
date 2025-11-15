# Contributing to AlphaZoo

Thank you for your interest in contributing to AlphaZoo! This document provides guidelines for contributing to the project.

## How to Contribute

### Reporting Bugs

If you find a bug, please create an issue with:
- A clear description of the problem
- Steps to reproduce the issue
- Expected vs actual behavior
- Screenshots if applicable
- Device/OS information

### Suggesting Features

Feature suggestions are welcome! Please create an issue with:
- A clear description of the feature
- Why it would be useful
- How it might work
- Mockups/examples if applicable

### Code Contributions

1. **Fork the repository**
   ```bash
   git clone https://github.com/yourusername/alphazoo.git
   cd alphazoo
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Follow the existing code style
   - Add comments where necessary
   - Ensure code is well-structured
   - Test your changes thoroughly

4. **Run linter and tests**
   ```bash
   flutter analyze
   flutter test
   ```

5. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add: description of your changes"
   ```

6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Create a Pull Request**
   - Provide a clear description of changes
   - Reference any related issues
   - Include screenshots for UI changes

## Code Style Guidelines

### Dart/Flutter

- Follow the official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Keep functions small and focused
- Add documentation comments for public APIs
- Use `const` constructors where possible

### File Organization

- Place screens in `lib/ui/screens/`
- Place reusable widgets in `lib/ui/widgets/`
- Place data models in `lib/data/`
- Place utilities in `lib/utils/`
- Place core app config in `lib/core/`

### Naming Conventions

- Classes: `PascalCase`
- Files: `snake_case.dart`
- Variables/Functions: `camelCase`
- Constants: `camelCase` with `const` keyword
- Private members: prefix with `_`

## Asset Contributions

### Images

If contributing images:
- Provide high-quality PNG files (500x500px minimum)
- Ensure images are kid-friendly
- Provide images with transparent backgrounds where appropriate
- Ensure you have rights to distribute the images
- Include attribution if required

### Audio

If contributing audio files:
- Provide clear, high-quality MP3 files
- Keep files 3-5 seconds in length
- Use appropriate compression (64-128 kbps)
- Ensure pronunciation is clear and accurate
- Use a kid-friendly voice
- Ensure you have rights to distribute the audio

### Animations

If contributing Lottie or Flame assets:
- Ensure animations are smooth (60 FPS)
- Keep file sizes small
- Test on multiple devices
- Ensure you have rights to distribute the animations

## Testing

- Test on both Android and iOS if possible
- Test on different screen sizes
- Test with missing assets (app should not crash)
- Test audio playback on different devices
- Verify animations are smooth

## Documentation

- Update README.md if adding features
- Update SETUP_INSTRUCTIONS.md if changing setup process
- Add code comments for complex logic
- Update CHANGELOG.md with your changes

## Questions?

If you have questions:
- Check existing documentation
- Review closed issues
- Create a new issue with the "question" label

## Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on the code, not the person
- Help others learn and grow

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

Thank you for making AlphaZoo better! 🎉

