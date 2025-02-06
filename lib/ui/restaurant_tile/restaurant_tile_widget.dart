import 'package:flutter/material.dart';

class RestaurantTile extends StatelessWidget {
  const RestaurantTile({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: Text(name),
    );
  }
}
