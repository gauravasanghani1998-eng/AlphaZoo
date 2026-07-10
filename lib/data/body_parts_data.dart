class BodyPartItem {
  final String emoji;
  final String nameKey;
  final String? imageAsset;

  const BodyPartItem({
    required this.emoji,
    required this.nameKey,
    this.imageAsset,
  });
}

class BodyPartsData {
  BodyPartsData._();

  static const List<BodyPartItem> items = [
    BodyPartItem(emoji: '🧑', nameKey: 'bodyParts.names.head'),
    BodyPartItem(emoji: '💇', nameKey: 'bodyParts.names.hair'),
    BodyPartItem(emoji: '👀', nameKey: 'bodyParts.names.eyes'),
    BodyPartItem(emoji: '👂', nameKey: 'bodyParts.names.ear'),
    BodyPartItem(emoji: '👃', nameKey: 'bodyParts.names.nose'),
    BodyPartItem(emoji: '👄', nameKey: 'bodyParts.names.mouth'),
    BodyPartItem(emoji: '👅', nameKey: 'bodyParts.names.tongue'),
    BodyPartItem(emoji: '🦷', nameKey: 'bodyParts.names.teeth'),
    BodyPartItem(
      emoji: '🧣',
      imageAsset: 'assets/images/body/neck.png',
      nameKey: 'bodyParts.names.neck',
    ),
    BodyPartItem(
      emoji: '🏋️',
      imageAsset: 'assets/images/body/shoulders.png',
      nameKey: 'bodyParts.names.shoulders',
    ),
    BodyPartItem(emoji: '💪', nameKey: 'bodyParts.names.arm'),
    BodyPartItem(emoji: '🖐️', nameKey: 'bodyParts.names.hand'),
    BodyPartItem(emoji: '🤚', nameKey: 'bodyParts.names.fingers'),
    BodyPartItem(emoji: '🦵', nameKey: 'bodyParts.names.leg'),
    BodyPartItem(
      emoji: '🧎',
      imageAsset: 'assets/images/body/knee.png',
      nameKey: 'bodyParts.names.knee',
    ),
    BodyPartItem(emoji: '🦶', nameKey: 'bodyParts.names.foot'),
    BodyPartItem(emoji: '👣', nameKey: 'bodyParts.names.toes'),
  ];

  static int get count => items.length;
}
