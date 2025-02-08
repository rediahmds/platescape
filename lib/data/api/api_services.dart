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
    final response = await _dio.post("/review", data: payload);
    return RestaurantReviewsResponse.fromJson(response.data);
  }

  String getLowResPictureUrl(String pictureId) =>
      "$_baseUrl/images/small/$pictureId";

  String getMediumResPictureUrl(String pictureId) =>
      "$_baseUrl/images/medium/$pictureId";

  String getHighResPictureUrl(String pictureId) =>
      "$_baseUrl/images/large/$pictureId";
}
