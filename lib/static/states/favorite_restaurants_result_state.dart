import 'package:platescape/data/data.dart';

sealed class FavoriteRestaurantsResultState {}

class FavoriteRestaurantsEmptyState extends FavoriteRestaurantsResultState {}

class FavoriteRestaurantsLoadingState extends FavoriteRestaurantsResultState {}

class FavoriteRestaurantsLoadedState extends FavoriteRestaurantsResultState {
  final List<Restaurant> favorites;
  FavoriteRestaurantsLoadedState(this.favorites);
}

class FavoriteRestaurantsErrorState extends FavoriteRestaurantsResultState {
  final String message;
  FavoriteRestaurantsErrorState(this.message);
}
