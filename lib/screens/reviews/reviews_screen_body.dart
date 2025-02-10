import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/ui/ui.dart';
import 'package:platescape/static/static.dart';

class ReviewsScreenBody extends StatelessWidget {
  const ReviewsScreenBody({
    super.key,
    required this.restaurantId,
    required this.nameController,
  });

  final String restaurantId;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantReviewsProvider>(
      builder: (context, restaurantReviewsProvider, child) {
        switch (restaurantReviewsProvider.resultState) {
          case RestaurantReviewsLoadingState():
            return const Center(child: CircularProgressIndicator());
          case RestaurantReviewsLoadedState(customerReviews: final reviews):
            return Stack(
              children: [
                RestaurantReviewsListView(reviews: reviews),
                Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: WriteReviewButton(
                      onPressed: () => showReviewModal(
                          context, restaurantId, nameController),
                    )),
              ],
            );
          default:
            return const Center(child: Text("An unexpected error occurred"));
        }
      },
    );
  }
}
