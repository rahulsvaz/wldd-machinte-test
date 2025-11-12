import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:wldd/core/hive_support.dart';
import 'package:wldd/features/developers/model/offline_user_model.dart';
import 'package:wldd/features/developers/presentation/bloc/user_bloc/users_event.dart';
import 'package:wldd/features/developers/presentation/bloc/user_bloc/users_state.dart';
import '../../../repository/user_repository_implements.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserRepositoryImplements _userRepository;

  UsersBloc(this._userRepository) : super(const UsersState()) {
    on<GetUsersEvent>(_getUsers);
  }

  FutureOr<void> _getUsers(
      GetUsersEvent event,
      Emitter<UsersState> emit,
      ) async {
    try {
      emit(state.copyWith(userStatus: UserStatus.loading));

      final userList = await _userRepository.getUsers();

      if (userList.isNotEmpty) {
        emit(state.copyWith(
          userStatus: UserStatus.loaded,
          usersList: userList,
        ));

        final userBox = Hive.box<OfflineUserModel>(HiveSupport.userBoxName);

        log(userBox.length.toString(), name: "Before clear length");

        // Clear existing users
        await userBox.clear();

        // Add new users safely
        for (final e in userList) {
          userBox.put(
            e.id.toString(),
            OfflineUserModel(
              id: e.id.toString(),
              name: e.login ?? "",
              url: e.htmlUrl ?? "",
              imageUrl: e.avatarUrl ?? "",
            ),
          );
        }

        log(userBox.length.toString(), name: "After adding length");
      } else {
        emit(state.copyWith(userStatus: UserStatus.empty));
      }
    } catch (e, st) {
      log('Error in UsersBloc: $e', stackTrace: st);
      emit(state.copyWith(userStatus: UserStatus.error));
    }
  }
}
