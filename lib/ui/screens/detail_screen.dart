import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/alphabet_data.dart';
import '../../utils/responsive.dart';
import '../../utils/haptic_feedback.dart';

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

/// Random animation types
enum AnimationType {
  slideFromBottom,
  slideFromTop,
  slideFromLeft,
  slideFromRight,
  fadeIn,
  scaleUp,
  rotateIn,
  zoomSlide,
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  late int _currentIndex;
  late AnimationController _contentController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  // Current animation type
  AnimationType _currentAnimationType = AnimationType.slideFromBottom;
  final math.Random _random = math.Random();

  // Scroll controller for app bar color change
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

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

    // Listen to scroll for app bar color change
    _scrollController.addListener(() {
      final scrolled = _scrollController.offset > 30;
      if (scrolled != _isScrolled) {
        setState(() {
          _isScrolled = scrolled;
        });
      }
    });

    _setupAnimations();
    _contentController.forward();
  }

  /// Setup all animations based on current type
  void _setupAnimations() {
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeIn),
    );

    // Slide animation - changes based on type
    Offset slideBegin;
    switch (_currentAnimationType) {
      case AnimationType.slideFromBottom:
        slideBegin = const Offset(0, 0.5);
        break;
      case AnimationType.slideFromTop:
        slideBegin = const Offset(0, -0.5);
        break;
      case AnimationType.slideFromLeft:
        slideBegin = const Offset(-0.5, 0);
        break;
      case AnimationType.slideFromRight:
        slideBegin = const Offset(0.5, 0);
        break;
      case AnimationType.zoomSlide:
        slideBegin = const Offset(0, 0.3);
        break;
      default:
        slideBegin = Offset.zero;
    }

    _slideAnimation = Tween<Offset>(
      begin: slideBegin,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOutCubic),
    );

    _scaleAnimation = Tween<double>(
      begin: _currentAnimationType == AnimationType.scaleUp ? 0.3 : 0.8,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOutBack),
    );

    _rotateAnimation = Tween<double>(
      begin: _currentAnimationType == AnimationType.rotateIn ? -0.5 : 0.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    _scaleController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Change to next/previous letter with RANDOM animation
  void _changeLetter(int newIndex) {
    if (newIndex < 0 || newIndex >= AlphabetData.count) return;

    // Provide haptic feedback for learning progress
    AppHapticFeedback.success(); // Success feedback for learning new letters

    // Scroll to top immediately
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }

    // Pick a random animation type
    final animationTypes = AnimationType.values;
    _currentAnimationType =
        animationTypes[_random.nextInt(animationTypes.length)];

    setState(() {
      _currentIndex = newIndex;
    });

    // Reset and setup new animations
    _contentController.reset();
    _setupAnimations();
    _contentController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final item = AlphabetData.getItem(_currentIndex);

    return Scaffold(
      backgroundColor:
          const Color(0xFFFFF8E1), // Warm cream yellow matching images
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController, // Attach scroll controller
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.horizontalPadding,
                  vertical: 8,
                ),
                child: AnimatedBuilder(
                  animation: _contentController,
                  builder: (context, child) {
                    return _buildAnimatedContent(child!);
                  },
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      _buildProgressIndicator(),
                      const SizedBox(height: 16),
                      _buildLetterDisplay(item),
                      const SizedBox(height: 16),
                      _buildEncouragementBadge(item),
                      const SizedBox(height: 16),
                      _buildImage(item),
                      const SizedBox(height: 16),
                      _buildWord(item),
                      const SizedBox(height: 16),
                      _buildDivider(),
                      const SizedBox(height: 16),
                      _buildDescription(item),
                      const SizedBox(height: 16),
                      _buildDivider(),
                      const SizedBox(height: 16),
                      _buildFunFact(item),
                      const SizedBox(height: 16),
                      _buildDivider(),
                      const SizedBox(height: 16),
                      _buildLetterInfo(item),
                      const SizedBox(height: 16),
                      _buildCelebrationMessage(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            _buildNavigationButtons(responsive),
          ],
        ),
      ),
    );
  }

  /// Build animated content with random animation type
  Widget _buildAnimatedContent(Widget child) {
    switch (_currentAnimationType) {
      case AnimationType.slideFromBottom:
      case AnimationType.slideFromTop:
      case AnimationType.slideFromLeft:
      case AnimationType.slideFromRight:
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: child,
          ),
        );

      case AnimationType.fadeIn:
        return FadeTransition(
          opacity: _fadeAnimation,
          child: child,
        );

      case AnimationType.scaleUp:
        return FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: child,
          ),
        );

      case AnimationType.rotateIn:
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Transform.rotate(
            angle: _rotateAnimation.value * math.pi,
            child: child,
          ),
        );

      case AnimationType.zoomSlide:
        return FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: child,
            ),
          ),
        );
    }
  }

  /// Build app bar with scroll-based color change
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _isScrolled
          ? AppColors.getLetterColor(_currentIndex).withValues(alpha: 0.9)
          : const Color(0xFFFFF3D0),
      elevation: _isScrolled ? 6 : 2,
      shadowColor: _isScrolled
          ? AppColors.getLetterColor(_currentIndex).withValues(alpha: 0.3)
          : Colors.orange.withValues(alpha: 0.1),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: _isScrolled
              ? Colors.white
              : AppColors.getLetterColor(_currentIndex),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Letter ${AlphabetData.getItem(_currentIndex).letter}',
        style: AppTextStyles.heading3.copyWith(
          color: _isScrolled
              ? Colors.white
              : AppColors.getLetterColor(_currentIndex),
        ),
      ),
      centerTitle: true,
    );
  }

  /// Build progress indicator showing letter position
  Widget _buildProgressIndicator() {
    final progress = (_currentIndex + 1) / AlphabetData.count;
    final letterColor = AppColors.getLetterColor(_currentIndex);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            letterColor.withValues(alpha: 0.1),
            letterColor.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: letterColor.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: letterColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.emoji_events_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Letter ${_currentIndex + 1} of 26',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: letterColor,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: letterColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${(_currentIndex + 1)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: letterColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: letterColor.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(letterColor),
            ),
          ),
        ],
      ),
    );
  }

  /// Build encouragement badge
  Widget _buildEncouragementBadge(AlphabetItem item) {
    final messages = [
      '🌟 Great Job Learning!',
      '🎯 You\'re Amazing!',
      '⭐ Keep Going!',
      '🎉 Fantastic Work!',
      '💪 You\'re Doing Great!',
      '🚀 Super Star!',
    ];
    final message = messages[_currentIndex % messages.length];
    final letterColor = AppColors.getLetterColor(_currentIndex);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            letterColor.withValues(alpha: 0.8),
            letterColor,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: letterColor.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star_rounded, color: Colors.white, size: 24),
          const SizedBox(width: 8),
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.star_rounded, color: Colors.white, size: 24),
        ],
      ),
    );
  }

  /// Build decorative divider
  Widget _buildDivider() {
    final letterColor = AppColors.getLetterColor(_currentIndex);

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.transparent,
                  letterColor.withValues(alpha: 0.5),
                  letterColor,
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: letterColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite,
              color: letterColor,
              size: 16,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  letterColor,
                  letterColor.withValues(alpha: 0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Build improved celebration message with multiple elements
  Widget _buildCelebrationMessage() {
    final letterColor = AppColors.getLetterColor(_currentIndex);
    final isVowel = 'AEIOU'
        .contains(AlphabetData.getItem(_currentIndex).letter.toUpperCase());
    final currentLetter =
        AlphabetData.getItem(_currentIndex).letter.toUpperCase();
    final hasNext = _currentIndex < 25;
    final nextLetter = hasNext
        ? AlphabetData.getItem(_currentIndex + 1).letter.toUpperCase()
        : '';

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            letterColor.withValues(alpha: 0.2),
            letterColor.withValues(alpha: 0.05),
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: letterColor.withValues(alpha: 0.4),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: letterColor.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative stars in corners
          Positioned(
            top: 15,
            left: 15,
            child: Icon(Icons.star,
                color: letterColor.withValues(alpha: 0.3), size: 24),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: Icon(Icons.star,
                color: letterColor.withValues(alpha: 0.3), size: 24),
          ),
          Positioned(
            bottom: 15,
            left: 15,
            child: Icon(Icons.star,
                color: letterColor.withValues(alpha: 0.3), size: 24),
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: Icon(Icons.star,
                color: letterColor.withValues(alpha: 0.3), size: 24),
          ),

          // Main content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Trophy with letter badge
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            letterColor,
                            letterColor.withValues(alpha: 0.7),
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: letterColor.withValues(alpha: 0.4),
                            blurRadius: 15,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        isVowel
                            ? Icons.favorite_rounded
                            : Icons.emoji_events_rounded,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: letterColor, width: 2),
                        ),
                        child: Text(
                          currentLetter,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: letterColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Celebration text
                Text(
                  '🎊 Amazing Work! 🎊',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: letterColor,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 12),

                // Achievement message
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: letterColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: letterColor.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: Text(
                    'You mastered letter $currentLetter!',
                    style: TextStyle(
                      fontSize: 18,
                      color: letterColor,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 16),

                // Special badge for vowels or achievement
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildAchievementChip(
                      icon: isVowel ? Icons.favorite : Icons.star,
                      label: isVowel ? 'Vowel Master!' : 'Letter Pro!',
                      color: letterColor,
                    ),
                    if (_currentIndex + 1 == 26) ...[
                      const SizedBox(width: 8),
                      _buildAchievementChip(
                        icon: Icons.celebration,
                        label: 'Complete!',
                        color: Colors.purple,
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 20),

                // Divider with hearts
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                            color: letterColor.withValues(alpha: 0.3),
                            thickness: 2)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '💫',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Expanded(
                        child: Divider(
                            color: letterColor.withValues(alpha: 0.3),
                            thickness: 2)),
                  ],
                ),

                const SizedBox(height: 20),

                // Next letter preview or completion message
                if (hasNext)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          letterColor.withValues(alpha: 0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: letterColor.withValues(alpha: 0.2),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_forward_rounded,
                            color: letterColor, size: 24),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Next Adventure:',
                              style: TextStyle(
                                fontSize: 12,
                                color: letterColor.withValues(alpha: 0.7),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Letter $nextLetter',
                              style: TextStyle(
                                fontSize: 18,
                                color: letterColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: letterColor.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            nextLetter,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: letterColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple.withValues(alpha: 0.2),
                          Colors.pink.withValues(alpha: 0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.purple.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          '🏆 CONGRATULATIONS! 🏆',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'You completed the entire alphabet!',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.purple.withValues(alpha: 0.8),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build achievement chip
  Widget _buildAchievementChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color,
            color.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Build large letter display
  Widget _buildLetterDisplay(AlphabetItem item) {
    return Hero(
      tag: 'letter_${item.letter}',
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.getLetterColor(_currentIndex),
              AppColors.getLetterColor(_currentIndex).withValues(alpha: 0.7),
            ],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.getLetterColor(_currentIndex)
                  .withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: Text(
            item.letter,
            style: AppTextStyles.detailLetter.copyWith(
              fontSize: 76,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  offset: const Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build letter image - blends with yellow background + corner badge
  Widget _buildImage(AlphabetItem item) {
    return Container(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFFBEE),
            const Color(0xFFFFF5D6),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.15),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            // Main Image
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFF9E6), // Matches image background
                borderRadius: BorderRadius.circular(18),
              ),
              child: Image.asset(
                item.image,
                height: 260,
                width: double.infinity,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 260,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFFFF9E6),
                          const Color(0xFFFFF3D0),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_not_supported_rounded,
                            size: 64,
                            color: Colors.orange.withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Image coming soon!',
                            style: TextStyle(
                              color: Colors.orange.withValues(alpha: 0.7),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom-right decorative badge (covers Gemini logo)
            Positioned(
              bottom: 8,
              right: 8,
              child: _buildCornerBadge(item),
            ),
          ],
        ),
      ),
    );
  }

  /// Build corner badge to cover Gemini logo with something educational
  Widget _buildCornerBadge(AlphabetItem item) {
    final letterNumber = _currentIndex + 1;
    final isVowel = 'AEIOU'.contains(item.letter.toUpperCase());
    final badgeColor = AppColors.getLetterColor(_currentIndex);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            badgeColor,
            badgeColor.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isVowel ? Icons.favorite : Icons.star,
              size: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 6),
          // Letter position
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _getOrdinal(letterNumber),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              Text(
                isVowel ? 'Vowel' : 'Letter',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build word text
  Widget _buildWord(AlphabetItem item) {
    return Text(
      item.word,
      style: AppTextStyles.word.copyWith(
        color: AppColors.getLetterColor(_currentIndex),
        fontSize: 34,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  /// Build description text - warm theme
  Widget _buildDescription(AlphabetItem item) {
    return Container(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            const Color(0xFFFFFBF0),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.1),
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu_book_rounded,
                color: AppColors.getLetterColor(_currentIndex),
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                'About',
                style: AppTextStyles.bodyBold.copyWith(
                  fontSize: 18,
                  color: AppColors.getLetterColor(_currentIndex),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            item.description,
            style: AppTextStyles.body.copyWith(
              fontSize: 16,
              height: 1.6,
              color: const Color(0xFF424242),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Build fun fact section - warm yellow theme
  Widget _buildFunFact(AlphabetItem item) {
    return Container(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFF9E6),
            const Color(0xFFFFF3D0),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.25),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.1),
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.emoji_objects_rounded,
                color: AppColors.getLetterColor(_currentIndex),
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                'Fun Fact',
                style: AppTextStyles.bodyBold.copyWith(
                  fontSize: 18,
                  color: AppColors.getLetterColor(_currentIndex),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            item.funFact,
            style: AppTextStyles.body.copyWith(
              fontSize: 16,
              height: 1.6,
              color: const Color(0xFF424242),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Build letter information with more examples - warm theme
  Widget _buildLetterInfo(AlphabetItem item) {
    // Get more example words for the letter
    final moreWords = _getMoreWords(item.letter);
    final letterNumber = _currentIndex + 1;
    final isVowel = 'AEIOU'.contains(item.letter.toUpperCase());

    return Container(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            const Color(0xFFFFFBF0),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.1),
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                color: AppColors.getLetterColor(_currentIndex),
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                'More About ${item.letter}',
                style: AppTextStyles.bodyBold.copyWith(
                  fontSize: 18,
                  color: AppColors.getLetterColor(_currentIndex),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Letter position and type
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInfoChip(
                '${_getOrdinal(letterNumber)} Letter',
                Icons.format_list_numbered_rounded,
              ),
              const SizedBox(width: 12),
              _buildInfoChip(
                isVowel ? 'Vowel' : 'Consonant',
                isVowel ? Icons.album_rounded : Icons.abc_rounded,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // More words section
          Column(
            children: [
              Text(
                'More words with ${item.letter}:',
                style: AppTextStyles.body.copyWith(
                  fontSize: 15,
                  color: const Color(0xFF616161),
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children:
                    moreWords.map((word) => _buildWordChip(word)).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build info chip
  Widget _buildInfoChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.getLetterColor(_currentIndex).withValues(alpha: 0.2),
            AppColors.getLetterColor(_currentIndex).withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.getLetterColor(_currentIndex),
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.getLetterColor(_currentIndex),
            ),
          ),
        ],
      ),
    );
  }

  /// Build word chip
  Widget _buildWordChip(String word) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.getLetterColor(_currentIndex).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.getLetterColor(_currentIndex).withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Text(
        word,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.getLetterColor(_currentIndex),
        ),
      ),
    );
  }

  /// Get ordinal number (1st, 2nd, 3rd, etc.)
  String _getOrdinal(int number) {
    if (number >= 11 && number <= 13) return '${number}th';
    switch (number % 10) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }

  /// Get more example words for the letter
  List<String> _getMoreWords(String letter) {
    final words = {
      'A': ['Ant', 'Airplane', 'Alligator'],
      'B': ['Bear', 'Banana', 'Butterfly'],
      'C': ['Cake', 'Carrot', 'Castle'],
      'D': ['Dog', 'Duck', 'Dragon'],
      'E': ['Egg', 'Eagle', 'Envelope'],
      'F': ['Frog', 'Flower', 'Fire'],
      'G': ['Grapes', 'Guitar', 'Ghost'],
      'H': ['Hat', 'Horse', 'Helicopter'],
      'I': ['Igloo', 'Insect', 'Island'],
      'J': ['Juice', 'Jellyfish', 'Jacket'],
      'K': ['King', 'Kangaroo', 'Key'],
      'L': ['Lemon', 'Ladybug', 'Lamp'],
      'M': ['Mouse', 'Moon', 'Mountain'],
      'N': ['Nose', 'Noodles', 'Notebook'],
      'O': ['Octopus', 'Owl', 'Ocean'],
      'P': ['Penguin', 'Pizza', 'Pencil'],
      'Q': ['Quilt', 'Question', 'Quail'],
      'R': ['Rainbow', 'Robot', 'River'],
      'S': ['Star', 'Snake', 'Sandwich'],
      'T': ['Tiger', 'Turtle', 'Telephone'],
      'U': ['Unicorn', 'Union', 'Universe'],
      'V': ['Vase', 'Vegetable', 'Volcano'],
      'W': ['Wolf', 'Watermelon', 'Window'],
      'X': ['X-ray', 'Xbox', 'Xerox'],
      'Y': ['Yellow', 'Yogurt', 'Yawn'],
      'Z': ['Zoo', 'Zipper', 'Zombie'],
    };
    return words[letter.toUpperCase()] ?? ['Word1', 'Word2', 'Word3'];
  }

  /// Build navigation buttons
  Widget _buildNavigationButtons(Responsive responsive) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.horizontalPadding,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFFFBF0),
            const Color(0xFFFFF9E6),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildNavButton(
              label: 'Previous',
              icon: Icons.arrow_back_ios_new_rounded,
              onPressed: _currentIndex > 0
                  ? () => _changeLetter(_currentIndex - 1)
                  : null,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildNavButton(
              label: 'Next',
              icon: Icons.arrow_forward_ios_rounded,
              onPressed: _currentIndex < AlphabetData.count - 1
                  ? () => _changeLetter(_currentIndex + 1)
                  : null,
              isNext: true,
            ),
          ),
        ],
      ),
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

    void _handleTap() {
      if (onPressed != null) {
        AppHapticFeedback.medium(); // Medium feedback for navigation
        onPressed();
      }
    }

    return GestureDetector(
      onTapDown: isEnabled ? (_) => _scaleController.forward() : null,
      onTapUp: isEnabled ? (_) => _scaleController.reverse() : null,
      onTapCancel: isEnabled ? () => _scaleController.reverse() : null,
      onTap: _handleTap,
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
                    colors: [
                      AppColors.getLetterColor(_currentIndex),
                      AppColors.getLetterColor(_currentIndex)
                          .withValues(alpha: 0.8),
                    ],
                  )
                : null,
            color: isEnabled ? null : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isEnabled
                ? [
                    BoxShadow(
                      color: AppColors.getLetterColor(_currentIndex)
                          .withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isNext) Icon(icon, color: Colors.white, size: 20),
              if (!isNext) const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.button.copyWith(
                  color: isEnabled ? Colors.white : Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (isNext) const SizedBox(width: 8),
              if (isNext) Icon(icon, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
