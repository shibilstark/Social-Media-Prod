part of 'current_user_bloc.dart';

abstract class CurrentUserEvent extends Equatable {}

class FetchUser extends CurrentUserEvent {
  final String userId;
  final bool shouldLoad;

  FetchUser({
    required this.userId,
    required this.shouldLoad,
  });
  @override
  List<Object?> get props => [userId, shouldLoad];
}
