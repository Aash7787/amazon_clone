import 'package:flutter/material.dart';

class ProductTileW extends StatelessWidget {
  const ProductTileW({super.key, required this.image});

  final String image;

  static const _borderWidth = 1.5;
  static const _borderRadius = 5.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white70,
          border: Border.all(width: _borderWidth, color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            8,
          ),
          child: Image.network(
            image,
            fit: BoxFit.fitHeight,
            // width: 180,
          ),
        ),
      ),
    );
  }
}
