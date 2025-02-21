import 'package:platescape/data/data.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteRestaurantRepository {
  final SqliteService _sqliteService = SqliteService();

  Future<int> addFavorite(Restaurant restaurant) async {
    final db = await _sqliteService.database;
    final data = restaurant.toJson();
    return db.insert(
      _sqliteService.favoriteTable,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Restaurant>> getAllFavorites() async {
    final db = await _sqliteService.database;
    final results = await db.query(_sqliteService.favoriteTable);
    final restaurants = results
        .map(
          (restaurant) => Restaurant.fromJson(restaurant),
        )
        .toList();

    return restaurants;
  }

  Future<Restaurant> getFavoriteById(String id) async {
    final db = await _sqliteService.database;
    final results = await db.query(
      _sqliteService.favoriteTable,
      where: "id = ?",
      whereArgs: [id],
    );
    final restaurant = results
        .map(
          (res) => Restaurant.fromJson(res),
        )
        .first;

    return restaurant;
  }

  Future<int> removeFavorite(String id) async {
    final db = await _sqliteService.database;
    final result = await db.delete(
      _sqliteService.favoriteTable,
      where: "id = ?",
      whereArgs: [id],
    );

    return result;
  }

  Future<bool> isFavorite(String id) async {
    final db = await _sqliteService.database;
    final results = await db.query(
      _sqliteService.favoriteTable,
      where: "id = ?",
      whereArgs: [id],
    );

    return results.isNotEmpty;
  }
}
