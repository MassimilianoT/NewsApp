part of 'favourite_bloc.dart';

abstract class FavouriteEvent extends Equatable {
  const FavouriteEvent();
}
class FetchFavourites extends FavouriteEvent{
  @override
  List<Object?> get props => [];
}
class SaveFavourite extends FavouriteEvent{
  final int id;

  SaveFavourite(this.id);
  @override
  List<Object?> get props => [id];
}
class DeleteFavourite extends FavouriteEvent{
  final int id;

  DeleteFavourite(this.id);
  @override
  List<Object?> get props => [id];
}