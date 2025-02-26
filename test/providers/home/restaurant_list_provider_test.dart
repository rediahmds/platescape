import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/static/static.dart';
import 'package:test/test.dart';

class MockAPIServices extends Mock implements APIServices {}

void main() {
  late MockAPIServices apiService;
  late RestaurantListProvider restaurantListProvider;

  setUp(() {
    apiService = MockAPIServices();
    restaurantListProvider = RestaurantListProvider(apiService);
  });

  group("RestaurantListProvider tests", () {
    test("Should return NoneState type when provider initialized", () {
      final initialState = restaurantListProvider.resultState;

      expect(initialState, isA<RestaurantListNoneState>());
    });

    test(
        "Should return LoadedState type and have RestaurantList data when successfully fetch from API",
        () async {
      final mockRestaurantsResponse = RestaurantListResponse(
        error: false,
        message: "success",
        count: 1,
        restaurants: [
          Restaurant(
            id: "1",
            name: "C++ Resto",
            description: "Yummy C++ foods and drinks",
            pictureId: "pic1",
            city: "Silicon Valley",
            rating: 4.9,
          ),
        ],
      );

      when(() => apiService.getRestaurantList())
          .thenAnswer((_) async => mockRestaurantsResponse);

      await restaurantListProvider.fetchRestaurantList();

      final resultState = restaurantListProvider.resultState;
      expect(resultState, isA<RestaurantListLoadedState>());

      final loadedState = resultState as RestaurantListLoadedState;
      expect(loadedState.data, mockRestaurantsResponse.restaurants);

      verify(() => apiService.getRestaurantList()).called(1);
    });

    test("Should return ErrorState type when API response contains an error",
        () async {
      final mockResponse = RestaurantListResponse(
        error: true,
        message: "Server Error",
        count: 0,
        restaurants: [],
      );

      when(() => apiService.getRestaurantList())
          .thenAnswer((_) async => mockResponse);

      await restaurantListProvider.fetchRestaurantList();

      final resultState = restaurantListProvider.resultState;
      expect(resultState, isA<RestaurantListErrorState>());

      final errorState = resultState as RestaurantListErrorState;
      expect(errorState.error, mockResponse.message);

      verify(() => apiService.getRestaurantList()).called(1);
    });

    test("Should handle DioException and use the parsed error message",
        () async {
      final dioTimeoutError = DioException(
        requestOptions: RequestOptions(path: "/list"),
        type: DioExceptionType.connectionTimeout,
      );
      final mockParsedMessage = "Connection timeout";

      when(() => apiService.getRestaurantList()).thenThrow(dioTimeoutError);
      when(() => apiService.parseDioException(dioTimeoutError))
          .thenReturn(mockParsedMessage);

      await restaurantListProvider.fetchRestaurantList();

      final resultState = restaurantListProvider.resultState;
      expect(resultState, isA<RestaurantListErrorState>());

      final errorState = resultState as RestaurantListErrorState;
      expect(errorState.error, mockParsedMessage);

      verify(() => apiService.getRestaurantList()).called(1);
      verify(() => apiService.parseDioException(dioTimeoutError)).called(1);
    });
  });
}
