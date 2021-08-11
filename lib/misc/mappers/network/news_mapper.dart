import 'package:news_app/dto/article_dto.dart';
import 'package:news_app/misc/mappers/network/dto_mapper.dart';
import 'package:news_app/models/article.dart';

class NewsMapper extends DTOMapper<ArticleDTO, Article> {
  @override
  ArticleDTO toDTO(Article object) => ArticleDTO(
      title: object.title,
      description: object.description,
      urlToImage: object.urlToImage,
      url: object.url,
  );

  @override
  Article toModel(ArticleDTO object) => Article(
      title: object.title,
      description: object.description,
      urlToImage: object.urlToImage,
      url: object.url!
    ,);
}
