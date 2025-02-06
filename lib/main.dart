import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:platescape/data/data.dart';
import 'package:platescape/provider/platescape_providers.dart';
import 'package:platescape/screens/screens.dart';
import 'package:platescape/static/static.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider(
        create: (context) => APIServices(),
      ),
      ChangeNotifierProvider(
        create: (context) =>
            RestaurantListProvider(context.read<APIServices>()),
      ),
      ChangeNotifierProvider(
        create: (context) => RestaurantDetailsProvider(
          context.read<APIServices>(),
        ),
      ),
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoute.home.route,
      routes: {
        AppRoute.home.route: (context) => HomeScreen(),
        AppRoute.detail.route: (context) => DetailScreen(
              id: ModalRoute.of(context)?.settings.arguments as String,
            ),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme:
            GoogleFonts.plusJakartaSansTextTheme(Theme.of(context).textTheme),
      ),
    );
  }
}
