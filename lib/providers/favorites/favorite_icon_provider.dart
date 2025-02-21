import 'package:flutter/widgets.dart';
import 'package:platescape/static/static.dart';

class FavoriteIconProvider extends ChangeNotifier {
  final Map<String, FavoriteButtonState> _favoritesState = {};

  FavoriteButtonState getState(String id) {
    return _favoritesState[id] ?? FavoriteInitialState();
  }

  void initializeFavoriteStatus(String id, bool isFavorite) {
    _favoritesState[id] =
        isFavorite ? FavoriteAddedState() : FavoriteRemovedState();
    notifyListeners();
  }

  void updateState(String id, bool isFavorite) {
    _favoritesState[id] =
        isFavorite ? FavoriteAddedState() : FavoriteRemovedState();
    notifyListeners();
  }
}
