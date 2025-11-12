import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wldd/features/developers/model/user_details_model.dart';
import 'package:wldd/features/developers/repository/user_details_repo_impl.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final UserDetailsRepoImpl userDetailsRepoImpl;

  UserDetailsBloc(this.userDetailsRepoImpl) : super(UserDetailsState()) {
    on<GetUserDetailsEvent>(_getUserDetails);
  }

  FutureOr<void> _getUserDetails(
    GetUserDetailsEvent event,
    Emitter<UserDetailsState> emit,
  ) async {
    try {
      emit(state.copyWith(userDetailsStatus: UserDetailsStatus.loading));

      final userDetails = await userDetailsRepoImpl.getUserDetails(event.url);

      emit(
        state.copyWith(
          userDetailsStatus: UserDetailsStatus.loaded,
          userDetails: userDetails,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          userDetailsStatus: UserDetailsStatus.error,
          errorMsg: e.toString(),
        ),
      );
    }
  }
}
