import 'package:flutter/material.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/screens/screens.dart';
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
  final _nameTextFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<RestaurantReviewsProvider>()
          .fetchRestaurantReviews(widget.restaurantId);
    });
  }

  @override
  void dispose() {
    _nameTextFieldController.dispose();
    super.dispose();
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
      body: ReviewsScreenBody(
          restaurantId: widget.restaurantId,
          nameController: _nameTextFieldController),
    );
  }
}
