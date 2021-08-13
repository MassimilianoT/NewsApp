part of 'favourite_bloc.dart';

class FavouriteState extends Equatable {
 final Map<int, Favourite>? ids;

  FavouriteState({this.ids});

  @override
  List<Object?> get props =>  [ids];
}
