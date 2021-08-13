import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? _database;

  Future<Database> _currentDatabase() async {
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

  //Metodo di inserimento: ritorno l'id
  Future<int> insertArticle(Map<String, dynamic> article) async {
    return await (await _currentDatabase()).insert("articles", article,
        conflictAlgorithm: ConflictAlgorithm.ignore);
    //Insert ritorna il numero di riga
  }

  Future<bool> saveFavouriteArticle(int id) async {
    return await (await _currentDatabase()).insert("favourites", {"id": id}) >
        0;
  }

  Future<List<Map<String, dynamic>>> getArticles() async {
    return await (await _currentDatabase()).query("articles");
    //Insert ritorna il numero di riga
  }

  Future<List<Map<String, dynamic>>> getFavouriteArticles() async {
    return await (await _currentDatabase()).query("favourites");
    //Insert ritorna il numero di riga
  }

  Future<bool> updateFavouriteArticle(Map<String, dynamic> favourite) async {
    return await (await _currentDatabase()).update("favourites", favourite,
            where: "id = ?", whereArgs: [favourite["id"]]) >
        0;
  }

  Future<bool> deleteFavouriteArticle(int id) async {
    return await (await _currentDatabase())
            .delete("favourites", where: 'id = ?', whereArgs: [id]) >
        0;
  }
}
