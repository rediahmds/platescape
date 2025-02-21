import 'package:flutter/widgets.dart';
import 'package:platescape/static/static.dart';

class NavigationBarProvider extends ChangeNotifier {
  NavigationBarState _currentState = HomeState();
  NavigationBarState get currentState => _currentState;

  void updateState(NavigationBarState state) {
    _currentState = state;
    notifyListeners();
  }

  int getIndex(NavigationBarState state) {
    return switch (state) {
      HomeState() => 0,
      FavoritesState() => 1,
      _ => 2,
    };
  }

  NavigationBarState getNavigationBarState(int index) {
    return switch (index) {
      0 => HomeState(),
      1 => FavoritesState(),
      _ => SettingsState(),
    };
  }
}
