import 'article.dart';

class EverythingResponse {
  final String ok;
  final int totalResults;
  final List<Article> articles;

  EverythingResponse(
      {required this.ok, required this.totalResults, required this.articles});

  factory EverythingResponse.fromJson(Map<String, dynamic> json) =>
      EverythingResponse(
          ok: json["status"],
          totalResults: json["totalResults"],
          articles: (json["articles"] as List)
              .map((article) {
                print(article);
                return Article.fromJson(article);
              })
              .toList(growable: false));
}
