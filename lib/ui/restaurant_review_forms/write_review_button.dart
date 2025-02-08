import 'package:flutter/material.dart';

class WriteReviewButton extends StatelessWidget {
  const WriteReviewButton({
    super.key,
    required this.onPressed,
    this.labelText = "Write a review",
  });

  final Function() onPressed;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      label: Text(labelText),
      icon: const Icon(Icons.rate_review_rounded),
      iconAlignment: IconAlignment.end,
    );
  }
}
