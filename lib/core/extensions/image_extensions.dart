import 'package:idle_laboratory/core/constants/image_constants.dart';
import 'package:idle_laboratory/core/enums/magician_emotion.dart';

extension MagicianEmotionExt on MagicianEmotion {
  String get assetPath {
    switch (this) {
      case MagicianEmotion.kind:
        return ImageConstants.magicianKind;
      case MagicianEmotion.greedy:
        return ImageConstants.magicianGreedy;
      case MagicianEmotion.evil:
        return ImageConstants.magicianEvil;
    }
  }
}
