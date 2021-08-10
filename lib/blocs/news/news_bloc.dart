import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/dto/everything_response.dart';
import 'package:news_app/network/rest_client.dart';
import 'package:news_app/repositories/news_repository.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc({required this.newsRepository}) : super(FetchingNewsState());

  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if (event is FetchNewsEvent) {
      yield FetchingNewsState();
      List<Article>? articles;
      try {
        articles = await newsRepository.news();
      } catch (error) {
        yield ErrorNewsState(error.toString());
      }

      if (articles != null) {
        if (articles.isNotEmpty) {
          yield FetchedNewsState(articles);
        } else {
          yield NoNewsState();
        }
      } else {
        ErrorNewsState("Generic error");
      }
    }
  }

  void fetchNews() => add(FetchNewsEvent());
}
