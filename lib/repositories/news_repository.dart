import 'package:news_app/dto/article_dto.dart';
import 'package:news_app/misc/mappers/dto_mapper.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/dto/everything_response.dart';
import 'package:news_app/network/rest_client.dart';

class NewsRepository{
  final RestClient restClient;
  final DTOMapper<ArticleDTO, Article> newsMapper;

  NewsRepository({required this.restClient, required this.newsMapper});


  Future<List<Article>> news() async{
    EverythingResponse? response;
    try{
      response = await restClient.everything();
    }catch(error){
      throw Error();
    }
    List<Article> articles =
    response.articles.map(newsMapper.toModel).toList();
    return articles;
  }

}