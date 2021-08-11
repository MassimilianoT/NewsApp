import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:news_app/models/article.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget(
    this.article, {
    Key? key,
  }) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(article.title),
      subtitle: Html(data: article.description),
      //Per visualizzare contenuti scritti in HTML
      leading: CachedNetworkImage(
        imageUrl: article.urlToImage,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
