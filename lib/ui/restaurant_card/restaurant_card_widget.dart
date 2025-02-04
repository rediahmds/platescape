import 'package:flutter/material.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/ui/restaurant_card/restaurant_card.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard(
      {super.key, required this.restaurant, required this.onTap});

  final Restaurant restaurant;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardImage(
              pictureUrl:
                  APIServices().getLowResPictureUrl(restaurant.pictureId),
            ),
            const SizedBox.square(dimension: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(restaurant.name),
                  const SizedBox.square(
                    dimension: 8.0,
                  ),
                  CardCity(city: restaurant.city),
                  const SizedBox.square(
                    dimension: 8.0,
                  ),
                  CardRating(rating: restaurant.rating),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
