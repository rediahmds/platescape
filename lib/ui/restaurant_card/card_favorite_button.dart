import 'package:flutter/material.dart';
import 'package:platescape/data/data.dart';
import 'package:provider/provider.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/static/static.dart';

class CardFavoriteButton extends StatefulWidget {
  const CardFavoriteButton({super.key, required this.restaurant});
  final Restaurant restaurant;

  @override
  State<CardFavoriteButton> createState() => _CardFavoriteButtonState();
}

class _CardFavoriteButtonState extends State<CardFavoriteButton> {
  @override
  void initState() {
    Future.microtask(() async {
      final restaurant = widget.restaurant;

      final favoriteRestaurantsProvider =
          context.read<FavoriteRestaurantsProvider>();

      final favoriteIconProvider = context.read<FavoriteIconProvider>();

      final isFavorite =
          await favoriteRestaurantsProvider.isFavorite(restaurant.id);
      favoriteIconProvider.initializeFavoriteStatus(restaurant.id, isFavorite);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteIconProvider = context.watch<FavoriteIconProvider>();
    final favoriteRestaurantsProvider =
        context.read<FavoriteRestaurantsProvider>();
    final restaurant = widget.restaurant;

    return IconButton(
      onPressed: () async {
        final isFavorite =
            await favoriteRestaurantsProvider.isFavorite(restaurant.id);

        if (!isFavorite) {
          await favoriteRestaurantsProvider.addFavorite(restaurant);
        } else {
          await favoriteRestaurantsProvider.removeFavorite(restaurant.id);
        }

        favoriteIconProvider.updateState(restaurant.id, !isFavorite);
      },
      icon: Icon(
        favoriteIconProvider.getState(restaurant.id) is FavoriteAddedState
            ? Icons.favorite_rounded
            : Icons.favorite_outline_rounded,
        color:
            favoriteIconProvider.getState(restaurant.id) is FavoriteAddedState
                ? Colors.pink
                : null,
      ),
    );
  }
}
