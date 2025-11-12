part of 'user_repo_bloc.dart';

class UserRepoState extends Equatable {
  final UserRepoStatus status;
  final List<UserRepoModel> repoList;
  final String? errorMsg;
  const UserRepoState({
    this.status = UserRepoStatus.initial,
    this.errorMsg,
    this.repoList = const [],
  });

  @override
  List<Object?> get props => [status, repoList, errorMsg];

  UserRepoState copyWith({
    UserRepoStatus? status,
    List<UserRepoModel>? repoList,
    String? errorMsg,
  }) {
    return UserRepoState(
      status: status ?? this.status,
      repoList: repoList ?? this.repoList,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

enum UserRepoStatus { initial, loading, loaded, empty, error }
