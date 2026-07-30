import 'package:flutter/material.dart';

/// Displays an image from [imageUrl]. If the network image fails to
/// load (link removed, offline, timeout, etc.), it falls back to the
/// local asset at [assetPath] instead.
class FallbackImage extends StatelessWidget {
  const FallbackImage({
    super.key,
    required this.imageUrl,
    required this.assetPath,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  final String imageUrl;
  final String assetPath;
  final BoxFit fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: fit,
      width: width,
      height: height,
      // Option 1: original link — used whenever it loads successfully.
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          width: width,
          height: height,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
      // Option 2: assets/images/ — used only if the network image errors
      // out (offline, link removed, timeout, etc.).
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          assetPath,
          fit: fit,
          width: width,
          height: height,
        );
      },
    );
  }
}