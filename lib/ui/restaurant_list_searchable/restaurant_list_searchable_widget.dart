import 'package:flutter/material.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/ui/ui.dart';

class RestaurantListSearchable extends StatelessWidget {
  const RestaurantListSearchable({
    super.key,
    required this.restaurantList,
    required this.searchController,
    required this.onSubmitted,
  });

  final List<Restaurant> restaurantList;
  final SearchController searchController;
  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RestaurantSearchBar(
          searchController: searchController,
          onSubmitted: onSubmitted,
        ),
        Expanded(
          child: RestaurantListView(
            restaurantList: restaurantList,
            showFavoriteButton: true,
          ),
        ),
      ],
    );
  }
}
