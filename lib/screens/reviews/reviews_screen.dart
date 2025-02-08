import 'package:flutter/material.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/screens/screens.dart';
import 'package:platescape/static/static.dart';
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
          .read<RestaurantReviewsProvider>()
          .fetchRestaurantReviews(widget.restaurantId);
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
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          showDragHandle: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16.0),
                            ),
                          ),
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 16,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                        16,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Write a Review",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 16),
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: "Your Name",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: "Your Review",
                                      border: OutlineInputBorder(),
                                    ),
                                    maxLines: 6,
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: FilledButton.icon(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      label: const Text("Submit"),
                                      icon: Icon(Icons.send_rounded),
                                      iconAlignment: IconAlignment.end,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
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
}
