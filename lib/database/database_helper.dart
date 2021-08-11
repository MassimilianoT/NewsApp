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
        version: 1, onCreate: (database, version) {
      return database.execute(
          "CREATE TABLE articles(id INTEGER PRIMARY KEY, title TEXT, description TEXT, imageUrl TEXT)");
    });
  }

  //Metodo di inserimento
  Future<bool> insertArticle(Map<String, dynamic> article) async {
    return await (await _currentDatabase()).insert("articles", article) > 0;
    //Insert ritorna il numero di riga
  }

  Future<List<Map<String, dynamic>>> getArticles() async {
    return await (await _currentDatabase()).query("articles");
    //Insert ritorna il numero di riga
  }
}
