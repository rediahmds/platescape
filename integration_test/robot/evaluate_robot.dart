import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class EvaluateRobot {
  const EvaluateRobot({
    required this.tester,
  });

  final WidgetTester tester;

  final meltingPotFavKey = const ValueKey("Melting Pot");
  final kafeKitaFavKey = const ValueKey("Kafe Kita");

  Future<void> loadApp(Widget widget) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  }

  Future<void> tapFavoriteButton({required String restaurantName}) async {
    final favButtonFinder = find.byKey(ValueKey(restaurantName));

    await tester.tap(favButtonFinder);
    await tester.pumpAndSettle();
  }

  Future<void> navigateTo({String screenName = "Favorites"}) async {
    final navbarDestinationFinder = find.byKey(ValueKey(screenName));

    await tester.tap(navbarDestinationFinder);
    await tester.pumpAndSettle();
  }

  Future<void> checkFavoriteStatus({
    required String restaurantName,
    required bool isFavorite,
  }) async {
    final favButtonFinder = find.byKey(ValueKey(restaurantName));

    final iconButton = tester.widget<IconButton>(favButtonFinder);
    final icon = iconButton.icon as Icon;

    expect(
      icon.icon,
      isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
      reason: "Wrong favorite icon displayed",
    );

    if (isFavorite) {
      expect(
        icon.color,
        Colors.pink,
        reason: "Wrong favorite color displayed",
      );
    }
  }

  Future<void> verifyFavoriteInList({required String restaurantName}) async {
    await navigateTo(screenName: "Favorites");

    final restaurantFinder = find.text(restaurantName);
    expect(restaurantFinder, findsOneWidget);
  }
}
