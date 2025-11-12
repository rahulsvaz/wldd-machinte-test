part of 'user_repo_bloc.dart';

sealed class UserRepoEvent extends Equatable {
  const UserRepoEvent();
}

class GetUserRepoEvent extends UserRepoEvent{
  final String url;

  const GetUserRepoEvent({required this.url});
  @override
  List<Object?> get props => [url];
}

