import 'package:news_app/misc/mappers/database/dto_mapper.dart';
import 'package:news_app/models/article.dart';

class ArticleMapper extends DTOMapper<Article> {
  @override
  Map<String, dynamic> toDTO(Article object) => {
        'id': object.id,
        'title': object.title,
        'description': object.description,
        'imageUrl': object.urlToImage,
        'url': object.url,
      };

  @override
  Article toModel(Map<String, dynamic> object) => Article(
        id: object["id"],
        title: object["title"],
        description: object["description"],
        urlToImage: object["imageUrl"],
        url: object["url"],
      );
}
