import 'package:platescape/data/data.dart';

class RestaurantReviewsResponse {
  final bool error;
  final String message;
  final List<CustomerReview> customerReviews;

  RestaurantReviewsResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });
  factory RestaurantReviewsResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantReviewsResponse(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );
}
