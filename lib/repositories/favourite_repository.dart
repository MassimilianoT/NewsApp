import 'dart:collection';

import 'package:news_app/database/database_helper.dart';
import 'package:news_app/misc/mappers/database/dto_mapper.dart';
import 'package:news_app/misc/mappers/database/favourite_mapper.dart';
import 'package:news_app/models/favourite.dart';

class FavouriteRepository{
  final DatabaseHelper databaseHelper;
  final DTOMapper<Favourite> favouriteMapper;
  FavouriteRepository(
      {required this.databaseHelper, required this.favouriteMapper});

  Future<Map<int, Favourite>> favourite() async {
    return (await databaseHelper.
    getFavouriteArticles()).fold<Map<int, Favourite>>(HashMap(),
            (map, row) {
          map.putIfAbsent(row["id"], () => favouriteMapper.toModel(row));
          return map;
        });
  }

  Future<bool> updateFavourite(Favourite favourite) async {
    return await databaseHelper.updateFavouriteArticle(favouriteMapper.toDTO(favourite));
  }

  Future<bool> saveFavourite(int id) async {
    return await databaseHelper.saveFavouriteArticle(id);
  }

  Future<bool> deleteFavourite(int id) async {
    return await databaseHelper.deleteFavouriteArticle(id);
  }
}