import 'package:flutter/material.dart';

class SendReviewButton extends StatelessWidget {
  const SendReviewButton({
    super.key,
    required this.onPressed,
  });
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: FilledButton.icon(
        onPressed: onPressed,
        label: const Text("Submit"),
        icon: const Icon(Icons.send_rounded),
        iconAlignment: IconAlignment.end,
      ),
    );
  }
}
