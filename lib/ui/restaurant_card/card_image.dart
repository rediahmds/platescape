import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  const CardImage(
      {super.key,
      required this.pictureUrl,
      this.minWidth = 80,
      this.minHeight = 80,
      this.maxHeight = 120,
      this.maxWidth = 120,
      this.borderRadius = 15.0});

  final String pictureUrl;
  final double minWidth;
  final double minHeight;
  final double maxWidth;
  final double maxHeight;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: minWidth,
          minHeight: minHeight,
          maxWidth: maxWidth,
          maxHeight: maxHeight),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.network(
          pictureUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
