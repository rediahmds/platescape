import 'package:flutter/material.dart';
import 'package:platescape/ui/ui.dart';

class RestaurantLocation extends StatelessWidget {
  const RestaurantLocation({
    super.key,
    required this.city,
    required this.address,
  });

  final String city;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.location_pin),
        const SizedBox.square(dimension: 6.0),
        RestaurantAddress(address: address, city: city),
      ],
    );
  }
}
