import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:wldd/features/developers/presentation/bloc/user_bloc/users_event.dart';
import 'package:wldd/features/developers/presentation/bloc/user_bloc/users_state.dart';

import '../../../repository/user_repository_implements.dart';


class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserRepositoryImplements _userRepository;

  UsersBloc(this._userRepository) : super(const UsersState()) {
    on<GetUsersEvent>(_getUsers);
  }

  FutureOr<void> _getUsers(GetUsersEvent event, Emitter<UsersState> emit) async {
    try {
      emit(state.copyWith(userStatus: UserStatus.loading));

      final userList = await _userRepository.getUsers();

      if (userList.isNotEmpty) {
        emit(state.copyWith(
          userStatus: UserStatus.loaded,
          usersList: userList,
        ));
      } else {
        emit(state.copyWith(userStatus: UserStatus.empty));
      }
    } catch (e) {
      log('Error in UsersBloc: $e');
      emit(state.copyWith(userStatus: UserStatus.error));
    }
  }
}
