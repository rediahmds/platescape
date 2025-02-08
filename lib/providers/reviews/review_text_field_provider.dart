import 'package:flutter/material.dart';
import 'package:platescape/static/static.dart';

class ReviewTextFieldProvider extends ChangeNotifier {
  ReviewTextFieldProvider() {
    _reviewMessageController.addListener(_validate);
  }

  final TextEditingController _reviewMessageController =
      TextEditingController();
  TextEditingController get reviewMessageController => _reviewMessageController;

  ReviewTextFieldState _reviewTextFieldState = ReviewTextFieldEmptyState();
  ReviewTextFieldState get reviewTextFieldState => _reviewTextFieldState;

  void _validate() {
    final String reviewMessage = _reviewMessageController.text;

    if (reviewMessage.isNotEmpty) {
      _updateState(ReviewTextFieldValidState(reviewMessage));
    } else {
      _updateState(ReviewTextFieldEmptyState());
    }
  }

  void _updateState(ReviewTextFieldState state) {
    _reviewTextFieldState = state;
    notifyListeners();
  }

  void clear() {
    _reviewMessageController.clear();
    _updateState(ReviewTextFieldEmptyState());
  }

  @override
  void dispose() {
    _reviewMessageController.dispose();
    super.dispose();
  }
}
