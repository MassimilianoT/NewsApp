import 'package:news_app/database/dao/abstract_dao.dart';
import 'package:news_app/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class ArticlesDAO extends AbstractDAO{
  ArticlesDAO(DatabaseHelper databaseHelper) : super(databaseHelper);

  //Metodo di inserimento: ritorno l'id
  Future<int> insertArticle(Map<String, dynamic> article) async {
    return await (await databaseHelper.database).insert("articles", article,
        conflictAlgorithm: ConflictAlgorithm.ignore);
    //Insert ritorna il numero di riga
  }

  Future<List<Map<String, dynamic>>> getArticles() async {
    return await (await databaseHelper.database).query("articles");
    //Insert ritorna il numero di riga
  }
}