import 'package:dio/dio.dart';
import 'package:platescape/data/data.dart';

class APIServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";
  static final _options = BaseOptions(baseUrl: _baseUrl);
  static final _dio = Dio(_options);

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await _dio.get("/list");
    return RestaurantListResponse.fromJson(response.data);
  }

  Future<RestaurantDetailsResponse> getRestaurantDetails(String id) async {
    final response = await _dio.get("/detail/$id");
    return RestaurantDetailsResponse.fromJson(response.data);
  }

  Future<List<CustomerReview>> getRestaurantReviews(String id) async {
    final response = await getRestaurantDetails(id);
    return response.restaurant.customerReviews;
  }

  Future<RestaurantReviewsResponse> postRestaurantReview(
      RestaurantReviewsPayload payload) async {
    final response = await _dio.post("/review", data: payload.toJson());
    return RestaurantReviewsResponse.fromJson(response.data);
  }

  Future<RestaurantSearchResponse> searchRestaurant(String query) async {
    final response = await _dio.get("/search", queryParameters: {"q": query});
    return RestaurantSearchResponse.fromJson(response.data);
  }

  String getLowResPictureUrl(String pictureId) =>
      "$_baseUrl/images/small/$pictureId";

  String getMediumResPictureUrl(String pictureId) =>
      "$_baseUrl/images/medium/$pictureId";

  String getHighResPictureUrl(String pictureId) =>
      "$_baseUrl/images/large/$pictureId";

  String parseDioException(DioException dioException) {
    switch (dioException.type) {
      case DioException.connectionTimeout:
      case DioException.receiveTimeout:
      case DioException.sendTimeout:
        return "Connection timeout. Please try again.";

      case DioException.badResponse:
        final statusCode = dioException.response?.statusCode;
        if (statusCode != null) {
          return "Server error ($statusCode). Please try again later.";
        }

        return "Received invalid response from the server.";

      case DioException.requestCancelled:
        return "Request cancelled.";

      case DioException.connectionError:
        return "No internet connection. Please check your network.";

      default:
        return "Unexpected HTTP error occurred. Please try again later.";
    }
  }
}
