import 'package:connectivity/connectivity.dart';
import 'package:news_app/database/database_helper.dart';
import 'package:news_app/dto/article_dto.dart';
import 'package:news_app/misc/mappers/network/dto_mapper.dart';
import 'package:news_app/misc/mappers/database/dto_mapper.dart' as db;
import 'package:news_app/models/article.dart';
import 'package:news_app/dto/everything_response.dart';
import 'package:news_app/network/rest_client.dart';

class NewsRepository {
  final RestClient restClient;
  final DTOMapper<ArticleDTO, Article> newsMapper;
  final db.DTOMapper<Article> articleMapper;
  final DatabaseHelper databaseHelper;
  final Connectivity connectivity;

  NewsRepository({
    required this.restClient,
    required this.newsMapper,
    required this.databaseHelper,
    required this.connectivity,
    required this.articleMapper,
  });

  Future<List<Article>> news() async {
    //check internet
    final connectivityResult = await connectivity.checkConnectivity();
    List<Article> articles;
    if (connectivityResult == ConnectivityResult.none) {
      //Non ho internet
      final List<Map<String, dynamic>> dbArticles =
          await databaseHelper.getArticles();
      //Mi serve un mapper!
      articles = dbArticles.map(articleMapper.toModel).toList();
    } else {
      EverythingResponse? response;
      try {
        response = await restClient.everything();
      } catch (error) {
        throw Error();
      }
      articles = response.articles.map(newsMapper.toModel).toList();
      articles.forEach((article) async {
        final dbArticle = articleMapper.toDTO(article);
        article.id = await databaseHelper.insertArticle(dbArticle);
      });
    }

    return articles;
  }

  Future<Set<int>> favourite() async {
    return (await databaseHelper.getFavouriteArticles()).fold<Set<int>>(Set(),
        (set, row) {
      set.add(row["id"]);
      return set;
    });
  }

  Future<bool> saveFavourite(int id) async {
    return await databaseHelper.saveFavouriteArticle(id);
  }

  Future<bool> deleteFavourite(int id) async {
    return await databaseHelper.deleteFavouriteArticle(id);
  }
}
