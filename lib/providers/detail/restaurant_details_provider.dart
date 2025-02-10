import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/static/static.dart';

class RestaurantDetailsProvider extends ChangeNotifier {
  RestaurantDetailsProvider(this._apiServices);

  final APIServices _apiServices;

  RestaurantDetailsResultState _resultState = RestaurantDetailsNoneState();

  RestaurantDetailsResultState get resultState => _resultState;

  Future<void> fetchRestaurantDetails(String id) async {
    _updateState(RestaurantDetailsLoadingState());
    try {
      final result = await _apiServices.getRestaurantDetails(id);

      _updateState(result.error
          ? RestaurantDetailsErrorState(result.message)
          : RestaurantDetailsLoadedState(result.restaurant));
    } on DioException catch (dioException) {
      final dioMessage = _apiServices.parseDioException(dioException);
      _updateState(RestaurantDetailsErrorState(dioMessage));
    } catch (e) {
      _updateState(
        RestaurantDetailsErrorState("An unexpected error occurred."),
      );
    }
  }

  void _updateState(RestaurantDetailsResultState state) {
    _resultState = state;
    notifyListeners();
  }
}
