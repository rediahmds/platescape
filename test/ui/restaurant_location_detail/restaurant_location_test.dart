import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platescape/styles/styles.dart';
import 'package:platescape/ui/ui.dart';

void main() {
  const mockCity = "San Francisco";
  const mockAddress = "123 Main Street";

  late Widget widget;

  setUp(() {
    widget = MaterialApp(
      home: Scaffold(
          body: RestaurantLocation(
        city: mockCity,
        address: mockAddress,
      )),
    );
  });

  group("RestaurantCard widget tests", () {
    testWidgets("Should render all basic elements",
        (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      expect(find.text(mockCity), findsOneWidget);
      expect(find.text(mockAddress), findsOneWidget);

      final iconFinder = find.byIcon(Icons.location_pin);
      expect(iconFinder, findsOneWidget);

      final icon = tester.widget<Icon>(iconFinder);
      expect(icon.color, PlatescapeColors.green.color);

      final sizedBoxFinder = find.byWidgetPredicate(
          (widget) => widget is SizedBox && widget.width == 6.0);
      expect(sizedBoxFinder, findsOneWidget);

    });
  });
}
