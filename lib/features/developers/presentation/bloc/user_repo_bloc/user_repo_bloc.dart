import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wldd/features/developers/model/user_repo_model.dart';
import 'package:wldd/features/developers/repository/repository_repo_impl.dart';

part 'user_repo_event.dart';
part 'user_repo_state.dart';

class UserRepoBloc extends Bloc<UserRepoEvent, UserRepoState> {
  RepositoryRepoImpl repoImpl;
  UserRepoBloc(this.repoImpl) : super(UserRepoState()) {
    on<GetUserRepoEvent>(_getUserRepo);
  }

  FutureOr<void> _getUserRepo(
    GetUserRepoEvent event,
    Emitter<UserRepoState> emit,
  ) async {
    try {
      emit(state.copyWith(status: UserRepoStatus.loading));
      final repoList = await repoImpl.getUserRepository(event.url);
      if (repoList.isEmpty) {
        emit(state.copyWith(status: UserRepoStatus.empty, repoList: repoList));
      } else {
        emit(state.copyWith(status: UserRepoStatus.loaded, repoList: repoList));
      }
    } catch (e) {
      emit(
        state.copyWith(status: UserRepoStatus.loaded, errorMsg: e.toString()),
      );
    }
  }
}
