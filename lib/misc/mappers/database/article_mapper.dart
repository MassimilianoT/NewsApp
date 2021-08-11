import 'package:news_app/misc/mappers/database/dto_mapper.dart';
import 'package:news_app/models/article.dart';

class ArticleMapper extends DTOMapper<Article> {
  @override
  Map<String, dynamic> toDTO(Article object) => {
        'title': object.title,
        'description': object.description,
        'imageUrl': object.urlToImage
      };

  @override
  Article toModel(Map<String, dynamic> object) =>
      Article(
      title: object["title"],
      description: object["description"],
      urlToImage: object["imageUrl"]);
}
