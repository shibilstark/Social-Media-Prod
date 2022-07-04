part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {}

class GetCurrenUser extends UserEvent {
  @override
  List<Object?> get props => [];
}

class GetUserWithId extends UserEvent {
  final String userId;

  GetUserWithId({required this.userId});

  @override
  List<Object?> get props => [];
}
