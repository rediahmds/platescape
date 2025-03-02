import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/static/static.dart';
import 'package:test/test.dart';

class MockAPIServices extends Mock implements APIServices {}

void main() {
  late MockAPIServices apiServices;
  late RestaurantDetailsProvider restaurantDetailsProvider;

  setUp(() {
    apiServices = MockAPIServices();
    restaurantDetailsProvider = RestaurantDetailsProvider(apiServices);
  });

  group("RestaurantDetailsProvider tests", () {
    test("Should have NoneState type when provider initialized", () {
      final initialState = restaurantDetailsProvider.resultState;

      expect(initialState, isA<RestaurantDetailsNoneState>());
    });

    test(
        "Should have LoadedState type and RestaurantDetails data when successfully fetch data from the API",
        () async {
      final id = "1";
      final mockRestaurantDetails = RestaurantDetails(
        id: id,
        name: "Dart Seafood",
        description: "Enjoy menus from Dart Seafood",
        city: "Pangandaran",
        address: "Pangandaran, Pangandaran",
        pictureId: id,
        categories: [
          Category(name: "Seafood"),
        ],
        menus: Menus(
          foods: [
            Category(name: "Udang"),
            Category(name: "Sosis"),
          ],
          drinks: [
            Category(name: "Es teh"),
            Category(name: "Es kelapa muda"),
          ],
        ),
        rating: 4.5,
        customerReviews: [
          CustomerReview(
            name: "Kroos",
            review: "Umpan yang sangat mantap",
            date: "2021-08-03",
          )
        ],
      );

      final mockResponse = RestaurantDetailsResponse(
        error: false,
        message: "success",
        restaurant: mockRestaurantDetails,
      );

      when(() => apiServices.getRestaurantDetails(id))
          .thenAnswer((_) async => mockResponse);

      await restaurantDetailsProvider.fetchRestaurantDetails(id);

      final resultState = restaurantDetailsProvider.resultState;
      expect(resultState, isA<RestaurantDetailsLoadedState>());

      final loadedState = resultState as RestaurantDetailsLoadedState;
      expect(loadedState.data, mockRestaurantDetails);

      verify(() => apiServices.getRestaurantDetails(id)).called(1);
    });

    test("Should return ErrorState type when API response contains an error",
        () async {
      final notFoundId = "notfound";
      final mockResponse = RestaurantDetailsResponse(
        error: true,
        message: "Restaurant not found",
        restaurant: RestaurantDetails(
          id: "",
          name: "",
          description: "",
          city: "",
          address: "",
          pictureId: "",
          categories: [],
          menus: Menus(foods: [], drinks: []),
          rating: 0,
          customerReviews: [],
        ),
      );

      when(() => apiServices.getRestaurantDetails(notFoundId))
          .thenAnswer((_) async => mockResponse);

      await restaurantDetailsProvider.fetchRestaurantDetails(notFoundId);

      final resultState = restaurantDetailsProvider.resultState;
      expect(resultState, isA<RestaurantDetailsErrorState>());

      final errorState = resultState as RestaurantDetailsErrorState;
      expect(errorState.error, mockResponse.message);

      verify(() => apiServices.getRestaurantDetails(notFoundId)).called(1);
    });

    test("Should handle DioException and use the parsed error message",
        () async {
      final id = "errorid";
      final dioBadResponseError = DioException(
        requestOptions: RequestOptions(path: "/detail/$id"),
        type: DioExceptionType.badResponse,
      );
      final mockParsedMessage = "Bad response from the server";

      when(() => apiServices.getRestaurantDetails(id))
          .thenThrow(dioBadResponseError);
      when(() => apiServices.parseDioException(dioBadResponseError))
          .thenReturn(mockParsedMessage);

      await restaurantDetailsProvider.fetchRestaurantDetails(id);

      final resultState = restaurantDetailsProvider.resultState;
      expect(resultState, isA<RestaurantDetailsErrorState>());

      final errorState = resultState as RestaurantDetailsErrorState;
      expect(errorState.error, mockParsedMessage);

      verify(() => apiServices.getRestaurantDetails(id)).called(1);
      verify(() => apiServices.parseDioException(dioBadResponseError))
          .called(1);
    });
  });
}
