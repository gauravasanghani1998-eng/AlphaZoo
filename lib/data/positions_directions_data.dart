import 'package:flutter/material.dart';

/// How the stage animates a position/direction concept.
enum PositionStageKind {
  direction,
  scene,
  orbit,
}

class PositionDirectionCategory {
  final String id;
  final String emoji;
  final int colorIndex;
  final List<PositionDirectionItem> items;

  const PositionDirectionCategory({
    required this.id,
    required this.emoji,
    required this.colorIndex,
    required this.items,
  });

  String get titleKey => 'positionsDirections.categories.$id.title';

  String get subtitleKey => 'positionsDirections.categories.$id.subtitle';
}

class PositionDirectionItem {
  final String id;
  final String emoji;
  final PositionStageKind kind;

  final double dirDx;
  final double dirDy;

  final String actorEmoji;
  final double actorScale;
  final Alignment actorAlignment;
  final bool actorInFront;

  final String? refEmoji;
  final Alignment refAlignment;
  final double refScale;

  final String? refEmoji2;
  final Alignment ref2Alignment;

  const PositionDirectionItem({
    required this.id,
    required this.emoji,
    required this.kind,
    this.dirDx = 0,
    this.dirDy = 0,
    this.actorEmoji = '🐥',
    this.actorScale = 1,
    this.actorAlignment = Alignment.center,
    this.actorInFront = true,
    this.refEmoji,
    this.refAlignment = Alignment.center,
    this.refScale = 1,
    this.refEmoji2,
    this.ref2Alignment = Alignment.center,
  });

  String get nameKey => 'positionsDirections.items.$id.name';

  String get captionKey => 'positionsDirections.items.$id.caption';

  String get aboutKey => 'positionsDirections.items.$id.about';

  String get funFactKey => 'positionsDirections.items.$id.funFact';

  String get tryKey => 'positionsDirections.items.$id.try';
}

class PositionsDirectionsData {
  PositionsDirectionsData._();

