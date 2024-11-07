import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageW extends StatelessWidget {
  const CachedNetworkImageW({
    super.key,
    required this.imageUrl,
    this.width = 140,
    this.fit = BoxFit.fill, this.height,
  });

  final BoxFit? fit;

  final double width;

  final double? height;

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl, // URL of the image
      fit: fit,
      height: height,
      width: width,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) =>
          const Icon(Icons.no_photography_outlined),
    );
  }
}
