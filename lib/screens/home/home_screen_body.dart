import 'package:flutter/material.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/ui/ui.dart';
import 'package:provider/provider.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/static/static.dart';
import 'package:platescape/screens/screens.dart';

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
            return SearchNotFoundScreen();

          case RestaurantSearchErrorState(error: final message):
            return Center(
              child: Text(message),
            );

          default:
            final searchState = searchProvider.resultState;
            final resultList = searchState is RestaurantSearchLoadedState
                ? searchState.restaurantList
                : restaurantList;

            return RestaurantListSearchable(
              restaurantList: resultList,
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
