import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  const CardImage({
    super.key,
    required this.pictureUrl,
    this.minWidth = 80,
    this.minHeight = 80,
    this.maxWidth = 120,
    this.maxHeight = 120,
    this.borderRadius = 15.0,
    this.aspectRatio = 4 / 3,
  });

  final String pictureUrl;
  final double minWidth;
  final double minHeight;
  final double maxWidth;
  final double maxHeight;
  final double borderRadius;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth,
        minHeight: minHeight,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double height = width / aspectRatio;

            if (height > constraints.maxHeight) {
              height = constraints.maxHeight;
              width = height * aspectRatio;
            }

            return SizedBox(
              width: width,
              height: height,
              child: Image.network(
                pictureUrl,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
