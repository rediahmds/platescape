import 'package:flutter/material.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/ui/ui.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.onTap,
    this.showFavoriteButton = false,
  });

  final Restaurant restaurant;
  final Function() onTap;
  final bool showFavoriteButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: restaurant.id,
              child: CardImage(
                pictureUrl:
                    APIServices().getLowResPictureUrl(restaurant.pictureId),
              ),
            ),
            const SizedBox.square(dimension: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        restaurant.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox.square(
                        dimension: 8.0,
                      ),
                      CardCity(city: restaurant.city),
                      const SizedBox.square(
                        dimension: 8.0,
                      ),
                      CardRating(rating: restaurant.rating),
                      if (showFavoriteButton)
                        IconButton(
                          icon: Icon(Icons.favorite_rounded),
                          onPressed: () {}, // TODO: Use state manager
                        ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
