import 'package:flutter/material.dart';

/// Simple shape item using emoji-style icons and a name.
class ShapeItem {
  final String emoji;
  final String name;

  const ShapeItem({
    required this.emoji,
    required this.name,
  });
}

/// Color item with a Flutter [Color] and display name.
class SimpleColorItem {
  final String name;
  final Color color;

  const SimpleColorItem({
    required this.name,
    required this.color,
  });
}

class ShapesColorsData {
  ShapesColorsData._();

  // Around 50 shapes
  static const List<ShapeItem> shapes = [
    ShapeItem(emoji: '⚫', name: 'Circle'),
    ShapeItem(emoji: '⬛', name: 'Square'),
    ShapeItem(emoji: '🔺', name: 'Triangle'),
    ShapeItem(emoji: '🟦', name: 'Rectangle'),
    ShapeItem(emoji: '🔷', name: 'Diamond'),
    ShapeItem(emoji: '🧊', name: 'Cube'),
    ShapeItem(emoji: '⭕', name: 'Ring'),
    ShapeItem(emoji: '🟥', name: 'Block'),
    ShapeItem(emoji: '⬜', name: 'Box'),
    ShapeItem(emoji: '🔻', name: 'Down Triangle'),
    ShapeItem(emoji: '🔸', name: 'Rhombus'),
    ShapeItem(emoji: '🔹', name: 'Small Diamond'),
    ShapeItem(emoji: '🔺', name: 'Pyramid'),
    ShapeItem(emoji: '🟪', name: 'Square Tile'),
    ShapeItem(emoji: '🟫', name: 'Brick'),
    ShapeItem(emoji: '🥚', name: 'Oval'),
    ShapeItem(emoji: '💠', name: 'Star Diamond'),
    ShapeItem(emoji: '⭐', name: 'Star'),
    ShapeItem(emoji: '🌟', name: 'Sparkle Star'),
    ShapeItem(emoji: '✴️', name: 'Burst'),
    ShapeItem(emoji: '❇️', name: 'Sparkle'),
    ShapeItem(emoji: '✳️', name: 'Eight Star'),
    ShapeItem(emoji: '✡️', name: 'Hexagram'),
    ShapeItem(emoji: '🛑', name: 'Octagon'),
    ShapeItem(emoji: '📐', name: 'Right Angle'),
    ShapeItem(emoji: '📏', name: 'Line'),
    ShapeItem(emoji: '➖', name: 'Bar'),
    ShapeItem(emoji: '➕', name: 'Cross'),
    ShapeItem(emoji: '➗', name: 'Split'),
    ShapeItem(emoji: '➰', name: 'Loop'),
    ShapeItem(emoji: '➿', name: 'Double Loop'),
    ShapeItem(emoji: '〰️', name: 'Wave'),
    ShapeItem(emoji: '➖', name: 'Dash'),
    ShapeItem(emoji: '➕', name: 'Plus Shape'),
    ShapeItem(emoji: '✂️', name: 'Cut Shape'),
    ShapeItem(emoji: '🔲', name: 'Frame Square'),
    ShapeItem(emoji: '🔳', name: 'Frame Box'),
    ShapeItem(emoji: '◻️', name: 'Thin Square'),
    ShapeItem(emoji: '◼️', name: 'Solid Square'),
    ShapeItem(emoji: '◯', name: 'Thin Circle'),
    ShapeItem(emoji: '⬤', name: 'Solid Dot'),
    ShapeItem(emoji: '▱', name: 'Thin Diamond'),
    ShapeItem(emoji: '▰', name: 'Solid Diamond'),
    ShapeItem(emoji: '▭', name: 'Thin Rectangle'),
    ShapeItem(emoji: '▪️', name: 'Small Square'),
    ShapeItem(emoji: '▫️', name: 'Small Box'),
    ShapeItem(emoji: '◽', name: 'Soft Square'),
    ShapeItem(emoji: '◾', name: 'Soft Block'),
    ShapeItem(emoji: '🔘', name: 'Button'),
  ];

