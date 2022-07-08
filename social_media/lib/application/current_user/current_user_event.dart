part of 'current_user_bloc.dart';

abstract class CurrentUserEvent extends Equatable {}

class FetchUser extends CurrentUserEvent {
  final String userId;

  FetchUser({required this.userId});
  @override
  List<Object?> get props => [userId];
}
