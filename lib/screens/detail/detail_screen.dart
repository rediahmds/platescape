import 'package:flutter/material.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/screens/screens.dart';
import 'package:platescape/static/static.dart';
import 'package:platescape/ui/ui.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.id});

  final String id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<RestaurantDetailsProvider>()
          .fetchRestaurantDetails(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Ink(
            decoration: ShapeDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              shape: CircleBorder(),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_rounded),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Ink(
              decoration: ShapeDecoration(
                color: Theme.of(context).colorScheme.onSecondary,
                shape: CircleBorder(),
              ),
              child: _buildFavoriteButton(context),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<RestaurantDetailsProvider>(
        builder: (context, restaurantDetailsProvider, child) {
          switch (restaurantDetailsProvider.resultState) {
            case RestaurantDetailsLoadingState():
              return const Center(
                child: CircularProgressIndicator(),
              );

            case RestaurantDetailsLoadedState(data: final restaurantDetails):
              return DetailScreenBody(restaurantDetails: restaurantDetails);

            case RestaurantDetailsErrorState(error: final message):
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8.0,
                  children: [
                    Text(message),
                    FilledButton.tonalIcon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: const Text("Back"),
                      icon: const Icon(Icons.arrow_back_rounded),
                    )
                  ],
                ),
              );

            default:
              return const Center(
                child: Text("An unexpected error occurred"),
              );
          }
        },
      ),
    );
  }

  Widget _buildFavoriteButton(BuildContext context) {
    return Consumer<RestaurantDetailsProvider>(
        builder: (context, detailsProvider, child) {
      switch (detailsProvider.resultState) {
        case RestaurantDetailsLoadedState(data: final restaurantDetail):
          final restaurant = Restaurant(
            id: restaurantDetail.id,
            name: restaurantDetail.name,
            description: restaurantDetail.description,
            pictureId: restaurantDetail.pictureId,
            city: restaurantDetail.city,
            rating: restaurantDetail.rating,
          );
          return CardFavoriteButton(restaurant: restaurant);

        default:
          return const SizedBox();
      }
    });
  }
}
