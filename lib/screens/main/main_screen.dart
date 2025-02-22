import 'package:flutter/material.dart';
import 'package:platescape/providers/providers.dart';
import 'package:platescape/screens/screens.dart';
import 'package:platescape/static/static.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<NavigationBarProvider>(
        builder: (context, navbarProvider, child) {
          return switch (navbarProvider.currentState) {
            HomeState() => HomeScreen(),
            FavoritesState() => FavoritesScreen(),
            _ => SettingsScreen(),
          };
        },
      ),
      bottomNavigationBar: Consumer<NavigationBarProvider>(
        builder: (context, navbarProvider, child) {
          final currentIndex =
              navbarProvider.getIndex(navbarProvider.currentState);

          return NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: (index) {
              final state = navbarProvider.getNavigationBarState(index);
              navbarProvider.updateState(state);
            },
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: "Home",
              ),
              const NavigationDestination(
                icon: Icon(Icons.favorite_outline_rounded),
                selectedIcon: Icon(Icons.favorite_rounded),
                label: "Favorites",
              ),
              const NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings_rounded),
                label: "Settings",
              ),
            ],
          );
        },
      ),
    );
  }
}
