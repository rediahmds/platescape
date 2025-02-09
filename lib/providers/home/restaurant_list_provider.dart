import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/static/static.dart';

class RestaurantListProvider extends ChangeNotifier {
  RestaurantListProvider(this._apiServices);

  final APIServices _apiServices;

  RestaurantListResultState _resultState = RestaurantListNoneState();

  RestaurantListResultState get resultState => _resultState;

  Future<void> fetchRestaurantList() async {
    _updateState(RestaurantListLoadingState());
    try {
      final result = await _apiServices.getRestaurantList();

      _updateState(result.error
          ? RestaurantListErrorState(result.message)
          : RestaurantListLoadedState(result.restaurants));
    } on DioException catch (dioException) {
      _updateState(RestaurantListErrorState(
          dioException.message ?? "An unexpected error occurred"));
    }
  }

  void _updateState(RestaurantListResultState state) {
    _resultState = state;
    notifyListeners();
  }
}
