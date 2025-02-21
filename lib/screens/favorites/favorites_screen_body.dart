import 'package:flutter/material.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/static/states/states.dart';
import 'package:provider/provider.dart';
import 'package:platescape/ui/ui.dart';

class FavoritesScreenBody extends StatefulWidget {
  const FavoritesScreenBody({super.key});

  @override
  State<FavoritesScreenBody> createState() => _FavoritesScreenBodyState();
}

class _FavoritesScreenBodyState extends State<FavoritesScreenBody> {
  @override
  void initState() {
    final favoriteRestaurantsProvider =
        context.read<FavoriteRestaurantsProvider>();

    Future.microtask(() {
      favoriteRestaurantsProvider.loadFavorites();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteRestaurantsProvider>(
      builder: (context, favoriteProvider, child) {
        switch (favoriteProvider.resultState) {
          case FavoriteRestaurantsEmptyState():
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8.0,
                children: [
                  Text("No favorite restaurants yet."),
                  Text("Tap the ❤️ button to add one.")
                ],
              ),
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
