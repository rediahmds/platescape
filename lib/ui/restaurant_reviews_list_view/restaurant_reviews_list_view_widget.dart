import 'package:flutter/material.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/ui/ui.dart';

class RestaurantReviewsListView extends StatelessWidget {
  const RestaurantReviewsListView({super.key, required this.reviews});

  final List<CustomerReview> reviews;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 60),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return RestaurantReviewCard(
          name: review.name,
          date: review.date,
          review: review.review,
        );
      },
    );
  }
}
