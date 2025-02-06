import 'package:flutter/material.dart';

class RestaurantAddress extends StatelessWidget {
  const RestaurantAddress({
    super.key,
    required this.address,
    required this.city,
  });

  final String city;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(city),
        const SizedBox.square(dimension: 4.0),
        Text(address),
      ],
    );
  }
}
