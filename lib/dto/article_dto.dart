import 'package:news_app/dto/dto.dart';

//Data Transfer Object: Si interfaccia direttamente con le API, a differenza della classe di model
// Article (immutabile) questa classe potrebbe subire variazioni

class ArticleDTO extends DTO {
  final String title;
  final String description;
  final String? url;
  final String urlToImage;
  final String? publishedAt;
  final String? content;

  ArticleDTO(
      {required this.title,
      required this.description,
      this.url,
      required this.urlToImage,
      this.publishedAt,
      this.content});

  factory ArticleDTO.fromJson(Map<String, dynamic> json) => ArticleDTO(
      title: json["title"],
      description: json["description"],
      url: json["url"],
      urlToImage: json["urlToImage"]);

  @override
  List<Object?> get props =>
      [title, description, urlToImage, url, publishedAt, content];
}
