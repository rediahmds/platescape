import 'package:flutter/material.dart';

class SendReviewButton extends StatelessWidget {
  const SendReviewButton({
    super.key,
    required this.onPressed,
    required this.reviewMessage,
  });
  final Function() onPressed;
  final String reviewMessage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: FilledButton.icon(
        onPressed: reviewMessage.isNotEmpty ? onPressed : null,
        label: const Text("Submit"),
        icon: const Icon(Icons.send_rounded),
        iconAlignment: IconAlignment.end,
      ),
    );
  }
}
