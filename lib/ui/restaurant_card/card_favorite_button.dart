import 'package:flutter/material.dart';
import 'package:platescape/data/data.dart';
import 'package:provider/provider.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/static/static.dart';

class CardFavoriteButton extends StatefulWidget {
  const CardFavoriteButton({
    super.key,
    required this.restaurant,
  });
  final Restaurant restaurant;

  @override
  State<CardFavoriteButton> createState() => _CardFavoriteButtonState();
}

class _CardFavoriteButtonState extends State<CardFavoriteButton> {
  @override
  void initState() {
    final favoriteRestaurantsProvider =
        context.read<FavoriteRestaurantsProvider>();
    final favoriteIconProvider = context.read<FavoriteIconProvider>();

    Future.microtask(() async {
      final isFavorite =
          await favoriteRestaurantsProvider.isFavorite(widget.restaurant.id);

      favoriteIconProvider.setFavorite = isFavorite;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final restaurant = widget.restaurant;
        // final favoriteRestaurantsProvider =
        //     context.read<FavoriteRestaurantsProvider>();
        final favoriteIconProvider = context.read<FavoriteIconProvider>();

        favoriteIconProvider.toggleFavorite(restaurant);
      },
      icon: Icon(
        context.watch<FavoriteIconProvider>().state is FavoriteAddedState
            ? Icons.favorite_rounded
            : Icons.favorite_outline_rounded,
      ),
    );
  }
}
