


part of 'search_cubit.dart';

class SearchState extends Equatable {
  final String query;
  final List<UserModel> filteredOnlineUsers;
  final List<OfflineUserModel> filteredOfflineUsers;

  const SearchState({
    this.query = '',
    this.filteredOnlineUsers = const [],
    this.filteredOfflineUsers = const [],
  });

  SearchState copyWith({
    String? query,
    List<UserModel>? filteredOnlineUsers,
    List<OfflineUserModel>? filteredOfflineUsers,
  }) {
    return SearchState(
      query: query ?? this.query,
      filteredOnlineUsers: filteredOnlineUsers ?? this.filteredOnlineUsers,
      filteredOfflineUsers: filteredOfflineUsers ?? this.filteredOfflineUsers,
    );
  }

  @override
  List<Object?> get props => [query, filteredOnlineUsers, filteredOfflineUsers];
}
