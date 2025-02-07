import 'package:flutter/material.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/ui/ui.dart';

class ReviewsScreenBody extends StatelessWidget {
  const ReviewsScreenBody({super.key, required this.reviews});

  final List<CustomerReview> reviews;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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