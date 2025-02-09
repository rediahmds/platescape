sealed class ReviewTextFieldState {}

class ReviewTextFieldEmptyState extends ReviewTextFieldState {}

class ReviewTextFieldValidState extends ReviewTextFieldState {
  final String review;
  ReviewTextFieldValidState(this.review);
}
