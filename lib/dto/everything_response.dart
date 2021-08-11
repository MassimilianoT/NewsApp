import 'package:news_app/dto/dto.dart';

import 'article_dto.dart';

class EverythingResponse extends DTO {
  final String ok;
  final int totalResults;
  final List<ArticleDTO> articles;

  EverythingResponse(
      {
        required this.ok,
        required this.totalResults,
        required this.articles
      });

  factory EverythingResponse.fromJson(Map<String, dynamic> json) =>
      EverythingResponse(
          ok: json["status"],
          totalResults: json["totalResults"],
          articles: (json["articles"] as List)
              .map((article) => ArticleDTO.fromJson(article))
              .toList(growable: false));

  @override
  List<Object?> get props => [ok, totalResults, articles];
}
