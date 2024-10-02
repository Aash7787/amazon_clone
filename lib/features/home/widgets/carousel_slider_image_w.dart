import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';

class CarouselSliderImageW extends StatelessWidget {
  const CarouselSliderImageW({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages
          .map(
            (e) => Image.network(
              e,
              fit: BoxFit.cover,
            ),
          )
          .toList(),
      options: CarouselOptions(
        height: 200,
        viewportFraction: 1,
      ),
    );
  }
}
