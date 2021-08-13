import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/models/favourite.dart';

class ArticleWidget extends StatelessWidget {
  final Article article;
  final Favourite? favourite;
  final VoidCallback onTap;

  const ArticleWidget(this.article,
      {Key? key, this.favourite, required this.onTap})
      : super(key: key);

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
      trailing: InkWell(
        onTap: onTap,
        child: Icon(favourite!= null ? Icons.star : Icons.star_border, color: favourite!=null ? favourite!.color : null,),
      ),
    );
  }
}
