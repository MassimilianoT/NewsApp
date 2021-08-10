import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/news/news_bloc.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/widget/article_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("News App"),),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state){
          if(state is ErrorNewsState){
            return _errorNewsState(state.error);
          }
          else if(state is FetchingNewsState){
            return _loadingNewsState();
          }else if(state is NoNewsState){
            return _noNewsState();
          }else if(state is FetchedNewsState){
            return _list(state.articles);
          }
          return Container();
        },
      ),
    );
  }

  Widget _errorNewsState(String error) =>Center(child: Text(error),);

  Widget _loadingNewsState() => Center(child: CircularProgressIndicator(),);

  Widget _noNewsState() => Center(child:Text("No news available"),);

  Widget _list(List<Article> articles) {
    return ListView.builder(
      itemCount: articles.length,
        itemBuilder: (context, index) =>
            ArticleWidget(articles[index]));
  }

}

