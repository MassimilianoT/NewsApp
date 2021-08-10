import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/models/everything_response.dart';
import 'package:news_app/network/rest_client.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final RestClient restClient;

  NewsBloc({required this.restClient}) : super(FetchingNewsState());

  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if (event is FetchNewsEvent) {
      yield FetchingNewsState();
      EverythingResponse? response;
      try {
        response = await restClient.everything();
      } catch (error) {
        yield ErrorNewsState(error.toString());
      }

      if (response != null) {
        if (response.articles.isNotEmpty) {
          yield FetchedNewsState(response.articles);
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
