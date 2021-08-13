part of 'favourite_bloc.dart';

abstract class FavouriteEvent extends Equatable {
  const FavouriteEvent();
}

class FetchFavourites extends FavouriteEvent {
  @override
  List<Object?> get props => [];
}

class ToggleFavourite extends FavouriteEvent {
  final int? id;
  final Favourite? favourite;

  ToggleFavourite({required this.id, this.favourite});

  @override
  List<Object?> get props => [id, favourite];
}
