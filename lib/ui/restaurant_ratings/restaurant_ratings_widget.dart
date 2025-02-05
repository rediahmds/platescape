import 'package:flutter/material.dart';
import 'package:platescape/ui/ui.dart';

class RestaurantRatings extends StatelessWidget {
  const RestaurantRatings({
    super.key,
    required this.rating,
    required this.totalReviews,
  });

  final double rating;
  final int totalReviews;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rate_rounded),
        const SizedBox.square(dimension: 6.0),
        RestaurantRatingValues(rating: rating, totalReviews: totalReviews)
      ],
    );
  }
}
