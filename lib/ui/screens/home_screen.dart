import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/alphabet_data.dart';
import '../../utils/responsive.dart';
import '../../utils/haptic_feedback.dart';
import '../widgets/alphabet_tile.dart';
import 'about_screen.dart';
import 'detail_screen.dart';

/// Home screen displaying all 26 letters in a grid
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animationController.forward();

    // Listen to scroll for app bar color change
    _scrollController.addListener(() {
      final scrolled = _scrollController.offset > 20;
      if (scrolled != _isScrolled) {
        setState(() {
          _isScrolled = scrolled;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: responsive.horizontalPadding,
            right: responsive.horizontalPadding,
            top: responsive.verticalPadding,
            bottom: 0, // Remove bottom padding
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 24),
              Expanded(
                child: _buildLetterGrid(context, responsive),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build app bar with scroll-based color change
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: _isScrolled
          ? const Color(0xFFFFF3D0).withValues(alpha: 0.95)
          : Colors.transparent,
      elevation: _isScrolled ? 4 : 0,
      shadowColor: _isScrolled ? Colors.orange.withValues(alpha: 0.2) : null,
      title: Row(
        children: [
          // Bounce animation on logo
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: Image.asset(
              'assets/images/app_logo.png',
              height: 36,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.menu_book_rounded,
                  color: AppColors.primary,
                  size: 36,
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'AlphaZoo',
            style: AppTextStyles.heading2.copyWith(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline, color: AppColors.primary),
          onPressed: () {
            AppHapticFeedback.light(); // Light feedback for info button
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AboutScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  /// Build header section
  Widget _buildHeader(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Learn the Alphabet!',
            style: AppTextStyles.heading1,
          ),
          const SizedBox(height: 8),
          Text(
            'Tap any letter to explore',
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }

  /// Build letter grid
  Widget _buildLetterGrid(BuildContext context, Responsive responsive) {
    return GridView.builder(
      controller: _scrollController,
      // Attach scroll controller
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: responsive.gridCrossAxisCount,
        crossAxisSpacing: responsive.gridSpacing,
        mainAxisSpacing: responsive.gridSpacing,
        childAspectRatio: 1.0,
      ),
      itemCount: AlphabetData.count,
      padding: EdgeInsets.only(bottom: 20),
      itemBuilder: (context, index) {
        final item = AlphabetData.getItem(index);
        final delay = index * 30;

        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            final adjustedAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Interval(
                  (delay / 1000).clamp(0.0, 1.0),
                  ((delay + 300) / 1000).clamp(0.0, 1.0),
                  curve: Curves.easeOut,
                ),
              ),
            );

            return Transform.scale(
              scale: adjustedAnimation.value,
              child: Opacity(
                opacity: adjustedAnimation.value,
                child: child,
              ),
            );
          },
          child: AlphabetTile(
            item: item,
            index: index,
            onTap: () => _navigateToDetail(context, index),
          ),
        );
      },
    );
  }

  /// Navigate to detail screen
  void _navigateToDetail(BuildContext context, int index) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            DetailScreen(initialIndex: index),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}
