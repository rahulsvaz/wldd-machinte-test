
import 'package:equatable/equatable.dart';


sealed class UsersEvent extends Equatable {
  const UsersEvent();
}


class GetUsersEvent extends UsersEvent{
  @override
  List<Object?> get props =>[];
}