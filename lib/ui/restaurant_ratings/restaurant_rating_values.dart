import 'package:flutter/material.dart';

class RestaurantRatingValues extends StatelessWidget {
  const RestaurantRatingValues({
    super.key,
    required this.rating,
    required this.totalReviews,
    this.maxRating = 5,
  });

  final double rating;
  final int totalReviews;
  final int maxRating;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("${rating.toString()} out of $maxRating"),
        const SizedBox.square(dimension: 4.0),
        Text("${totalReviews.toString()} Reviews"),
      ],
    );
  }
}
