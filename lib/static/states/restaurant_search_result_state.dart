import 'package:platescape/data/data.dart';

sealed class RestaurantSearchResultState {}

class RestaurantSearchEmptyState extends RestaurantSearchResultState {}

class RestaurantSearchLoadingState extends RestaurantSearchResultState {}

class RestaurantSearchLoadedState extends RestaurantSearchResultState {
  RestaurantSearchLoadedState(this.restaurantList);
  final List<Restaurant> restaurantList;
}

class RestaurantSearchNotFoundState extends RestaurantSearchResultState {}

class RestaurantSearchErrorState extends RestaurantSearchResultState {
  RestaurantSearchErrorState(this.error);
  final String error;
}
