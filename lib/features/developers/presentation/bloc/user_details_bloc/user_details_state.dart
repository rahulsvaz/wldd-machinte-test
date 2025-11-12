part of 'user_details_bloc.dart';

class UserDetailsState extends Equatable {
  final UserDetailsStatus userDetailsStatus;
  final UserDetailsModel? userDetails;
  final String? errorMsg;
  const UserDetailsState({
    this.userDetailsStatus = UserDetailsStatus.loading,
    this.userDetails,
   this.errorMsg
  });

  @override
  List<Object?> get props => [userDetailsStatus, userDetails];

  UserDetailsState copyWith({
    UserDetailsStatus? userDetailsStatus,
    UserDetailsModel? userDetails,
   String? errorMsg
  }) {
    return UserDetailsState(
      userDetails: userDetails ?? this.userDetails,
      userDetailsStatus: userDetailsStatus ?? this.userDetailsStatus,
     errorMsg: errorMsg??this.errorMsg
    );
  }
}

enum UserDetailsStatus { loading, loaded, error }
