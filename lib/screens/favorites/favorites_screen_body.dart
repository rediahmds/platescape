import 'package:flutter/material.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/static/states/states.dart';
import 'package:provider/provider.dart';
import 'package:platescape/ui/ui.dart';

class FavoritesScreenBody extends StatelessWidget {
  const FavoritesScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteRestaurantsProvider>(
      builder: (context, favoriteProvider, child) {
        switch (favoriteProvider.resultState) {
          case FavoriteRestaurantsEmptyState():
            return const Center(
              child: Text("No favorite restaurants yet."),
            );
          case FavoriteRestaurantsLoadingState():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case FavoriteRestaurantsLoadedState(favorites: final favorites):
            return RestaurantListView(
              restaurantList: favorites,
              showFavoriteButton: true,
            );
          default:
            return const Center(
              child: Text("Unexpected error occurred."),
            );
        }
      },
    );
  }
}
