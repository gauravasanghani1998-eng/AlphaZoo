import 'package:easy_localization/easy_localization.dart';

import '../data/stories_data.dart';

/// Loads localized story bodies from [assets/translations] via EasyLocalization.
class StoryContentLoader {
  StoryContentLoader._();

  /// Every [StoriesData] id has title/subtitle/moral/paragraphs in all locales.
  static StoryContent contentFor(String storyId) {
    final base = 'stories.items.$storyId';
    final paragraphs = <String>[];
    for (var i = 1; i <= 12; i++) {
      final key = '$base.p$i';
      final text = key.tr();
      if (text.isEmpty || text == key) break;
      paragraphs.add(text);
    }

    return StoryContent(
      title: '$base.title'.tr(),
      subtitle: '$base.subtitle'.tr(),
      paragraphs: paragraphs,
      moral: '$base.moral'.tr(),
    );
  }
}
