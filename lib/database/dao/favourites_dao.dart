import 'package:news_app/database/dao/abstract_dao.dart';
import 'package:news_app/database/database_helper.dart';

class FavouritesDAO extends AbstractDAO{
  FavouritesDAO(DatabaseHelper databaseHelper) : super(databaseHelper);

  Future<bool> saveFavouriteArticle(int id) async {
    return await (await databaseHelper.database).insert("favourites", {"id": id}) >
        0;
  }

  Future<List<Map<String, dynamic>>> getFavouriteArticles() async {
    return await (await databaseHelper.database).query("favourites");
    //Insert ritorna il numero di riga
  }

  Future<bool> updateFavouriteArticle(Map<String, dynamic> favourite) async {
    return await (await databaseHelper.database).update("favourites", favourite,
        where: "id = ?", whereArgs: [favourite["id"]]) >
        0;
  }

  Future<bool> deleteFavouriteArticle(int id) async {
    return await (await databaseHelper.database)
        .delete("favourites", where: 'id = ?', whereArgs: [id]) >
        0;
  }
}