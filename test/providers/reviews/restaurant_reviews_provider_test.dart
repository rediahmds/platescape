import 'package:mocktail/mocktail.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/static/static.dart';
import 'package:test/test.dart';

class MockAPIServices extends Mock implements APIServices {}

void main() {
  late MockAPIServices apiServices;
  late RestaurantReviewsProvider reviewsProvider;

  setUp(() {
    apiServices = MockAPIServices();
    reviewsProvider = RestaurantReviewsProvider(apiServices);
  });

  group("RestaurantReviewsProvider tests", () {
    test("Should return NoneState type when provider initialized", () {
      final initialState = reviewsProvider.resultState;

      expect(initialState, isA<RetstaurantReviewsNoneState>());
    });
  });
}
