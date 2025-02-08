import 'package:flutter/material.dart';

class ReviewMessageTextfield extends StatelessWidget {
  const ReviewMessageTextfield({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "Write your review",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      maxLines: 6,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Plese write a review";
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
