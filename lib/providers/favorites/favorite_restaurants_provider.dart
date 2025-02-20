import 'package:flutter/widgets.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/static/static.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteRestaurantsProvider extends ChangeNotifier {
  FavoriteRestaurantsProvider(this._repository);
  final FavoriteRestaurantRepository _repository;

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
        _updateState(FavoriteRestaurantsLoadedState(favorites));
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

  // Future<void> toggleFavorite(Restaurant restaurant) async {
  //   debugPrint("DEBUG: Toggling fav");
  //   try {
  //     final isFavorite = await _repository.isFavorite(restaurant.id);

  //     if (!isFavorite) {
  //       await _repository.addFavorite(restaurant);
  //       debugPrint("DEBUG: Adding fav");
  //     } else {
  //       await _repository.removeFavorite(restaurant.id);
  //       debugPrint("DEBUG: Removing fav");
  //     }
  //     await loadFavorites();
  //   } on DatabaseException catch (dbException) {
  //     final message = "Failed to toggle favorite status.";
  //     _updateState(FavoriteRestaurantsErrorState(message));
  //     debugPrint(dbException.getResultCode().toString()); // TODO: Remove
  //   } catch (e) {
  //     final message =
  //         "An unexpected error occurred while toggling favorite status.";
  //     _updateState(FavoriteRestaurantsErrorState(message));
  //   }
  // }

  Future<bool> isFavorite(String id) async {
    final isFav = await _repository.isFavorite(id);
    return isFav;
  }

  void _updateState(FavoriteRestaurantsResultState state) {
    _resultState = state;
    notifyListeners();
  }
}
