import 'package:flutter/material.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/screens/screens.dart';
import 'package:platescape/static/static.dart';
import 'package:platescape/styles/styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Platescape extends StatelessWidget {
  const Platescape({
    super.key,
    required this.prefs,
  });

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => APIServices(),
        ),
        Provider(
          create: (context) => FavoriteRestaurantRepository(),
        ),
        Provider(
          create: (context) => PreferencesService(prefs),
        ),
        Provider(
          create: (context) => NotificationService()
            ..init()
            ..configureLocalTimeZone(),
        ),
        Provider(
          create: (context) => WorkmanagerService()..init(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationProvider(
            context.read<NotificationService>(),
            context.read<PreferencesService>(),
            context.read<WorkmanagerService>(),
          )..requestPlatformPermissions(),
          lazy: false,
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
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            context.read<PreferencesService>(),
          ),
        ),
      ],
      child: PlatescapeApp(),
    );
  }
}

class PlatescapeApp extends StatelessWidget {
  const PlatescapeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => MaterialApp(
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
        themeMode: themeProvider.currentThemeMode,
      ),
    );
  }
}