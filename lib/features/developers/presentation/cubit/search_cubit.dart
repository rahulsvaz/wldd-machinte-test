
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/offline_user_model.dart';
import '../../model/user_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState());

  // For online data search
  void searchOnline(String query, List<UserModel> allUsers) {
    if (query.isEmpty) {
      emit(state.copyWith(filteredOnlineUsers: allUsers, query: ''));
      return;
    }

    final filtered = allUsers
        .where((u) => (u.login ?? '')
        .toLowerCase()
        .contains(query.toLowerCase()))
        .toList();

    emit(state.copyWith(filteredOnlineUsers: filtered, query: query));
  }

  // For offline data search
  void searchOffline(String query, List<OfflineUserModel> allUsers) {
    if (query.isEmpty) {
      emit(state.copyWith(filteredOfflineUsers: allUsers, query: ''));
      return;
    }

    final filtered = allUsers
        .where((u) => u.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    emit(state.copyWith(filteredOfflineUsers: filtered, query: query));
  }

  void clearSearch() {
    emit(const SearchState());
  }
}
