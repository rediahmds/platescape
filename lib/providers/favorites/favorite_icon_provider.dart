import 'package:flutter/widgets.dart';
import 'package:platescape/static/static.dart';
import 'package:platescape/data/data.dart';
// import 'package:sqflite/sqflite.dart';

class FavoriteIconProvider extends ChangeNotifier {
  FavoriteIconProvider(this._repository);
  final FavoriteRestaurantRepository _repository;
  FavoriteButtonState _state = FavoriteInitialState();
  FavoriteButtonState get state => _state;

  Future<void> toggleFavorite(Restaurant restaurant) async {
    debugPrint("DEBUG: Toggling fav");
    // try {
    final isFavorite = await _repository.isFavorite(restaurant.id);

    if (!isFavorite) {
      await _repository.addFavorite(restaurant);
      debugPrint("DEBUG: Adding fav");
      _updateState(FavoriteAddedState());
    } else {
      await _repository.removeFavorite(restaurant.id);
      debugPrint("DEBUG: Removing fav");
      _updateState(FavoriteRemovedState());
    }
    // await loadFavorites();
    // } on DatabaseException catch (dbException) {
    //   final message = "Failed to toggle favorite status.";
    //   _updateState(FavoriteRestaurantsErrorState(message));
    //   debugPrint(dbException.getResultCode().toString()); // TODO: Remove
    // } catch (e) {
    //   final message =
    //       "An unexpected error occurred while toggling favorite status.";
    //   _updateState(FavoriteRestaurantsErrorState(message));
    // }
  }

  set setFavorite(bool isFavorite) {
    if (isFavorite) {
      _updateState(FavoriteAddedState());
    } else {
      _updateState(FavoriteRemovedState());
    }
  }

  void _updateState(FavoriteButtonState state) {
    _state = state;
    notifyListeners();
  }
}
