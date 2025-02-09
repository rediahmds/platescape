import 'package:flutter/material.dart';

class RestaurantSearchBar extends StatelessWidget {
  const RestaurantSearchBar({
    super.key,
    required this.searchController,
    required this.onSubmitted,
  });

  final SearchController searchController;
  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SearchBar(
        controller: searchController,
        onSubmitted: onSubmitted,
        shadowColor: WidgetStatePropertyAll<Color>(Colors.transparent),
        hintText: "Search by name, menus, or categories",
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.search_rounded),
        ),
      ),
    );
  }
}
