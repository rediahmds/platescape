import 'package:flutter/material.dart';

class RestaurantReviewTile extends StatelessWidget {
  const RestaurantReviewTile({
    super.key,
    required this.name,
    required this.date,
    required this.review,
  });

  final String name;
  final String date;
  final String review;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(name),
            subtitle: Text(date),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(review, textAlign: TextAlign.start,),
          ),
        ],
      ),
    );
  }
}
