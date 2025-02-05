import 'package:flutter/material.dart';

class CardCity extends StatelessWidget {
  const CardCity({super.key, required this.city});

  final String city;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_city_rounded),
        const SizedBox.square(dimension: 4.0),
        Text(
          city,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
        ),
      ],
    );
  }
}
