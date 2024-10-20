import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/cached_network_image_w.dart';

class CarouselSliderDetailW extends StatelessWidget {
  const CarouselSliderDetailW(
      {super.key, required this.images, required this.width});

  final List<String> images;

  final double width;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images
          .map(
            (e) => CachedNetworkImageW(
              imageUrl: e,
              width: width,
            ),
          )
          .toList(),
      options: CarouselOptions(
        height: 550,
        viewportFraction: 1,
      ),
    );
  }
}
