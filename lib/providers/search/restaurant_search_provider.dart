import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/static/static.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  RestaurantSearchProvider(this._apiServices);
  final APIServices _apiServices;

  final SearchController _searchController = SearchController();
  SearchController get searchController => _searchController;

  RestaurantSearchResultState _resultState = RestaurantSearchEmptyState();
  RestaurantSearchResultState get resultState => _resultState;

  Future<void> searchRestaurant(String query) async {
    _updateState(RestaurantSearchLoadingState());
    try {
      final result = await _apiServices.searchRestaurant(query);
      _updateState(
        result.founded == 0
            ? RestaurantSearchNotFoundState()
            : RestaurantSearchLoadedState(result.restaurants),
      );
    } on DioException catch (dioException) {
      _updateState(
        RestaurantSearchErrorState(
            dioException.message ?? "An unexpected error occured"),
      );
    }
  }

  void _updateState(RestaurantSearchResultState state) {
    _resultState = state;
    notifyListeners();
  }
}
