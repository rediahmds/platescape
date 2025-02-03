import 'package:flutter/material.dart';

class CardRating extends StatelessWidget {
  const CardRating({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.star_rounded),
        const SizedBox.square(dimension: 4.0),
        Text(rating.toString()),
      ],
    );
  }
}
