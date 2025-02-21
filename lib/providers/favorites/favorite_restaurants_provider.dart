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
    debugPrint("DEBUG: Loading fav");
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
      final message = "Failed to load favorites list.";
      _updateState(FavoriteRestaurantsErrorState(message));
      debugPrint(
          dbException.getResultCode().toString()); // TODO: REMOVE ON PRODUCTION
    } catch (e) {
      final message =
          "An unexpected error occurred while loading favorites list.";
      _updateState(FavoriteRestaurantsErrorState(message));
    }
  }

  Future<void> addFavorite(Restaurant restaurant) async {
    await _repository.addFavorite(restaurant);
    loadFavorites();
  }

  Future<void> removeFavorite(String id) async {
    await _repository.removeFavorite(id);
    loadFavorites();
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
