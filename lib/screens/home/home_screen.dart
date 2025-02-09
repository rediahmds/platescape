import 'package:flutter/material.dart';
import 'package:platescape/data/models/list/restaurant.dart';
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
              return Consumer<RestaurantSearchProvider>(
                builder: (context, searchProvider, child) {

                  switch (searchProvider.resultState) {
                    case RestaurantSearchLoadingState():
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case RestaurantSearchNotFoundState():
                      return const Center(
                        child: Text("No restaurant found with the given query"),
                      );
                    case RestaurantSearchLoadedState(
                        restaurantList: final searchResult
                      ):
                      return NewWidget(
                        restaurantList: searchResult,
                        searchController: searchProvider.searchController,
                        onSubmitted: (_) async {
                          await searchProvider.searchRestaurant(
                            searchProvider.searchController.text,
                          );
                          // searchController.clear();
                        },
                      );
                    default:
                      return NewWidget(
                        restaurantList: restaurantList,
                        searchController: searchProvider.searchController,
                        onSubmitted: (_) async {
                          await searchProvider.searchRestaurant(
                              searchProvider.searchController.text);
                        },
                      );
                  }
                },
              );
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

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.restaurantList,
    required this.searchController,
    required this.onSubmitted,
  });

  final List<Restaurant> restaurantList;
  final SearchController searchController;
  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RestaurantSearchBar(
          searchController: searchController,
          onSubmitted: onSubmitted,
        ),
        Expanded(
          child: RestaurantListView(restaurantList: restaurantList),
        ),
      ],
    );
  }
}
