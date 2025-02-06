import 'package:flutter/material.dart';
import 'package:platescape/provider/platescape_providers.dart';
import 'package:platescape/screens/screens.dart';
import 'package:platescape/static/states/states.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.id});

  final String id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<RestaurantDetailsProvider>()
          .fetchRestaurantDetails(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Ink(
            decoration: ShapeDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              shape: CircleBorder(),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_rounded),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<RestaurantDetailsProvider>(
        builder: (context, restaurantDetailsProvider, child) {
          switch (restaurantDetailsProvider.resultState) {
            case RestaurantDetailsLoadingState():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case RestaurantDetailsLoadedState(data: final restaurantDetails):
              return DetailScreenBody(restaurantDetails: restaurantDetails);
            default:
              return const Center(
                child: Text("An unexpected error occurred"),
              );
          }
        },
      ),
    );
  }
}
