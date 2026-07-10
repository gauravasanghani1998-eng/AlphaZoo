import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/numbers_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import '../widgets/home_play_background.dart';
import '../widgets/kid_language_sheet.dart';
import '../widgets/kid_play_card.dart';
import '../widgets/kid_promo_header.dart';
import 'about_screen.dart';
import 'alphabet_screen.dart';
import 'body_parts_screen.dart';
import 'emotions_screen.dart';
import 'everyday_words_screen.dart';
import 'family_screen.dart';
import 'greetings_screen.dart';
import 'numbers_screen.dart';
import 'opposites_screen.dart';
import 'rhymes_screen.dart';
import 'shapes_colors_screen.dart';
import 'spelling_screen.dart';
import 'vehicles_screen.dart';
import 'weather_seasons_screen.dart';
import 'native_script_screen.dart';
import 'math_logic_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeModule {
  final String emoji;
  final String imageAsset;
  final Color color;
  final String title;
  final VoidCallback onTap;

  const _HomeModule({
    required this.emoji,
    required this.imageAsset,
    required this.color,
    required this.title,
    required this.onTap,
  });
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin, RouteAware {
  late AnimationController _fadeController;
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  bool _ttsWarmed = false;
  PageRoute<dynamic>? _route;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    )..forward();

    _scrollController.addListener(() {
      final scrolled = _scrollController.offset > 16;
      if (scrolled != _isScrolled) setState(() => _isScrolled = scrolled);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_ttsWarmed) {
      _ttsWarmed = true;
      AppSpeech.warmUp(context.locale);
    }
    final route = ModalRoute.of(context);
    if (route is PageRoute<dynamic> && route != _route) {
      if (_route != null) {
        AppSpeech.routeObserver.unsubscribe(this);
      }
      _route = route;
      AppSpeech.routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    if (_route != null) {
      AppSpeech.routeObserver.unsubscribe(this);
    }
    AppSpeech.stop();
    _fadeController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    AppSpeech.interruptPlayback();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: HomePlayBackground(
        child: SafeArea(
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: _fadeController,
              curve: Curves.easeOut,
            ),
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.fromLTRB(
                responsive.horizontalPadding,
                10,
                responsive.horizontalPadding,
                responsive.verticalPadding + 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPromoMarquee(context),
                  const SizedBox(height: 16),
                  _buildPlayGrid(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    const barHeight = 56.0;

    return PreferredSize(
      preferredSize: Size.fromHeight(topInset + barHeight),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: AppColors.primary.withValues(alpha: 0.18),
                width: 1.5,
              ),
            ),
            boxShadow: _isScrolled
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Padding(
            padding: EdgeInsets.only(top: topInset),
            child: SizedBox(
              height: barHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    const _HomeLogoBadge(),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            Color(0xFF2BAFA6),
                            Color(0xFF5C6BC0),
                            AppColors.secondary,
                          ],
                        ).createShader(bounds),
                        child: Text(
                          'Kids Learning World',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.heading2.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    _HomeHeaderAction(
                      tooltip: 'Language',
                      icon: Icons.language_rounded,
                      color: AppColors.primary,
                      onPressed: () => showKidLanguageSheet(context),
                    ),
                    const SizedBox(width: 6),
                    _HomeHeaderAction(
                      tooltip: 'About',
                      icon: Icons.info_outline_rounded,
                      color: AppColors.secondary,
                      onPressed: () {
                        AppHapticFeedback.light();
                        AppSpeech.stop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const AboutScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPromoMarquee(BuildContext context) {
    return KidPromoHeader(
      marqueeText: 'explore.marquee'.tr(),
      onSpeak: () => _speakPromo(context),
    );
  }

  void _speakPromo(BuildContext context) {
    AppHapticFeedback.light();
    final text = 'explore.marqueeSpeak'.tr();
    AppSpeech.speak(context, text);
  }

  Widget _buildPlayGrid(BuildContext context) {
    final responsive = context.responsive;
    final modules = _modules(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: responsive.homePlayCrossAxisCount,
        crossAxisSpacing: responsive.gridSpacing + 6,
        mainAxisSpacing: responsive.gridSpacing + 6,
        childAspectRatio: responsive.homePlayAspectRatio,
      ),
      itemCount: modules.length,
      itemBuilder: (context, index) {
        final m = modules[index];
        return KidPlayCard(
          emoji: m.emoji,
          imageAsset: m.imageAsset,
          title: m.title,
          color: m.color,
          onTap: m.onTap,
        );
      },
    );
  }

  List<_HomeModule> _modules(BuildContext context) {
    final glyphs = NumbersData.glyphsKey.tr();
    return [
      _HomeModule(
        emoji: '🔤',
        imageAsset: _moduleImage('alphabet'),
        color: AppColors.primary,
        title: 'home.title'.tr(),
        onTap: () => _open(context, const AlphabetScreen()),
      ),
      _HomeModule(
        emoji: 'ક',
        imageAsset: _moduleImage('native_script'),
        color: AppColors.getLetterColor(1),
        title: 'shortcuts.nativeScript.title'.tr(),
        onTap: () => _open(context, const NativeScriptScreen()),
      ),
      _HomeModule(
        emoji: '🔢',
        imageAsset: _moduleImage('numbers'),
        color: Colors.orange,
        title: 'shortcuts.numbers.title'.tr(
          namedArgs: {
            'range': NumbersData.formatDigitRange(1, 100, glyphs),
          },
        ),
        onTap: () => _open(context, const NumbersScreen()),
      ),
      _HomeModule(
        emoji: '🧮',
        imageAsset: _moduleImage('math_logic'),
        color: AppColors.getLetterColor(12),
        title: 'shortcuts.mathLogic.title'.tr(),
        onTap: () => _open(context, const MathLogicScreen()),
      ),
      _HomeModule(
        emoji: '📅',
        imageAsset: _moduleImage('days'),
        color: AppColors.getLetterColor(5),
        title: 'shortcuts.days.title'.tr(),
        onTap: () => _open(
          context,
          const EverydayWordsScreen(initialTab: 'days', showTabs: false),
        ),
      ),
      _HomeModule(
        emoji: '🗓️',
        imageAsset: _moduleImage('months'),
        color: AppColors.getLetterColor(7),
        title: 'shortcuts.months.title'.tr(),
        onTap: () => _open(
          context,
          const EverydayWordsScreen(initialTab: 'months', showTabs: false),
        ),
      ),
      _HomeModule(
        emoji: '🎨',
        imageAsset: _moduleImage('shapes_colors'),
        color: AppColors.getLetterColor(2),
        title: 'shortcuts.shapesColors.title'.tr(),
        onTap: () => _open(context, const ShapesColorsScreen()),
      ),
      _HomeModule(
        emoji: '🧒',
        imageAsset: _moduleImage('body_parts'),
        color: AppColors.getLetterColor(3),
        title: 'shortcuts.bodyParts.title'.tr(),
        onTap: () => _open(context, const BodyPartsScreen()),
      ),
      _HomeModule(
        emoji: '🎵',
        imageAsset: _moduleImage('rhymes'),
        color: AppColors.accent,
        title: 'shortcuts.rhymes.title'.tr(),
        onTap: () => _open(context, const RhymesScreen()),
      ),
      _HomeModule(
        emoji: '✏️',
        imageAsset: _moduleImage('spelling'),
        color: AppColors.secondary,
        title: 'shortcuts.spelling.title'.tr(),
        onTap: () => _open(context, const SpellingScreen()),
      ),
      _HomeModule(
        emoji: '☀️',
        imageAsset: _moduleImage('weather'),
        color: AppColors.getLetterColor(8),
        title: 'shortcuts.weather.title'.tr(),
        onTap: () => _open(context, const WeatherSeasonsScreen()),
      ),
      _HomeModule(
        emoji: '👋',
        imageAsset: _moduleImage('greetings'),
        color: AppColors.getLetterColor(11),
        title: 'shortcuts.greetings.title'.tr(),
        onTap: () => _open(context, const GreetingsScreen()),
      ),
      _HomeModule(
        emoji: '👨‍👩‍👧',
        imageAsset: _moduleImage('family'),
        color: AppColors.getLetterColor(9),
        title: 'shortcuts.family.title'.tr(),
        onTap: () => _open(context, const FamilyScreen()),
      ),
      _HomeModule(
        emoji: '😊',
        imageAsset: _moduleImage('emotions'),
        color: AppColors.getLetterColor(4),
        title: 'shortcuts.emotions.title'.tr(),
        onTap: () => _open(context, const EmotionsScreen()),
      ),
      _HomeModule(
        emoji: '↔️',
        imageAsset: _moduleImage('opposites'),
        color: AppColors.getLetterColor(6),
        title: 'shortcuts.opposites.title'.tr(),
        onTap: () => _open(context, const OppositesScreen()),
      ),
      _HomeModule(
        emoji: '🚗',
        imageAsset: _moduleImage('vehicles'),
        color: AppColors.getLetterColor(10),
        title: 'shortcuts.vehicles.title'.tr(),
        onTap: () => _open(context, const VehiclesScreen()),
      ),
    ];
  }

  String _moduleImage(String key) {
    switch (key) {
      case 'alphabet':
        return 'assets/images/modules/alphabet.png';
      case 'numbers':
        return 'assets/images/modules/number.png';
      case 'math_logic':
        return 'assets/images/modules/math_logic.png';
      case 'native_script':
        return 'assets/images/modules/gujrati_alphabet.png';
      case 'days':
        return 'assets/images/modules/week.png';
      case 'months':
        return 'assets/images/modules/month.png';
      case 'shapes_colors':
        return 'assets/images/modules/shape.png';
      case 'body_parts':
        return 'assets/images/modules/body.png';
      case 'rhymes':
        return 'assets/images/modules/rhymes.png';
      case 'spelling':
        return 'assets/images/modules/spelling.png';
      case 'weather':
        return 'assets/images/modules/weather.png';
      case 'greetings':
        return 'assets/images/modules/greeting.png';
      case 'family':
        return 'assets/images/modules/family.png';
      case 'emotions':
        return 'assets/images/modules/feeling.png';
      case 'opposites':
        return 'assets/images/modules/opposites.png';
      case 'vehicles':
        return 'assets/images/modules/vehicle.png';
      default:
        return 'assets/images/modules/feeling.png';
    }
  }

  void _open(BuildContext context, Widget screen) {
    AppHapticFeedback.medium();
    AppSpeech.interruptPlayback();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => screen),
    );
  }
}

class _HomeLogoBadge extends StatelessWidget {
  const _HomeLogoBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.35),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Image.asset(
            'assets/images/app_logo.png',
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const Center(
              child: Text('📚', style: TextStyle(fontSize: 20)),
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeHeaderAction extends StatelessWidget {
  const _HomeHeaderAction({
    required this.tooltip,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: color.withValues(alpha: 0.12),
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: 38,
            height: 38,
            child: Icon(icon, color: color, size: 21),
          ),
        ),
      ),
    );
  }
}
