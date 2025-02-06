import 'detail.dart';

class RestaurantDetailsResponse {
  final bool error;
  final String message;
  final RestaurantDetails restaurant;

  RestaurantDetailsResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailsResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailsResponse(
        error: json["error"],
        message: json["message"],
        restaurant: RestaurantDetails.fromJson(json["restaurant"]),
      );
}
