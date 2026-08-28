import 'package:flutter/material.dart';
import 'package:idle_laboratory/core/enums/magician_emotion.dart';
import 'package:idle_laboratory/core/extensions/image_extensions.dart';
import 'package:idle_laboratory/core/widgets/cached_asset_image.dart';

class MagicianSprite extends StatelessWidget {
  const MagicianSprite({
    required this.emotion,
    required this.size,
    super.key,
    this.flipped = false,
  });

  final MagicianEmotion emotion;
  final double size;
  final bool flipped;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scaleX: flipped ? -1 : 1,
      child: CachedAssetImage(
        asset: emotion.assetPath,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return SizedBox(
            width: size,
            height: size,
            child: Icon(Icons.person, color: Theme.of(context).disabledColor),
          );
        },
      ),
    );
  }
}
