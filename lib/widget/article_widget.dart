import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget(this.article,{ Key? key,}) : super(key: key);
 final Article article;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(article.title),
      subtitle: Text(article.description),
      leading: Image.network(article.urlToImage),
    );
  }
}
