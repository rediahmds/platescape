import 'package:flutter/material.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/screens/screens.dart';
import 'package:platescape/static/states/restaurant_details_result_state.dart';
import 'package:provider/provider.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({
    super.key,
    required this.restaurantName,
    required this.restaurantId,
  });

  final String restaurantName;
  final String restaurantId;

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<RestaurantDetailsProvider>()
          .fetchRestaurantDetails(widget.restaurantId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              widget.restaurantName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "Reviews",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_rounded)),
      ),
      body: Consumer<RestaurantDetailsProvider>(
        builder: (context, restaurantDetailsProvider, child) {
          switch (restaurantDetailsProvider.resultState) {
            case RestaurantDetailsLoadingState():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case RestaurantDetailsLoadedState(data: final restaurantDetails):
              return Stack(
                children: [
                  ReviewsScreenBody(reviews: restaurantDetails.customerReviews),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.rate_review_rounded),
                      label: const Text("Add Review"),
                    ),
                  ),
                ],
              );
            default:
              return const Center(
                child: Text("An unexpected error occured"),
              );
          }
        },
      ),
    );
  }
}
