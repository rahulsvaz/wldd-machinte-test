import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/secure_storage_services.dart';
import 'favorite_state.dart';


class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesSecureService _service;

  FavoritesCubit(this._service) : super(const FavoritesState());

  Future<void> loadFavorites() async {
    final ids = await _service.getFavorites();
    emit(state.copyWith(favoriteIds: ids));
  }

  Future<void> toggleFavorite(String userId) async {
    await _service.toggleFavorite(userId);
    await loadFavorites();
  }

  bool isFavorite(String userId) {
    return state.favoriteIds.contains(userId);
  }
}