  // Around 50 colors
  static const List<SimpleColorItem> colors = [
    SimpleColorItem(name: 'Red', color: Color(0xFFE53935)),
    SimpleColorItem(name: 'Orange', color: Color(0xFFFB8C00)),
    SimpleColorItem(name: 'Yellow', color: Color(0xFFFDD835)),
    SimpleColorItem(name: 'Green', color: Color(0xFF43A047)),
    SimpleColorItem(name: 'Blue', color: Color(0xFF1E88E5)),
    SimpleColorItem(name: 'Purple', color: Color(0xFF8E24AA)),
    SimpleColorItem(name: 'Pink', color: Color(0xFFD81B60)),
    SimpleColorItem(name: 'Brown', color: Color(0xFF6D4C41)),
    SimpleColorItem(name: 'Light Blue', color: Color(0xFF81D4FA)),
    SimpleColorItem(name: 'Dark Blue', color: Color(0xFF0D47A1)),
    SimpleColorItem(name: 'Light Green', color: Color(0xFFA5D6A7)),
    SimpleColorItem(name: 'Dark Green', color: Color(0xFF1B5E20)),
    SimpleColorItem(name: 'Gold', color: Color(0xFFFFD700)),
    SimpleColorItem(name: 'Silver', color: Color(0xFFB0BEC5)),
    SimpleColorItem(name: 'Grey', color: Color(0xFF9E9E9E)),
    SimpleColorItem(name: 'Black', color: Color(0xFF000000)),
    SimpleColorItem(name: 'White', color: Color(0xFFFFFFFF)),
    SimpleColorItem(name: 'Cyan', color: Color(0xFF00BCD4)),
    SimpleColorItem(name: 'Teal', color: Color(0xFF00897B)),
    SimpleColorItem(name: 'Lime', color: Color(0xFFCDDC39)),
    SimpleColorItem(name: 'Amber', color: Color(0xFFFFC107)),
    SimpleColorItem(name: 'Indigo', color: Color(0xFF3F51B5)),
    SimpleColorItem(name: 'Deep Purple', color: Color(0xFF5E35B1)),
    SimpleColorItem(name: 'Deep Orange', color: Color(0xFFF4511E)),
    SimpleColorItem(name: 'Light Pink', color: Color(0xFFF8BBD0)),
    SimpleColorItem(name: 'Magenta', color: Color(0xFFE91E63)),
    SimpleColorItem(name: 'Maroon', color: Color(0xFF880E4F)),
    SimpleColorItem(name: 'Olive', color: Color(0xFF827717)),
    SimpleColorItem(name: 'Navy', color: Color(0xFF001F54)),
    SimpleColorItem(name: 'Turquoise', color: Color(0xFF40E0D0)),
    SimpleColorItem(name: 'Sky Blue', color: Color(0xFF87CEEB)),
    SimpleColorItem(name: 'Sea Green', color: Color(0xFF2E8B57)),
    SimpleColorItem(name: 'Chocolate', color: Color(0xFFD2691E)),
    SimpleColorItem(name: 'Coral', color: Color(0xFFFF7F50)),
    SimpleColorItem(name: 'Beige', color: Color(0xFFF5F5DC)),
    SimpleColorItem(name: 'Ivory', color: Color(0xFFFFFFF0)),
    SimpleColorItem(name: 'Mint', color: Color(0xFF98FF98)),
    SimpleColorItem(name: 'Lavender', color: Color(0xFFE6E6FA)),
    SimpleColorItem(name: 'Plum', color: Color(0xFFDDA0DD)),
    SimpleColorItem(name: 'Crimson', color: Color(0xFFDC143C)),
    SimpleColorItem(name: 'Rose', color: Color(0xFFFF007F)),
    SimpleColorItem(name: 'Mustard', color: Color(0xFFFFDB58)),
    SimpleColorItem(name: 'Khaki', color: Color(0xFFF0E68C)),
    SimpleColorItem(name: 'Slate', color: Color(0xFF708090)),
    SimpleColorItem(name: 'Pearl', color: Color(0xFFF0E5CF)),
    SimpleColorItem(name: 'Ruby', color: Color(0xFFE0115F)),
    SimpleColorItem(name: 'Sapphire', color: Color(0xFF0F52BA)),
    SimpleColorItem(name: 'Emerald', color: Color(0xFF50C878)),
    SimpleColorItem(name: 'Bronze', color: Color(0xFFCD7F32)),
  ];
}

