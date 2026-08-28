import 'package:idle_laboratory/core/enums/magician_emotion.dart';
import 'package:idle_laboratory/core/enums/story_beat_id.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';

extension StoryBeatIdExt on StoryBeatId {
  MagicianEmotion get emotion => MagicianEmotion.greedy;

  /// Beats 1 & 3: mage on the left, mirrored toward the lore text.
  bool get mageOnLeft => switch (this) {
        StoryBeatId.darkMatterUnlocked || StoryBeatId.firstBloodDrop => true,
        StoryBeatId.darkMatterProductionMaxed || StoryBeatId.abyssalHeartCrafted => false,
      };

  String title(AppLocalizations l10n) => switch (this) {
        StoryBeatId.darkMatterUnlocked => l10n.storyBeatDarkMatterUnlockTitle,
        StoryBeatId.darkMatterProductionMaxed => l10n.storyBeatDarkMatterProductionMaxTitle,
        StoryBeatId.firstBloodDrop => l10n.storyBeatBloodDropTitle,
        StoryBeatId.abyssalHeartCrafted => l10n.storyBeatAbyssalHeartTitle,
      };

  String description(AppLocalizations l10n) => switch (this) {
        StoryBeatId.darkMatterUnlocked => l10n.storyBeatDarkMatterUnlockDesc,
        StoryBeatId.darkMatterProductionMaxed => l10n.storyBeatDarkMatterProductionMaxDesc,
        StoryBeatId.firstBloodDrop => l10n.storyBeatBloodDropDesc,
        StoryBeatId.abyssalHeartCrafted => l10n.storyBeatAbyssalHeartDesc,
      };
}
