import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/repositories/news_repository.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final NewsRepository newsRepository;

  FavouriteBloc({required this.newsRepository})
      : super(FavouriteState(ids: Set()));

  @override
  Stream<FavouriteState> mapEventToState(FavouriteEvent event,) async* {
    if (event is FetchFavourites) {
      final ids = await newsRepository.favourite();
      yield FavouriteState(ids: ids);
    } else if (event is SaveFavourite) {
      await newsRepository.saveFavourite(event.id);
      add(FetchFavourites());
      //Subito si fa un nuovo fetch in modo da tenere aggiornati i preferiti
    } else if (event is DeleteFavourite) {
      await newsRepository.deleteFavourite(event.id);
      add(FetchFavourites());
      //Subito si fa un nuovo fetch in modo da tenere aggiornati i preferiti
    }
  }

  void fetchFavourites() => add(FetchFavourites());
  void saveFavourite(int id) => add(SaveFavourite(id));
  void deleteFavourite(int id) => add(DeleteFavourite(id));
}