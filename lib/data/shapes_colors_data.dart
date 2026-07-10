import 'package:flutter/material.dart';

class ShapeItem {
  final String emoji;
  final String nameKey;

  const ShapeItem({
    required this.emoji,
    required this.nameKey,
  });
}

class SimpleColorItem {
  final String nameKey;
  final Color color;

  const SimpleColorItem({
    required this.nameKey,
    required this.color,
  });
}

class ShapesColorsData {
  ShapesColorsData._();

  static const List<ShapeItem> shapes = [
    ShapeItem(emoji: '⚫', nameKey: 'shapes.names.circle'),
    ShapeItem(emoji: '⬛', nameKey: 'shapes.names.square'),
    ShapeItem(emoji: '🟦', nameKey: 'shapes.names.rectangle'),
    ShapeItem(emoji: '🔺', nameKey: 'shapes.names.triangle'),
    ShapeItem(emoji: '💎', nameKey: 'shapes.names.diamond'),
    ShapeItem(emoji: '🧊', nameKey: 'shapes.names.cube'),
    ShapeItem(emoji: '⭐', nameKey: 'shapes.names.star'),
    ShapeItem(emoji: '🏉', nameKey: 'shapes.names.oval'),
    ShapeItem(emoji: '❤️', nameKey: 'shapes.names.heart'),
    ShapeItem(emoji: '➖', nameKey: 'shapes.names.line'),
    ShapeItem(emoji: '📦', nameKey: 'shapes.names.box'),
    ShapeItem(emoji: '⬟', nameKey: 'shapes.names.pentagon'),
    ShapeItem(emoji: '⬢', nameKey: 'shapes.names.hexagon'),
    ShapeItem(emoji: '🛑', nameKey: 'shapes.names.octagon'),
  ];

  static const List<SimpleColorItem> colors = [
    SimpleColorItem(
        nameKey: 'shapes.colorNames.black', color: Color(0xFF212121)),
    SimpleColorItem(
        nameKey: 'shapes.colorNames.white', color: Color(0xFFFFFFFF)),
    SimpleColorItem(
        nameKey: 'shapes.colorNames.grey', color: Color(0xFF9E9E9E)),
    SimpleColorItem(nameKey: 'shapes.colorNames.red', color: Color(0xFFE53935)),
    SimpleColorItem(
        nameKey: 'shapes.colorNames.orange', color: Color(0xFFFB8C00)),
    SimpleColorItem(
        nameKey: 'shapes.colorNames.yellow', color: Color(0xFFFFEB3B)),
    SimpleColorItem(
        nameKey: 'shapes.colorNames.blue', color: Color(0xFF1E88E5)),
    SimpleColorItem(
        nameKey: 'shapes.colorNames.green', color: Color(0xFF43A047)),
    SimpleColorItem(
        nameKey: 'shapes.colorNames.skyBlue', color: Color(0xFF87CEEB)),
    SimpleColorItem(
        nameKey: 'shapes.colorNames.lightGreen', color: Color(0xFFA5D6A7)),
    SimpleColorItem(
        nameKey: 'shapes.colorNames.darkOrange', color: Color(0xFFE65100)),
    SimpleColorItem(
        nameKey: 'shapes.colorNames.darkBlue', color: Color(0xFF0D47A1)),
    SimpleColorItem(
        nameKey: 'shapes.colorNames.darkGreen', color: Color(0xFF1B5E20)),
    SimpleColorItem(
        nameKey: 'shapes.colorNames.purple', color: Color(0xFF9C27B0)),
    SimpleColorItem(
        nameKey: 'shapes.colorNames.pink', color: Color(0xFFD81B60)),
    SimpleColorItem(
        nameKey: 'shapes.colorNames.brown', color: Color(0xFF6D4C41)),
    SimpleColorItem(
        nameKey: 'shapes.colorNames.gold', color: Color(0xFFFFD740)),
    SimpleColorItem(
        nameKey: 'shapes.colorNames.silver', color: Color(0xFFC0C0C0)),
  ];
}
