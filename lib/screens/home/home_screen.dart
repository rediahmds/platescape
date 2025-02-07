import 'package:flutter/material.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/static/static.dart';
import 'package:platescape/ui/ui.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Platescape",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<RestaurantListProvider>(
        builder: (context, restaurantListProvider, child) {
          switch (restaurantListProvider.resultState) {
            case RestaurantListLoadingState():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case RestaurantListLoadedState(data: final restaurantList):
              return RestaurantListView(restaurantList: restaurantList);
            default:
              return Center(
                child: Text(
                  "An unexpected error occurred",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              );
          }
        },
      ),
    );
  }
}
