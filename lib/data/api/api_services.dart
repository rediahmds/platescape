import 'package:dio/dio.dart';
import 'package:platescape/data/models/models.dart';

class APIServices {
  static final _options =
      BaseOptions(baseUrl: "https://restaurant-api.dicoding.dev/");
  static final _dio = Dio(_options);

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await _dio.get("/list");
    return RestaurantListResponse.fromJson(response.data);
  }
}
