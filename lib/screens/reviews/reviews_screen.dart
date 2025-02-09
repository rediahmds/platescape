import 'package:flutter/material.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/screens/screens.dart';
import 'package:platescape/static/static.dart';
import 'package:provider/provider.dart';
import 'package:platescape/ui/ui.dart';

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
  final _reviewMessageTextFieldController = TextEditingController();

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
    _reviewMessageTextFieldController.dispose();
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
      body: Consumer<RestaurantReviewsProvider>(
        builder: (context, restaurantReviewsProvider, child) {
          switch (restaurantReviewsProvider.resultState) {
            case RestaurantReviewsLoadingState():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case RestaurantReviewsLoadedState(
                customerReviews: final customerReviews
              ):
              return Stack(
                children: [
                  ReviewsScreenBody(reviews: customerReviews),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: FilledButton.icon(
                      onPressed: () {
                        _reviewModalSheet(context);
                      },
                      icon: const Icon(Icons.rate_review_rounded),
                      label: const Text("Add Review"),
                      iconAlignment: IconAlignment.end,
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

  Future<dynamic> _reviewModalSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      builder: (context) {
        return Consumer<ReviewTextFieldProvider>(
          builder: (context, reviewTextFieldProvider, child) {
            return RestaurantReviewForm(
              nameTextFieldController: _nameTextFieldController,
              reviewMessageTextFieldController:
                  reviewTextFieldProvider.reviewMessageController,
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Sending review..."),
                  ),
                );
                final name = _nameTextFieldController.text.isEmpty
                    ? "Platescape User"
                    : _nameTextFieldController.text;
                final reviewMessage =
                    reviewTextFieldProvider.reviewMessageController.text;
                final id = widget.restaurantId;
                final payload = RestaurantReviewsPayload(
                  id: id,
                  name: name,
                  review: reviewMessage,
                );

                await context
                    .read<RestaurantReviewsProvider>()
                    .addRestaurantReview(payload);

                _nameTextFieldController.clear();
                reviewTextFieldProvider.clear();

                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
