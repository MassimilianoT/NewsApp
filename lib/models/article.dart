//Questa è la classe di modello che utilizziamo nella App
class Article {
  int? id;
  final String title;
  final String description;
  final String urlToImage;
  final String url;

  Article({
    this.id,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
  });

}
