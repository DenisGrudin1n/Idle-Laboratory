import 'package:flutter/material.dart';

/// Asset image decoded at display resolution to reduce memory and decode cost.
class CachedAssetImage extends StatelessWidget {
  const CachedAssetImage({
    required this.asset,
    super.key,
    this.fit,
    this.width,
    this.height,
    this.size,
    this.color,
    this.filterQuality = FilterQuality.low,
    this.decodeMemCacheWidth,
    this.decodeMemCacheHeight,
    this.errorBuilder,
    this.package,
    this.alignment = Alignment.center,
  });

  final String asset;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final double? size;
  final Color? color;
  final FilterQuality filterQuality;
  final int? decodeMemCacheWidth;
  final int? decodeMemCacheHeight;
  final ImageErrorWidgetBuilder? errorBuilder;
  final String? package;
  final AlignmentGeometry alignment;

  static bool _fitPreservesAspectRatio(BoxFit? fit) {
    return switch (fit) {
      BoxFit.contain || BoxFit.scaleDown || null => true,
      BoxFit.fill || BoxFit.cover || BoxFit.fitWidth || BoxFit.fitHeight || BoxFit.none => false,
    };
  }

  static ({int? width, int? height})? _resolveMemCachePixels(
    BuildContext context, {
    double? width,
    double? height,
    double? size,
    BoxFit? fit,
    int? decodeMemCacheWidth,
    int? decodeMemCacheHeight,
  }) {
    if (decodeMemCacheWidth != null || decodeMemCacheHeight != null) {
      if (_fitPreservesAspectRatio(fit)) {
        final side = (decodeMemCacheWidth ?? decodeMemCacheHeight)!.clamp(1, 4096);
        return (width: side, height: null);
      }
      return (
        width: decodeMemCacheWidth?.clamp(1, 4096),
        height: decodeMemCacheHeight?.clamp(1, 4096),
      );
    }

    final logicalW = width ?? size;
    final logicalH = height ?? size;
    if (logicalW == null || logicalH == null || logicalW <= 0 || logicalH <= 0) {
      return null;
    }

    final dpr = MediaQuery.devicePixelRatioOf(context);
    if (_fitPreservesAspectRatio(fit)) {
      final maxLogical = logicalW > logicalH ? logicalW : logicalH;
      return (width: (maxLogical * dpr).round().clamp(1, 4096), height: null);
    }
    return (
      width: (logicalW * dpr).round().clamp(1, 4096),
      height: (logicalH * dpr).round().clamp(1, 4096),
    );
  }

  @override
  Widget build(BuildContext context) {
    final memCache = _resolveMemCachePixels(
      context,
      width: width,
      height: height,
      size: size,
      fit: fit,
      decodeMemCacheWidth: decodeMemCacheWidth,
      decodeMemCacheHeight: decodeMemCacheHeight,
    );

    final imageProvider = ResizeImage.resizeIfNeeded(
      memCache?.width,
      memCache?.height,
      AssetImage(asset, package: package),
    );

    return Image(
      image: imageProvider,
      fit: fit,
      width: width ?? size,
      height: height ?? size,
      color: color,
      alignment: alignment,
      gaplessPlayback: true,
      filterQuality: filterQuality,
      errorBuilder: errorBuilder,
    );
  }
}
