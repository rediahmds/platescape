import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  const CardImage({super.key, required this.pictureUrl});

  final String pictureUrl;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
          minWidth: 80, minHeight: 80, maxWidth: 120, maxHeight: 120),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.network(
          pictureUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
