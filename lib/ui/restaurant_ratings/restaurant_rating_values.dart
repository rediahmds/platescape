import 'package:flutter/material.dart';

class RestaurantRatingValues extends StatelessWidget {
  const RestaurantRatingValues({
    super.key,
    required this.rating,
    required this.totalReviews,
  });

  final double rating;
  final int totalReviews;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(rating.toString()),
        const SizedBox.square(dimension: 4.0),
        Text("${totalReviews.toString()} Reviews"),
      ],
    );
  }
}
