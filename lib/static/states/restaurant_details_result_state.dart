import 'package:platescape/data/models/models.dart';

sealed class RestaurantDetailsResultState {}

class RestaurantDetailsNoneState extends RestaurantDetailsResultState {}

class RestaurantDetailsLoadingState extends RestaurantDetailsResultState {}

class RestaurantDetailsErrorState extends RestaurantDetailsResultState {
  final String error;

  RestaurantDetailsErrorState(this.error);
}

class RestaurantDetailsLoadedState extends RestaurantDetailsResultState {
  final RestaurantDetails data;

  RestaurantDetailsLoadedState(this.data);
}
