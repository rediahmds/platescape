import 'package:platescape/data/data.dart';

sealed class RestaurantReviewsResultState {}

class RetstaurantReviewsNoneState extends RestaurantReviewsResultState {}

class RestaurantReviewsLoadingState extends RestaurantReviewsResultState {}

class RestaurantReviewsErrorState extends RestaurantReviewsResultState {
  final String error;

  RestaurantReviewsErrorState(this.error);
}

class RestaurantReviewsLoadedState extends RestaurantReviewsResultState {
  final List<CustomerReview> customerReviews;

  RestaurantReviewsLoadedState(this.customerReviews);
}
