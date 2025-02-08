import 'package:flutter/material.dart';
import 'package:platescape/ui/ui.dart';

class RestaurantReviewForm extends StatelessWidget {
  const RestaurantReviewForm({
    super.key,
    required this.nameTextFieldController,
    required this.reviewMessageTextFieldController,
    required this.onPressed,
  });

  final TextEditingController nameTextFieldController;
  final TextEditingController reviewMessageTextFieldController;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Write a Review",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          NameTextField(controller: nameTextFieldController),
          const SizedBox(height: 16),
          ReviewMessageTextfield(controller: reviewMessageTextFieldController),
          const SizedBox(height: 16),
          SendReviewButton(
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
