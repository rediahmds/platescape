import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:platescape/platescape.dart';
import 'robot/robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Add a restaurant to favorite list", (WidgetTester tester) async {
    const targetRestaurantName = "Melting Pot";
    final robot = EvaluateRobot(tester: tester);
    final prefs = await SharedPreferences.getInstance();

    await robot.loadApp(Platescape(prefs: prefs));

    await robot.checkFavoriteStatus(
      restaurantName: targetRestaurantName,
      isFavorite: false,
    );
    await robot.tapFavoriteButton(
      restaurantName: targetRestaurantName,
    );
    await robot.checkFavoriteStatus(
      restaurantName: targetRestaurantName,
      isFavorite: true,
    );

    await robot.verifyFavoriteInList(
      restaurantName: targetRestaurantName,
    );
  });
}
