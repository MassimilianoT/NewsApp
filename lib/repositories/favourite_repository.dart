import 'dart:collection';

import 'package:news_app/database/dao/favourites_dao.dart';
import 'package:news_app/misc/mappers/database/dto_mapper.dart';
import 'package:news_app/models/favourite.dart';

class FavouriteRepository{
  final FavouritesDAO favouritesDao;
  final DTOMapper<Favourite> favouriteMapper;
  FavouriteRepository(
      {required this.favouritesDao, required this.favouriteMapper});

  Future<Map<int, Favourite>> favourite() async {
    return (await favouritesDao.
    getFavouriteArticles()).fold<Map<int, Favourite>>(HashMap(),
            (map, row) {
          map.putIfAbsent(row["id"], () => favouriteMapper.toModel(row));
          return map;
        });
  }

  Future<bool> updateFavourite(Favourite favourite) async {
    return await favouritesDao.updateFavouriteArticle(favouriteMapper.toDTO(favourite));
  }

  Future<bool> saveFavourite(int id) async {
    return await favouritesDao.saveFavouriteArticle(id);
  }

  Future<bool> deleteFavourite(int id) async {
    return await favouritesDao.deleteFavouriteArticle(id);
  }
}