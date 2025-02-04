import 'package:dio/dio.dart';
import 'package:platescape/data/models/models.dart';

class APIServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/";
  static final _options = BaseOptions(baseUrl: _baseUrl);
  static final _dio = Dio(_options);

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await _dio.get("/list");
    return RestaurantListResponse.fromJson(response.data);
  }

  String getLowResPictureUrl(String pictureId) =>
      "$_baseUrl/images/small/$pictureId";

  String getMediumResPictureUrl(String pictureId) =>
      "$_baseUrl/images/medium/$pictureId";

  String getHighResPictureUrl(String pictureId) =>
      "$_baseUrl/images/large/$pictureId";
}
