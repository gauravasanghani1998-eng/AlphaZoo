import 'package:flutter/material.dart';

class LearningDetailPage {
  final String title;
  final String speakText;
  final String? speakLanguageCode;
  final String about;
  final String funFact;
  final String tryThis;
  final String? emoji;
  final String? subtitle;
  final Widget? hero;
  final List<Widget>? extraSections;
  final List<String>? exampleWords;
  final String? exampleWordsTitle;
  final String? aboutTitle;
  final String? funFactTitle;
  final String? tryTitle;
  final bool heroInCircle;
  final bool oppositePairLayout;

  const LearningDetailPage({
    required this.title,
    required this.speakText,
    this.speakLanguageCode,
    required this.about,
    required this.funFact,
    required this.tryThis,
    this.emoji,
    this.subtitle,
    this.hero,
    this.extraSections,
    this.exampleWords,
    this.exampleWordsTitle,
    this.aboutTitle,
    this.funFactTitle,
    this.tryTitle,
    this.heroInCircle = true,
    this.oppositePairLayout = false,
  });
}
