import 'package:sqflite/sqflite.dart';

class SqliteService {
  static const String _databaseName = "platescape.db";
  static const String _favoriteTable = "favorites";
  static const int _databaseVersion = 1;

  static final SqliteService _instance = SqliteService._internal();

  factory SqliteService() => _instance;

  SqliteService._internal();

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initializeDatabase();
    return _database!;
  }

  Future<void> _createTables(Database db) async {
    await db.execute("""
      CREATE TABLE $_favoriteTable(
        id TEXT PRIMARY KEY NOT NULL,
        name TEXT NOT NULL,
        description TEXT,
        pictureId TEXT NOT NULL,
        city TEXT NOT NULL,
        rating REAL NOT NULL,
      )
      """);
  }

  Future<Database> _initializeDatabase() async {
    return openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await _createTables(db);
      },
    );
  }

  String get favoriteTable => _favoriteTable;
}
