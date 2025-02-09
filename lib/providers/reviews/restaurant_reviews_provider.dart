import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/static/static.dart';

class RestaurantReviewsProvider extends ChangeNotifier {
  RestaurantReviewsProvider(this._apiServices);

  final APIServices _apiServices;

  RestaurantReviewsResultState _resultState = RetstaurantReviewsNoneState();

  RestaurantReviewsResultState get resultState => _resultState;

  Future<void> fetchRestaurantReviews(String restaurantId) async {
    _updateState(RestaurantReviewsLoadingState());
    try {
      final result = await _apiServices.getRestaurantReviews(restaurantId);
      _updateState(RestaurantReviewsLoadedState(result));
    } on DioException catch (dioException) {
      if (dioException.response != null) {
        _updateState(RestaurantReviewsErrorState(
            dioException.response!.statusMessage ??
                "An unexpected error occured"));
      } else {
        _updateState(RestaurantReviewsErrorState(
            dioException.message ?? "An unexpected error occurred"));
      }
    }
  }

  Future<void> addRestaurantReview(RestaurantReviewsPayload payload) async {
    _updateState(RestaurantReviewsLoadingState());
    try {
      final result = await _apiServices.postRestaurantReview(payload);
      _updateState(RestaurantReviewsLoadedState(result.customerReviews));
    } on DioException catch (dioException) {
      if (dioException.response != null) {
        _updateState(RestaurantReviewsErrorState(
            dioException.response!.statusMessage ??
                "An unexpected error occured"));
      } else {
        _updateState(RestaurantReviewsErrorState(
            dioException.message ?? "An unexpected error occurred"));
      }
    }
  }

  void _updateState(RestaurantReviewsResultState state) {
    _resultState = state;
    notifyListeners();
  }
}
