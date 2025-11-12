part of 'user_details_bloc.dart';

sealed class UserDetailsEvent extends Equatable {
  const UserDetailsEvent();
}


class GetUserDetailsEvent extends UserDetailsEvent{
  final String url;
 const GetUserDetailsEvent({required this.url});
  @override
  List<Object?> get props => [url];
}

