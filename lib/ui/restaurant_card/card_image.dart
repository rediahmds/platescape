import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  const CardImage({
    super.key,
    required this.pictureUrl,
    this.width = 120,
    this.height = 90,
    this.borderRadius = 15.0,
  });

  final String pictureUrl;
  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: AspectRatio(
          aspectRatio: width / height, // Ensures a uniform aspect ratio
          child: Image.network(
            pictureUrl,
            fit: BoxFit.cover, // Crops the image to fill the box
          ),
        ),
      ),
    );
  }
}
