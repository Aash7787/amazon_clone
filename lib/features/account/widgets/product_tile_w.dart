import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/cached_network_image_w.dart';

class ProductTileW extends StatelessWidget {
  const ProductTileW({super.key, required this.image});

  final String image;

  static const _borderWidth = 1.5;
  static const _borderRadius = 5.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 250,
        height: 250,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white70,
          border: Border.all(width: _borderWidth, color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            6,
          ),
          child: CachedNetworkImageW(
            fit: BoxFit.fill,
            imageUrl: image, // URL of the image
          ),
        ),
      ),
    );
  }
}
