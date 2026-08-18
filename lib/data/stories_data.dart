import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Metadata for one story (text lives in assets/translations under stories.items).
class StoryItem {
  final String id;
  final String emoji;
  final String imageAsset;
  final Color accentColor;
  final int readMinutes;

  const StoryItem({
    required this.id,
    required this.emoji,
    required this.imageAsset,
    required this.accentColor,
    this.readMinutes = 3,
  });
}

/// Loaded story body from JSON.
class StoryContent {
  final String title;
  final String subtitle;
  final List<String> paragraphs;
  final String moral;

  const StoryContent({
    required this.title,
    required this.subtitle,
    required this.paragraphs,
    required this.moral,
  });

  String get fullSpeakText {
    final body = paragraphs.join(' ');
    final moralLabel = 'stories.moralTitle'.tr();
    return '$title. $body $moralLabel: $moral';
  }
}

class StoriesData {
  StoriesData._();

  static const List<StoryItem> items = [
    StoryItem(
      id: 'diwali',
      emoji: '🪔',
      imageAsset: 'assets/stories/diwali.png',
      accentColor: Color(0xFFE65100),
      readMinutes: 4,
    ),
    StoryItem(
      id: 'holi',
      emoji: '🌈',
      imageAsset: 'assets/stories/holi.png',
      accentColor: Color(0xFF8E24AA),
      readMinutes: 4,
    ),
    StoryItem(
      id: 'ganesh_chaturthi',
      emoji: '🐘',
      imageAsset: 'assets/stories/ganesh_chaturthi.png',
      accentColor: Color(0xFFF4511E),
      readMinutes: 4,
    ),
    StoryItem(
      id: 'christmas',
      emoji: '🎄',
      imageAsset: 'assets/stories/christmas.png',
      accentColor: Color(0xFF2E7D32),
      readMinutes: 4,
    ),
    StoryItem(
      id: 'eid_ul_fitr',
      emoji: '🌙',
      imageAsset: 'assets/stories/eid_ul_fitr.png',
      accentColor: Color(0xFF00695C),
      readMinutes: 3,
    ),
    StoryItem(
      id: 'raksha_bandhan',
      emoji: '🎀',
      imageAsset: 'assets/stories/raksha_bandhan.png',
      accentColor: Color(0xFFD81B60),
      readMinutes: 3,
    ),
    StoryItem(
      id: 'lion_and_mouse',
      emoji: '🦁',
      imageAsset: 'assets/stories/lion_and_mouse.png',
      accentColor: Color(0xFFF9A825),
      readMinutes: 3,
    ),
    StoryItem(
      id: 'hare_and_tortoise',
      emoji: '🐢',
      imageAsset: 'assets/stories/hare_and_tortoise.png',
      accentColor: Color(0xFF43A047),
      readMinutes: 3,
    ),
    StoryItem(
      id: 'ant_and_grasshopper',
      emoji: '🐜',
      imageAsset: 'assets/stories/ant_and_grasshopper.png',
      accentColor: Color(0xFF6D4C41),
      readMinutes: 3,
    ),
    StoryItem(
      id: 'please_and_thank_you',
      emoji: '🌸',
      imageAsset: 'assets/stories/please_and_thank_you.png',
      accentColor: Color(0xFFEC407A),
      readMinutes: 3,
    ),
    StoryItem(
      id: 'clever_merchants',
      emoji: '🎭',
      imageAsset: 'assets/stories/clever_merchants.png',
      accentColor: Color(0xFF5C6BC0),
      readMinutes: 4,
    ),
    StoryItem(
      id: 'magical_balloon',
      emoji: '🎈',
      imageAsset: 'assets/stories/magical_balloon.png',
      accentColor: Color(0xFF26C6DA),
      readMinutes: 4,
    ),
    StoryItem(
      id: 'lost_baby_dinosaur',
      emoji: '🦖',
      imageAsset: 'assets/stories/lost_baby_dinosaur.png',
      accentColor: Color(0xFF66BB6A),
      readMinutes: 4,
    ),
  ];

  static StoryItem itemAt(int index) => items[index];
}
