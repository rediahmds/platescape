import 'package:flutter/material.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/screens/screens.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({
    super.key,
    required this.restaurantName,
    required this.reviews,
  });

  final String restaurantName;
  final List<CustomerReview> reviews;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              restaurantName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox.square(dimension: 6.0),
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
      body: ReviewsScreenBody(reviews: reviews),
    );
  }
}
