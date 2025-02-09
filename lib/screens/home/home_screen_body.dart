import 'package:flutter/material.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/ui/ui.dart';
import 'package:provider/provider.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/static/static.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    super.key,
    required this.restaurantList,
  });

  final List<Restaurant> restaurantList;

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, searchProvider, child) {
        final searchController = searchProvider.searchController;

        switch (searchProvider.resultState) {
          case RestaurantSearchLoadingState():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case RestaurantSearchNotFoundState():
            return const Center(
              child: Text("No restaurant found with the given query"),
            );
          case RestaurantSearchLoadedState(restaurantList: final searchResult):
            return RestaurantListSearchable(
              restaurantList: searchResult,
              searchController: searchController,
              onSubmitted: (_) async {
                await searchProvider.searchRestaurant(searchController.text);
              },
            );
          default:
            return RestaurantListSearchable(
              restaurantList: restaurantList,
              searchController: searchController,
              onSubmitted: (_) async {
                await searchProvider.searchRestaurant(searchController.text);
              },
            );
        }
      },
    );
  }
}
