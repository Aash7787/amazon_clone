import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarRatingBarW extends StatelessWidget {
  const StarRatingBarW({super.key, required this.rating});
  final double rating;
  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      direction: Axis.horizontal,
      itemCount: 5,
      rating: rating,
      itemSize: 15,
      itemPadding: const EdgeInsets.only(right: 1),
      itemBuilder: (context, index) {
        return const Icon(
          // size: 50,
          Icons.star,
          color: GlobalVariables.secondaryColor,
        );
      },
    );
  }
}
