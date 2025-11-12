


import 'package:equatable/equatable.dart';

class FavoritesState extends Equatable {
  final List<String> favoriteIds;

  const FavoritesState({this.favoriteIds = const []});

  FavoritesState copyWith({List<String>? favoriteIds}) {
    return FavoritesState(favoriteIds: favoriteIds ?? this.favoriteIds);
  }

  @override
  List<Object?> get props => [favoriteIds];
}
