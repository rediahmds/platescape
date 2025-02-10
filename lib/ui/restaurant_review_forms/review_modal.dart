import 'package:flutter/material.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:platescape/ui/ui.dart';

void showReviewModal(BuildContext context, String restaurantId) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (context) {
      return Consumer<ReviewTextFieldProvider>(
        builder: (context, reviewTextFieldProvider, child) {
          final nameController = reviewTextFieldProvider.nameController;
          final reviewController =
              reviewTextFieldProvider.reviewMessageController;

          return RestaurantReviewForm(
            nameTextFieldController: nameController,
            reviewMessageTextFieldController: reviewController,
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Sending review...")),
              );

              final name = nameController.text.isEmpty
                  ? "Platescape User"
                  : nameController.text;

              final reviewMessage = reviewController.text;

              final payload = RestaurantReviewsPayload(
                id: restaurantId,
                name: name,
                review: reviewMessage,
              );

              await context
                  .read<RestaurantReviewsProvider>()
                  .addRestaurantReview(payload);

              reviewTextFieldProvider.clear();
              Navigator.pop(context);
            },
          );
        },
      );
    },
  );
}