  static const List<PositionDirectionCategory> categories = [
    PositionDirectionCategory(
      id: 'basicPositions',
      emoji: '📍',
      colorIndex: 0,
      items: [
        PositionDirectionItem(
            id: 'up',
            emoji: '⬆️',
            kind: PositionStageKind.direction,
            dirDy: -1),
        PositionDirectionItem(
            id: 'down',
            emoji: '⬇️',
            kind: PositionStageKind.direction,
            dirDy: 1),
        PositionDirectionItem(
            id: 'left',
            emoji: '⬅️',
            kind: PositionStageKind.direction,
            dirDx: -1),
        PositionDirectionItem(
            id: 'right',
            emoji: '➡️',
            kind: PositionStageKind.direction,
            dirDx: 1),
        PositionDirectionItem(
            id: 'top',
            emoji: '🔝',
            kind: PositionStageKind.scene,
            actorAlignment: Alignment(0, -0.55),
            refEmoji: '🏔️',
            refAlignment: Alignment(0, 0.35),
            refScale: 1.35),
        PositionDirectionItem(
            id: 'bottom',
            emoji: '⏬',
            kind: PositionStageKind.scene,
            actorAlignment: Alignment(0, 0.65),
            refEmoji: '🪜',
            refAlignment: Alignment(0, -0.15),
            refScale: 1.35),
        PositionDirectionItem(
            id: 'middle',
            emoji: '🎯',
            kind: PositionStageKind.scene,
            actorAlignment: Alignment.center,
            refEmoji: '🐰',
            refAlignment: Alignment(-0.65, 0.35),
            refEmoji2: '🐢',
            ref2Alignment: Alignment(0.65, 0.35)),
        PositionDirectionItem(
            id: 'center',
            emoji: '⭕',
            kind: PositionStageKind.scene,
            actorAlignment: Alignment.center,
            refEmoji: '⭕',
            refScale: 1.6,
            actorInFront: true),
        PositionDirectionItem(
            id: 'front',
            emoji: '🚂',
            kind: PositionStageKind.scene,
            actorEmoji: '🚂',
            actorAlignment: Alignment(-0.55, 0.25),
            refEmoji: '🚃',
            refAlignment: Alignment(0.4, 0.25),
            refScale: 1.2),
        PositionDirectionItem(
            id: 'back',
            emoji: '🎒',
            kind: PositionStageKind.scene,
            actorAlignment: Alignment(0, 0.35),
            refEmoji: '🎒',
            refAlignment: Alignment(0.35, 0.2),
            refScale: 1.2),
        PositionDirectionItem(
            id: 'inside',
            emoji: '🧺',
            kind: PositionStageKind.scene,
            actorAlignment: Alignment(0, 0.05),
            actorInFront: false,
            refEmoji: '🧺',
            refAlignment: Alignment(0, 0.42),
            refScale: 1.3),
        PositionDirectionItem(
            id: 'outside',
            emoji: '🌤️',
            kind: PositionStageKind.scene,
            actorAlignment: Alignment(0.58, 0.4),
            refEmoji: '🧺',
            refAlignment: Alignment(-0.5, 0.42),
            refScale: 1.3),
        PositionDirectionItem(
            id: 'near',
            emoji: '🤗',
            kind: PositionStageKind.scene,
            actorAlignment: Alignment(0.22, 0.4),
            refEmoji: '🏠',
            refAlignment: Alignment(-0.3, 0.25),
            refScale: 1.4),
        PositionDirectionItem(
            id: 'far',
            emoji: '🔭',
            kind: PositionStageKind.scene,
            actorAlignment: Alignment(0.85, -0.55),
            actorScale: 0.55,
            refEmoji: '🏠',
            refAlignment: Alignment(-0.75, 0.45),
            refScale: 1.35),
        PositionDirectionItem(
            id: 'above',
            emoji: '🦅',
            kind: PositionStageKind.scene,
            actorEmoji: '🦅',
            actorAlignment: Alignment(0, -0.55),
            refEmoji: '🌳',
            refAlignment: Alignment(0, 0.35),
            refScale: 1.5),
        PositionDirectionItem(
            id: 'below',
            emoji: '🐜',
            kind: PositionStageKind.scene,
            actorEmoji: '🐜',
            actorAlignment: Alignment(0, 0.62),
            refEmoji: '🌼',
            refAlignment: Alignment(0, -0.15),
            refScale: 1.25),
        PositionDirectionItem(
            id: 'over',
            emoji: '🌉',
            kind: PositionStageKind.scene,
            actorEmoji: '🦋',
            actorAlignment: Alignment(0, -0.42),
            refEmoji: '🏠',
            refAlignment: Alignment(0, 0.35),
            refScale: 1.45),
        PositionDirectionItem(
            id: 'under',
            emoji: '☂️',
            kind: PositionStageKind.scene,
            actorAlignment: Alignment(0, 0.52),
            refEmoji: '☂️',
            refAlignment: Alignment(0, -0.3),
            refScale: 1.45),
        PositionDirectionItem(
            id: 'in',
            emoji: '📥',
            kind: PositionStageKind.direction,
            dirDx: 1,
            actorEmoji: '⚽'),
        PositionDirectionItem(
            id: 'out',
            emoji: '📤',
            kind: PositionStageKind.direction,
            dirDx: -1,
            actorEmoji: '⚽'),
        PositionDirectionItem(
            id: 'on',
            emoji: '💡',
            kind: PositionStageKind.scene,
            actorEmoji: '💡',
            actorScale: 1.5,
            actorAlignment: Alignment(0, -0.05),
            refEmoji: '✨',
            refAlignment: Alignment(-0.5, -0.4),
            refEmoji2: '✨',
            ref2Alignment: Alignment(0.5, -0.4)),
        PositionDirectionItem(
            id: 'off',
            emoji: '🌙',
            kind: PositionStageKind.scene,
            actorEmoji: '💡',
            actorScale: 1.2,
            actorAlignment: Alignment(0, 0),
            refEmoji: '🌙',
            refAlignment: Alignment(0.55, -0.45),
            refEmoji2: '😴',
            ref2Alignment: Alignment(-0.55, -0.4)),
      ],
    ),
    PositionDirectionCategory(
      id: 'relativePositions',
      emoji: '🧩',
      colorIndex: 3,
      items: [
        PositionDirectionItem(
            id: 'beside',
            emoji: '👫',
            kind: PositionStageKind.scene,
            actorAlignment: Alignment(0.25, 0.4),
            refEmoji: '🐶',
            refAlignment: Alignment(-0.25, 0.4)),
        PositionDirectionItem(
            id: 'nextTo',
            emoji: '🪑',
            kind: PositionStageKind.scene,
            actorAlignment: Alignment(0.3, 0.4),
            refEmoji: '🪑',
            refAlignment: Alignment(-0.3, 0.4),
            refScale: 1.2),
        PositionDirectionItem(
            id: 'between',
            emoji: '↔️',
            kind: PositionStageKind.scene,
            actorAlignment: Alignment(0, 0.35),
            refEmoji: '🌳',
            refAlignment: Alignment(-0.65, 0.25),
            refScale: 1.4,
            refEmoji2: '🌳',
            ref2Alignment: Alignment(0.65, 0.25)),
        PositionDirectionItem(
            id: 'among',
            emoji: '🌻',
            kind: PositionStageKind.scene,
            actorEmoji: '🌻',
            actorScale: 1.15,
            actorAlignment: Alignment(0, 0.3),
            refEmoji: '🌼',
            refAlignment: Alignment(-0.6, 0.3),
            refEmoji2: '🌷',
            ref2Alignment: Alignment(0.6, 0.3)),
        PositionDirectionItem(
            id: 'behind',
            emoji: '🙈',
            kind: PositionStageKind.scene,
            actorAlignment: Alignment(0.35, 0.05),
            actorInFront: false,
            refEmoji: '🌳',
            refAlignment: Alignment.center,
            refScale: 1.7),
        PositionDirectionItem(
            id: 'inFrontOf',
            emoji: '🏠',
            kind: PositionStageKind.scene,
            actorAlignment: Alignment(0, 0.5),
            refEmoji: '🏠',
            refAlignment: Alignment(0, -0.2),
            refScale: 1.6),
        PositionDirectionItem(
            id: 'around',
            emoji: '🔄',
            kind: PositionStageKind.orbit,
            actorEmoji: '🦋',
            refEmoji: '🌼',
            refScale: 1.35),
        PositionDirectionItem(
            id: 'across',
            emoji: '🌉',
            kind: PositionStageKind.direction,
            dirDx: 1,
            actorEmoji: '🚶'),
        PositionDirectionItem(
            id: 'opposite',
            emoji: '↔️',
            kind: PositionStageKind.scene,
            actorAlignment: Alignment(-0.65, 0.35),
            refEmoji: '🐰',
            refAlignment: Alignment(0.65, 0.35)),
        PositionDirectionItem(
            id: 'atTheCorner',
            emoji: '📐',
            kind: PositionStageKind.scene,
            actorAlignment: Alignment(0.75, 0.6),
            refEmoji: '🏠',
            refAlignment: Alignment(-0.2, 0.1),
            refScale: 1.5),
        PositionDirectionItem(
            id: 'atTheEdge',
            emoji: '🏞️',
            kind: PositionStageKind.scene,
            actorAlignment: Alignment(0.8, 0.1),
            refEmoji: '🟫',
            refAlignment: Alignment(0, 0.5),
            refScale: 2),
      ],
    ),
    PositionDirectionCategory(
      id: 'movementDirections',
      emoji: '🏃',
      colorIndex: 6,
      items: [
        PositionDirectionItem(
            id: 'goUp',
            emoji: '🆙',
            kind: PositionStageKind.direction,
            dirDy: -1),
        PositionDirectionItem(
            id: 'goDown',
            emoji: '🔽',
            kind: PositionStageKind.direction,
            dirDy: 1),
        PositionDirectionItem(
            id: 'goLeft',
            emoji: '👈',
            kind: PositionStageKind.direction,
            dirDx: -1),
        PositionDirectionItem(
            id: 'goRight',
            emoji: '👉',
            kind: PositionStageKind.direction,
            dirDx: 1),
        PositionDirectionItem(
            id: 'goStraight',
            emoji: '⬆️',
            kind: PositionStageKind.direction,
            dirDy: -1,
            actorEmoji: '🚶'),
        PositionDirectionItem(
            id: 'turnLeft',
            emoji: '↩️',
            kind: PositionStageKind.orbit,
            actorEmoji: '🚗',
            refEmoji: '⬅️'),
        PositionDirectionItem(
            id: 'turnRight',
            emoji: '↪️',
            kind: PositionStageKind.orbit,
            actorEmoji: '🚗',
            refEmoji: '➡️'),
        PositionDirectionItem(
            id: 'turnAround',
            emoji: '🔁',
            kind: PositionStageKind.orbit,
            actorEmoji: '🚶',
            refEmoji: '📍'),
        PositionDirectionItem(
            id: 'moveForward',
            emoji: '⏩',
            kind: PositionStageKind.direction,
            dirDx: 1,
            actorEmoji: '🚲'),
        PositionDirectionItem(
            id: 'moveBackward',
            emoji: '⏪',
            kind: PositionStageKind.direction,
            dirDx: -1,
            actorEmoji: '🚲'),
        PositionDirectionItem(
            id: 'climbUp',
            emoji: '🧗',
            kind: PositionStageKind.direction,
            dirDy: -1,
            actorEmoji: '🧗'),
        PositionDirectionItem(
            id: 'climbDown',
            emoji: '🪜',
            kind: PositionStageKind.direction,
            dirDy: 1,
            actorEmoji: '🧗'),
        PositionDirectionItem(
            id: 'jumpUp',
            emoji: '🤸',
            kind: PositionStageKind.direction,
            dirDy: -1,
            actorEmoji: '🐸'),
        PositionDirectionItem(
            id: 'jumpDown',
            emoji: '🦘',
            kind: PositionStageKind.direction,
            dirDy: 1,
            actorEmoji: '🐸'),
        PositionDirectionItem(
            id: 'stepForward',
            emoji: '👣',
            kind: PositionStageKind.direction,
            dirDx: 1,
            actorEmoji: '👣'),
        PositionDirectionItem(
            id: 'stepBack',
            emoji: '🔙',
            kind: PositionStageKind.direction,
            dirDx: -1,
            actorEmoji: '👣'),
        PositionDirectionItem(
            id: 'walkAround',
            emoji: '🚶',
            kind: PositionStageKind.orbit,
            actorEmoji: '🚶',
            refEmoji: '🌳',
            refScale: 1.4),
        PositionDirectionItem(
            id: 'runTowards',
            emoji: '🏃',
            kind: PositionStageKind.direction,
            dirDx: 1,
            actorEmoji: '🏃',
            refEmoji: '🏁',
            refAlignment: Alignment(0.75, 0.25)),
        PositionDirectionItem(
            id: 'moveAway',
            emoji: '💨',
            kind: PositionStageKind.direction,
            dirDx: -1,
            actorEmoji: '🚶',
            refEmoji: '🏠',
            refAlignment: Alignment(0.75, 0.25)),
      ],
    ),
    PositionDirectionCategory(
      id: 'distancePlace',
      emoji: '🗺️',
      colorIndex: 9,
      items: [
        PositionDirectionItem(
            id: 'close',
            emoji: '👥',
            kind: PositionStageKind.scene,
            actorAlignment: Alignment(0.2, 0.35),
            refEmoji: '🧸',
            refAlignment: Alignment(-0.2, 0.35)),
        PositionDirectionItem(
            id: 'distant',
            emoji: '🏔️',
            kind: PositionStageKind.scene,
            actorEmoji: '🏔️',
            actorAlignment: Alignment(0.75, -0.5),
            actorScale: 0.6,
            refEmoji: '🏠',
            refAlignment: Alignment(-0.65, 0.4)),
        PositionDirectionItem(
            id: 'here',
            emoji: '📍',
            kind: PositionStageKind.scene,
            actorAlignment: Alignment.center,
            refEmoji: '📍',
            refAlignment: Alignment(0, 0.55),
            refScale: 1.2),
        PositionDirectionItem(
            id: 'there',
            emoji: '👉',
            kind: PositionStageKind.scene,
            actorAlignment: Alignment(0.7, 0.2),
            actorScale: 0.7,
            refEmoji: '👉',
            refAlignment: Alignment(-0.45, 0.2),
            refScale: 1.2),
        PositionDirectionItem(
            id: 'everywhere',
            emoji: '🌍',
            kind: PositionStageKind.orbit,
            actorEmoji: '✨',
            refEmoji: '🌍',
            refScale: 1.4),
        PositionDirectionItem(
            id: 'somewhere',
            emoji: '🗺️',
            kind: PositionStageKind.scene,
            actorEmoji: '⭐',
            actorAlignment: Alignment(0.35, -0.2),
            actorScale: 0.85,
            refEmoji: '🗺️',
            refAlignment: Alignment(-0.15, 0.28),
            refScale: 1.6),
        PositionDirectionItem(
            id: 'nowhere',
            emoji: '🙅',
            kind: PositionStageKind.scene,
            actorEmoji: '🙅',
            actorScale: 1.2,
            actorAlignment: Alignment(-0.15, 0.05),
            refEmoji: '📦',
            refAlignment: Alignment(0.45, 0.4),
            refScale: 1.3),
      ],
    ),
    PositionDirectionCategory(
      id: 'orderHeight',
      emoji: '📊',
      colorIndex: 12,
      items: [
        PositionDirectionItem(
            id: 'higher',
            emoji: '📈',
            kind: PositionStageKind.scene,
            actorEmoji: '🎈',
            actorAlignment: Alignment(-0.35, -0.45),
            refEmoji: '🎈',
            refAlignment: Alignment(0.35, 0.25)),
        PositionDirectionItem(
            id: 'lower',
            emoji: '📉',
            kind: PositionStageKind.scene,
            actorEmoji: '🎈',
            actorAlignment: Alignment(-0.35, 0.35),
            refEmoji: '🎈',
            refAlignment: Alignment(0.35, -0.4)),
        PositionDirectionItem(
            id: 'highest',
            emoji: '🏆',
            kind: PositionStageKind.scene,
            actorEmoji: '🏆',
            actorAlignment: Alignment(0, -0.6),
            refEmoji: '🥈',
            refAlignment: Alignment(-0.55, 0.3),
            refEmoji2: '🥉',
            ref2Alignment: Alignment(0.55, 0.45)),
        PositionDirectionItem(
            id: 'lowest',
            emoji: '🔻',
            kind: PositionStageKind.scene,
            actorEmoji: '🐜',
            actorAlignment: Alignment(0, 0.65),
            refEmoji: '🐦',
            refAlignment: Alignment(-0.55, -0.2),
            refEmoji2: '🦋',
            ref2Alignment: Alignment(0.55, -0.45)),
        PositionDirectionItem(
            id: 'upper',
            emoji: '⬆️',
            kind: PositionStageKind.scene,
            actorEmoji: '🪟',
            actorAlignment: Alignment(0, -0.5),
            refEmoji: '🏠',
            refAlignment: Alignment(0, 0.25),
            refScale: 1.5),
        PositionDirectionItem(
            id: 'first',
            emoji: '🥇',
            kind: PositionStageKind.scene,
            actorEmoji: '🥇',
            actorAlignment: Alignment(-0.6, 0.3),
            refEmoji: '🥈',
            refAlignment: Alignment.center,
            refEmoji2: '🥉',
            ref2Alignment: Alignment(0.6, 0.3)),
        PositionDirectionItem(
            id: 'last',
            emoji: '🏁',
            kind: PositionStageKind.scene,
            actorEmoji: '🐢',
            actorAlignment: Alignment(0.7, 0.4),
            refEmoji: '🐇',
            refAlignment: Alignment(-0.65, 0.4),
            refEmoji2: '🏁',
            ref2Alignment: Alignment(0.9, 0.4)),
      ],
    ),
    PositionDirectionCategory(
      id: 'compass',
      emoji: '🧭',
      colorIndex: 15,
      items: [
        PositionDirectionItem(
            id: 'north',
            emoji: '⬆️',
            kind: PositionStageKind.direction,
            dirDy: -1,
            actorEmoji: '🧭'),
        PositionDirectionItem(
            id: 'south',
            emoji: '⬇️',
            kind: PositionStageKind.direction,
            dirDy: 1,
            actorEmoji: '🧭'),
        PositionDirectionItem(
            id: 'east',
            emoji: '🌅',
            kind: PositionStageKind.direction,
            dirDx: 1,
            actorEmoji: '🧭'),
        PositionDirectionItem(
            id: 'west',
            emoji: '🌇',
            kind: PositionStageKind.direction,
            dirDx: -1,
            actorEmoji: '🧭'),
      ],
    ),
  ];

  static List<PositionDirectionItem> get items =>
      categories.expand((category) => category.items).toList(growable: false);

  static int get count => items.length;
}
