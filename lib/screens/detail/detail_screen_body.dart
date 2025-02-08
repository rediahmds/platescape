import 'package:flutter/material.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/static/static.dart';
import 'package:platescape/ui/ui.dart';

class DetailScreenBody extends StatelessWidget {
  const DetailScreenBody({super.key, required this.restaurantDetails});

  final RestaurantDetails restaurantDetails;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CardImage(
              pictureUrl: APIServices()
                  .getHighResPictureUrl(restaurantDetails.pictureId),
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: 500,
              borderRadius: 25.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  restaurantDetails.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox.square(dimension: 8.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RestaurantLocation(
                        city: restaurantDetails.city,
                        address: restaurantDetails.address),
                    const SizedBox.square(dimension: 8),
                    RestaurantRatings(
                        rating: restaurantDetails.rating,
                        totalReviews: restaurantDetails.customerReviews.length)
                  ],
                ),
                const SizedBox.square(dimension: 8.0),
                Text(
                  restaurantDetails.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox.square(dimension: 8.0),
                ExpansionTile(
                  title: const Text("Categories"),
                  children:
                      _generateCategoryTiles(restaurantDetails.categories),
                ),
                const SizedBox.square(dimension: 8.0),
                ExpansionTile(
                  title: const Text("Foods"),
                  initiallyExpanded: true,
                  children: _generateFoodsTiles(restaurantDetails.menus.foods),
                ),
                const SizedBox.square(dimension: 8.0),
                ExpansionTile(
                  title: const Text("Drinks"),
                  initiallyExpanded: true,
                  children:
                      _generateDrinksTiles(restaurantDetails.menus.drinks),
                ),
                const SizedBox.square(dimension: 16),
                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.reviews.route,
                        arguments: {
                          "restaurantName": restaurantDetails.name,
                          "restaurantId": restaurantDetails.id,
                        },
                      );
                    },
                    label: const Text("Reviews"),
                    icon: const Icon(Icons.arrow_forward_rounded),
                    iconAlignment: IconAlignment.end,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _generateCategoryTiles(List<Category> categories) =>
      List.generate(
        restaurantDetails.categories.length,
        (index) {
          final categoryName = restaurantDetails.categories[index].name;
          return RestaurantTile(name: categoryName);
        },
      );

  List<Widget> _generateFoodsTiles(List<Category> foods) =>
      List.generate(foods.length, (index) {
        final foodName = foods[index].name;
        return RestaurantTile(name: foodName);
      });

  List<Widget> _generateDrinksTiles(List<Category> drinks) =>
      List.generate(drinks.length, (index) {
        final drinkName = drinks[index].name;
        return RestaurantTile(name: drinkName);
      });
}
