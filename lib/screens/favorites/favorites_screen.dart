import 'package:flutter/material.dart';
import 'package:platescape/screens/screens.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Restaurants"),
        centerTitle: true,
      ),
      body: FavoritesScreenBody(),
    );
  }
}
