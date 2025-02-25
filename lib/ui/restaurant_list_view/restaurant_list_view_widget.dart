import 'package:flutter/material.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/static/static.dart';
import 'package:platescape/ui/ui.dart';

class RestaurantListView extends StatelessWidget {
  const RestaurantListView({
    super.key,
    required this.restaurantList,
    this.showFavoriteButton = false,
  });

  final List<Restaurant> restaurantList;
  final bool showFavoriteButton;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurantList.length,
      itemBuilder: (context, index) {
        final restaurant = restaurantList[index];

        return RestaurantCard(
            restaurant: restaurant,
            showFavoriteButton: showFavoriteButton,
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoute.detail.route,
                arguments: restaurant.id,
              );
            });
      },
    );
  }
}
