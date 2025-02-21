import 'package:flutter/widgets.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/static/static.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteRestaurantsProvider extends ChangeNotifier {
  FavoriteRestaurantsProvider(this._repository);
  final FavoriteRestaurantRepository _repository;

  List<Restaurant> _favoritesList = [];
  List<Restaurant> get favoritesList => _favoritesList;

  FavoriteRestaurantsResultState _resultState =
      FavoriteRestaurantsLoadingState();

  FavoriteRestaurantsResultState get resultState => _resultState;

  Future<void> loadFavorites() async {
    _updateState(FavoriteRestaurantsLoadingState());

    try {
      final favorites = await _repository.getAllFavorites();

      if (favorites.isEmpty) {
        _updateState(FavoriteRestaurantsEmptyState());
      } else {
        _favoritesList = favorites;
        _updateState(FavoriteRestaurantsLoadedState(_favoritesList));
      }
    } on DatabaseException catch (dbException) {
      final message =
          "Failed to load favorites list. ${dbException.getResultCode()}";

      _updateState(FavoriteRestaurantsErrorState(message));
    } catch (e) {
      final message =
          "An unexpected error occurred while loading favorites list.";
      _updateState(FavoriteRestaurantsErrorState(message));
    }
  }

  Future<void> addFavorite(Restaurant restaurant) async {
    try {
      await _repository.addFavorite(restaurant);
      loadFavorites();
    } on DatabaseException catch (dbException) {
      final message =
          "Failed adding to favorites list. ${dbException.getResultCode()}";

      _updateState(FavoriteRestaurantsErrorState(message));
    } catch (e) {
      final message =
          "An unexpected error occurred while adding to favorites list.";

      _updateState(FavoriteRestaurantsErrorState(message));
    }
  }

  Future<void> removeFavorite(String id) async {
    try {
      await _repository.removeFavorite(id);
      loadFavorites();
    } on DatabaseException catch (dbException) {
      final message =
          "Failed while removing from favorites list. ${dbException.getResultCode()}";

      _updateState(FavoriteRestaurantsErrorState(message));
    } catch (e) {
      final message =
          "An unexpected error occurred while removing from favorites list.";

      _updateState(FavoriteRestaurantsErrorState(message));
    }
  }

  Future<bool> isFavorite(String id) async {
    final isFav = await _repository.isFavorite(id);
    return isFav;
  }

  void _updateState(FavoriteRestaurantsResultState state) {
    _resultState = state;
    notifyListeners();
  }
}
