import 'package:flutter/material.dart';
import 'package:platescape/providers/providers.dart';
import 'package:provider/provider.dart';

class SearchNotFoundScreen extends StatelessWidget {
  const SearchNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("No restaurant found with the given query"),
          const SizedBox.square(dimension: 16),
          FilledButton.tonalIcon(
            onPressed: () {
              final searchProvider = context.read<RestaurantSearchProvider>();

              searchProvider.searchController.clear();
              searchProvider.resetSearch();
            },
            label: const Text("Back to home"),
            icon: Icon(Icons.arrow_back_rounded),
          )
        ],
      ),
    );
  }
}
