import 'package:flutter/material.dart';
import 'package:platescape/styles/styles.dart';

class CardCity extends StatelessWidget {
  const CardCity({super.key, required this.city});

  final String city;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_city_rounded,
          color: PlatescapeColors.green.color,
        ),
        const SizedBox.square(dimension: 4.0),
        Text(
          city,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
