part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class FetchingNewsState extends NewsState {
  @override
  List<Object> get props => [];
}
class NoNewsState extends NewsState {
  @override
  List<Object> get props => [];
}
class ErrorNewsState extends NewsState {
  final String error;

  ErrorNewsState(this.error);

  @override
  List<Object> get props => [error];
}
class FetchedNewsState extends NewsState {
  final List<Article> articles;

  FetchedNewsState(this.articles);

  @override
  List<Object> get props => [articles];
}
