import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarBuilderW extends StatelessWidget {
  const RatingBarBuilderW(
      {super.key, required this.onRatingUpdate, required this.initialRating});

  final ValueChanged<double> onRatingUpdate;

  final double initialRating;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: GlobalVariables.secondaryColor,
      ),
      initialRating: initialRating,
      maxRating: 5,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemPadding: const EdgeInsets.symmetric(horizontal: 5),
      onRatingUpdate: onRatingUpdate,
      glow: true,
    );
  }
}
