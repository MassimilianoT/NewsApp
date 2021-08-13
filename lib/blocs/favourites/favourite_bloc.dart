import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/favourite.dart';
import 'package:news_app/repositories/favourite_repository.dart';

part 'favourite_event.dart';

part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final FavouriteRepository favouriteRepository;

  FavouriteBloc({required this.favouriteRepository})
      : super(FavouriteState(ids: HashMap()));

  @override
  Stream<FavouriteState> mapEventToState(FavouriteEvent event,) async* {
    if (event is FetchFavourites) {
      final ids = await favouriteRepository.favourite();
      yield FavouriteState(ids: ids);
    } else if (event is ToggleFavourite) {
      if (event.favourite == null) {
        await favouriteRepository.saveFavourite(event.id!);
      } else if (event.favourite!.color == Colors.green) {
        await favouriteRepository.deleteFavourite(event.id!);
      } else {
        final color = event.favourite!.color == Colors.yellow
            ? Colors.blue
            : event.favourite!.color == Colors.blue ? Colors.red : Colors.green; 
        
        await favouriteRepository.updateFavourite(Favourite(id: event.id, color: color));
      }
      add(FetchFavourites());
    }
  }

  void fetchFavourites() => add(FetchFavourites());

  void toggleFavourite(int? id, {required Favourite? favourite}) =>
      add(ToggleFavourite(id: id, favourite: favourite));

}