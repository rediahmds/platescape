import 'package:flutter/material.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/screens/screens.dart';
import 'package:platescape/static/static.dart';
import 'package:platescape/styles/styles.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider(
        create: (context) => APIServices(),
      ),
      Provider(
        create: (context) => FavoriteRestaurantRepository(),
      ),
      ChangeNotifierProvider(
        create: (context) => RestaurantListProvider(
          context.read<APIServices>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => RestaurantDetailsProvider(
          context.read<APIServices>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => RestaurantReviewsProvider(
          context.read<APIServices>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => ReviewTextFieldProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => RestaurantSearchProvider(
          context.read<APIServices>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => NavigationBarProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => FavoriteRestaurantsProvider(
          context.read<FavoriteRestaurantRepository>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => FavoriteIconProvider(),
      ),
    ],
    child: App(),
  ));

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoute.home.route,
      routes: {
        AppRoute.home.route: (context) => MainScreen(),
        AppRoute.detail.route: (context) => DetailScreen(
              id: ModalRoute.of(context)?.settings.arguments as String,
            ),
        AppRoute.reviews.route: (context) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>;

          return ReviewsScreen(
            restaurantName: args["restaurantName"],
            restaurantId: args["restaurantId"],
          );
        },
      },
      title: 'Platescape',
      theme: PlatescapeTheme.lightTheme,
      darkTheme: PlatescapeTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
