import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderImageW extends StatelessWidget {
  final List<File> images; // Accept the images as a parameter

  const CarouselSliderImageW({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images
          .map(
            (imageFile) => Image.file(
              imageFile,
              fit: BoxFit.cover,
            ),
          )
          .toList(),
      options: CarouselOptions(
        scrollDirection: Axis.horizontal,
        height: 200,
        animateToClosest: true,
        
        viewportFraction: 1,
      ),
    );
  }
}
