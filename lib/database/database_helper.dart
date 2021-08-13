import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    return _database = await openDatabase(
        join(await getDatabasesPath(), "news_app.db"),
        version: 3, onCreate: (database, version) {
      [
        'CREATE TABLE articles(id INTEGER PRIMARY KEY, title TEXT, description TEXT, imageUrl TEXT, url TEXT UNIQUE)',
        'CREATE TABLE favourites(id INTEGER PRIMARY KEY, color TEXT NOT NULL DEFAULT "yellow")',
      ].forEach((query) async => await database.execute(query));
    }, onUpgrade: (database, oldV, newV) {
      if (oldV < 2) {
        [
          'DROP TABLE articles',
          'CREATE TABLE articles(id INTEGER PRIMARY KEY, title TEXT, description TEXT, imageUrl TEXT, url TEXT UNIQUE)',
          'CREATE TABLE favourites(id INTEGER PRIMARY KEY)',
        ].forEach((query) async => await database.execute(query));
      } else if (oldV < 3) {
        [
          'ALTER TABLE favourites ADD COLUMN color TEXT NOT NULL DEFAULT "yellow"',
        ].forEach((query) async => await database.execute(query));
      }
    });
  }




}
