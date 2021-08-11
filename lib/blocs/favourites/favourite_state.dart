part of 'favourite_bloc.dart';

class FavouriteState extends Equatable {
 final Set<int>? ids;

  FavouriteState({this.ids});

  @override
  List<Object?> get props =>  [ids];
}
