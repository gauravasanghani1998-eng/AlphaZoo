import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/alphabet_data.dart';
import '../../utils/responsive.dart';
import '../widgets/big_letter_widget.dart';

/// Detail screen showing letter information with animations
class DetailScreen extends StatefulWidget {
  final int initialIndex;

  const DetailScreen({
    super.key,
    required this.initialIndex,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  late int _currentIndex;
  late AnimationController _contentController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;

    // Content animation controller
    _contentController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Scale animation controller
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOut),
    );

    _contentController.forward();
  }

  @override
  void dispose() {
    _contentController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  /// Change to next/previous letter with animation
  void _changeLetter(int newIndex) {
    if (newIndex < 0 || newIndex >= AlphabetData.count) return;

    setState(() {
      _currentIndex = newIndex;
    });

    _contentController.reset();
    _contentController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final item = AlphabetData.getItem(_currentIndex);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            // Optional Flame background effects could go here
            
            // Main content
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsive.horizontalPadding,
                vertical: responsive.verticalPadding,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: AnimatedBuilder(
                        animation: _contentController,
                        builder: (context, child) {
                          return FadeTransition(
                            opacity: _fadeAnimation,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: child,
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            _buildLetterDisplay(item),
                            const SizedBox(height: 32),
                            _buildImage(item),
                            const SizedBox(height: 32),
                            _buildWord(item),
                            const SizedBox(height: 16),
                            _buildDescription(item),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildNavigationButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build app bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.primary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Letter ${AlphabetData.getItem(_currentIndex).letter}',
        style: AppTextStyles.heading3.copyWith(color: AppColors.primary),
      ),
      centerTitle: true,
    );
  }

  /// Build large letter display
  Widget _buildLetterDisplay(AlphabetItem item) {
    return Hero(
      tag: 'letter_${item.letter}',
      child: BigLetterWidget(
        letter: item.letter,
        color: AppColors.getLetterColor(_currentIndex),
      ),
    );
  }

  /// Build letter image
  Widget _buildImage(AlphabetItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDark,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(
          item.image,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 200,
              color: AppColors.getLetterColor(_currentIndex).withOpacity(0.1),
              child: const Center(
                child: Icon(
                  Icons.image_not_supported,
                  size: 64,
                  color: AppColors.textSecondary,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Build word text
  Widget _buildWord(AlphabetItem item) {
    return Text(
      item.word,
      style: AppTextStyles.word,
      textAlign: TextAlign.center,
    );
  }

  /// Build description text
  Widget _buildDescription(AlphabetItem item) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        item.description,
        style: AppTextStyles.body,
        textAlign: TextAlign.center,
      ),
    );
  }

  /// Build navigation buttons
  Widget _buildNavigationButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildNavButton(
            label: 'Previous',
            icon: Icons.arrow_back,
            onPressed: _currentIndex > 0
                ? () => _changeLetter(_currentIndex - 1)
                : null,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildNavButton(
            label: 'Next',
            icon: Icons.arrow_forward,
            onPressed: _currentIndex < AlphabetData.count - 1
                ? () => _changeLetter(_currentIndex + 1)
                : null,
            isNext: true,
          ),
        ),
      ],
    );
  }

  /// Build individual navigation button
  Widget _buildNavButton({
    required String label,
    required IconData icon,
    required VoidCallback? onPressed,
    bool isNext = false,
  }) {
    final isEnabled = onPressed != null;

    return GestureDetector(
      onTapDown: isEnabled ? (_) => _scaleController.forward() : null,
      onTapUp: isEnabled ? (_) => _scaleController.reverse() : null,
      onTapCancel: isEnabled ? () => _scaleController.reverse() : null,
      onTap: onPressed,
      child: AnimatedBuilder(
        animation: _scaleController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 - (_scaleController.value * 0.1),
            child: child,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: isEnabled
                ? LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  )
                : null,
            color: isEnabled ? null : AppColors.textSecondary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
            boxShadow: isEnabled
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isNext) Icon(icon, color: Colors.white),
              if (!isNext) const SizedBox(width: 8),
              Text(label, style: AppTextStyles.button),
              if (isNext) const SizedBox(width: 8),
              if (isNext) Icon(icon, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
