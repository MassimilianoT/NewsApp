import 'package:news_app/dto/article_dto.dart';
import 'package:news_app/misc/mappers/dto_mapper.dart';
import 'package:news_app/models/article.dart';

class NewsMapper extends DTOMapper<ArticleDTO, Article> {
  @override
  ArticleDTO toDTO(Article object) => ArticleDTO(
      title: object.title,
      description: object.description,
      urlToImage: object.urlToImage);

  @override
  Article toModel(ArticleDTO object) => Article(
      title: object.title,
      description: object.description,
      urlToImage: object.urlToImage);
}
