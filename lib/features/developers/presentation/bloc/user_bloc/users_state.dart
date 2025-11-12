
import 'package:equatable/equatable.dart';

import '../../../model/user_model.dart';

class UsersState extends Equatable {
 final List<UserModel> usersList;
 final UserStatus userStatus;

 const UsersState({
  this.userStatus = UserStatus.empty,
  this.usersList = const [],
 });

 UsersState copyWith({
  UserStatus? userStatus,
  List<UserModel>? usersList,
 }) {
  return UsersState(
   userStatus: userStatus ?? this.userStatus,
   usersList: usersList ?? this.usersList,
  );
 }

 @override
 List<Object?> get props => [userStatus, usersList];
}

enum UserStatus { loading, loaded, empty, error }
