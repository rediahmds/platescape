import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/static/static.dart';
import 'package:test/test.dart';

class MockAPIServices extends Mock implements APIServices {}

void main() {
  late MockAPIServices apiServices;
  late RestaurantReviewsProvider reviewsProvider;

  const mockRestaurantId = "resto-test";
  final mockPayload = RestaurantReviewsPayload(
    id: mockRestaurantId,
    name: "Toni Kroos",
    review: "Delicious!",
  );

  final mockReviewVini = CustomerReview(
    name: "Vini Jr.",
    review: "Wenak tenan",
    date: "17 Agustus 2021",
  );

  setUp(() {
    apiServices = MockAPIServices();
    reviewsProvider = RestaurantReviewsProvider(apiServices);
  });

  group("RestaurantReviewsProvider test", () {
    test("Should return NoneState type when provider initialized", () {
      final initialState = reviewsProvider.resultState;

      expect(initialState, isA<RetstaurantReviewsNoneState>());
    });
  });

  group("fetchRestaurantReviews test", () {
    test("Should load reviews successfully", () async {
      final mockReviews = [
        mockReviewVini,
      ];

      when(() => apiServices.getRestaurantReviews(mockRestaurantId))
          .thenAnswer((_) async => mockReviews);

      await reviewsProvider.fetchRestaurantReviews(mockRestaurantId);

      final resultState = reviewsProvider.resultState;
      expect(resultState, isA<RestaurantReviewsLoadedState>());

      final loadedState = resultState as RestaurantReviewsLoadedState;
      expect(loadedState.customerReviews, mockReviews);

      verify(() => apiServices.getRestaurantReviews(mockRestaurantId))
          .called(1);
    });

    test("Should handle DioException when failed to fetch from the API",
        () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: "/detail/$mockRestaurantId"),
        type: DioExceptionType.connectionError,
      );
      final parsedMessage = "No internet connection";

      when(() => apiServices.getRestaurantReviews(mockRestaurantId))
          .thenThrow(dioException);
      when(() => apiServices.parseDioException(dioException))
          .thenReturn(parsedMessage);

      await reviewsProvider.fetchRestaurantReviews(mockRestaurantId);

      final resultState = reviewsProvider.resultState;
      expect(resultState, isA<RestaurantReviewsErrorState>());

      final errorState = resultState as RestaurantReviewsErrorState;
      expect(errorState.error, parsedMessage);

      verify(() => apiServices.getRestaurantReviews(mockRestaurantId))
          .called(1);
      verify(() => apiServices.parseDioException(dioException)).called(1);
    });
  });

  group("addRestaurantReview test", () {
    test("Should POST review successfully and update provider state", () async {
      final mockResponse = RestaurantReviewsResponse(
        error: false,
        message: "success",
        customerReviews: [
          mockReviewVini,
        ],
      );

      when(() => apiServices.postRestaurantReview(mockPayload))
          .thenAnswer((_) async => mockResponse);

      await reviewsProvider.addRestaurantReview(mockPayload);

      final resultState = reviewsProvider.resultState;
      expect(resultState, isA<RestaurantReviewsLoadedState>());

      final loadedState = resultState as RestaurantReviewsLoadedState;
      expect(loadedState.customerReviews, mockResponse.customerReviews);

      verify(() => apiServices.postRestaurantReview(mockPayload)).called(1);
    });

    test("Should handle DioException during POST", () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: "/review"),
        type: DioExceptionType.badResponse,
      );
      final badPayload = RestaurantReviewsPayload(
        id: mockRestaurantId,
        name: "Toni Kroos",
        review: "",
      );
      final parsedMessage = "Bad request. Review cannot be empty";

      when(() => apiServices.postRestaurantReview(badPayload))
          .thenThrow(dioException);
      when(() => apiServices.parseDioException(dioException))
          .thenReturn(parsedMessage);

      await reviewsProvider.addRestaurantReview(badPayload);

      final resultState = reviewsProvider.resultState;
      expect(resultState, isA<RestaurantReviewsErrorState>());

      final errorState = resultState as RestaurantReviewsErrorState;
      expect(errorState.error, parsedMessage);

      verify(() => apiServices.postRestaurantReview(badPayload)).called(1);
      verify(() => apiServices.parseDioException(dioException)).called(1);
    });
  });
}
