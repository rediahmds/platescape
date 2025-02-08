import 'package:flutter/material.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "Your Name (Optional)",
        hintText: "e.g. Toni Kroos",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}
