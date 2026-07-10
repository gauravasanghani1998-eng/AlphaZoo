class EmotionItem {
  final String emoji;
  final String nameKey;

  const EmotionItem({
    required this.emoji,
    required this.nameKey,
  });
}

class EmotionsData {
  EmotionsData._();

  static const List<EmotionItem> items = [
    EmotionItem(emoji: '😊', nameKey: 'emotions.names.happy'),
    EmotionItem(emoji: '😢', nameKey: 'emotions.names.sad'),
    EmotionItem(emoji: '😠', nameKey: 'emotions.names.angry'),
    EmotionItem(emoji: '😨', nameKey: 'emotions.names.scared'),
    EmotionItem(emoji: '😲', nameKey: 'emotions.names.surprised'),
    EmotionItem(emoji: '😳', nameKey: 'emotions.names.shy'),
    EmotionItem(emoji: '🌟', nameKey: 'emotions.names.proud'),
    EmotionItem(emoji: '😴', nameKey: 'emotions.names.tired'),
    EmotionItem(emoji: '🤩', nameKey: 'emotions.names.excited'),
    EmotionItem(emoji: '😌', nameKey: 'emotions.names.calm'),
    EmotionItem(emoji: '😟', nameKey: 'emotions.names.worried'),
    EmotionItem(emoji: '🤪', nameKey: 'emotions.names.silly'),
    EmotionItem(emoji: '🥰', nameKey: 'emotions.names.loved'),
    EmotionItem(emoji: '😔', nameKey: 'emotions.names.lonely'),
    EmotionItem(emoji: '😑', nameKey: 'emotions.names.bored'),
    EmotionItem(emoji: '🤔', nameKey: 'emotions.names.curious'),
    EmotionItem(emoji: '💪', nameKey: 'emotions.names.brave'),
    EmotionItem(emoji: '🤗', nameKey: 'emotions.names.kind'),
    EmotionItem(emoji: '😕', nameKey: 'emotions.names.confused'),
    EmotionItem(emoji: '🙏', nameKey: 'emotions.names.grateful'),
    EmotionItem(emoji: '😬', nameKey: 'emotions.names.nervous'),
    EmotionItem(emoji: '😒', nameKey: 'emotions.names.jealous'),
    EmotionItem(emoji: '😜', nameKey: 'emotions.names.playful'),
    EmotionItem(emoji: '😤', nameKey: 'emotions.names.grumpy'),
    EmotionItem(emoji: '🤞', nameKey: 'emotions.names.hopeful'),
    EmotionItem(emoji: '‍💨', nameKey: 'emotions.names.relieved'),
    EmotionItem(emoji: '🤭', nameKey: 'emotions.names.embarrassed'),
    EmotionItem(emoji: '🤢', nameKey: 'emotions.names.yucky'),
    EmotionItem(emoji: '🫂', nameKey: 'emotions.names.missYou'),
    EmotionItem(emoji: '😞', nameKey: 'emotions.names.disappointed'),
  ];
}
