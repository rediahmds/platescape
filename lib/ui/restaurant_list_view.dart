import 'package:flutter/material.dart';
import 'package:platescape/data/models/models.dart';
import 'package:platescape/ui/restaurant_card/restaurant_card.dart';

class RestaurantListView extends StatelessWidget {
  const RestaurantListView({super.key, required this.restaurantList});

  final List<Restaurant> restaurantList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurantList.length,
      itemBuilder: (context, index) {
        final restaurant = restaurantList[index];

        return RestaurantCard(
            restaurant: restaurant,
            onTap: () {
              //TODO: Navigate to detail
              debugPrint("[TODO] ${restaurant.name} clicked");
            });
      },
    );
  }
}
