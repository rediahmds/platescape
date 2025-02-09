import 'package:flutter/material.dart';
import 'package:platescape/styles/styles.dart';

class CardRating extends StatelessWidget {
  const CardRating({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.star_rounded,
          color: PlatescapeColors.yellow.color,
        ),
        const SizedBox.square(dimension: 4.0),
        Text(
          rating.toString(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
