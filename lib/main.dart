import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/app_colors.dart';
import 'ui/screens/splash_screen.dart';
import 'utils/asset_preloader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Preload assets for offline use
  await AssetPreloader.preloadAssets();

  // Initialize easy_localization
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('mr'),
        Locale('pa'),
        Locale('ta'),
        Locale('gu'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const AlphaZooApp(),
    ),
  );
}

class AlphaZooApp extends StatelessWidget {
  const AlphaZooApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids Learning World',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.fredokaTextTheme(),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
