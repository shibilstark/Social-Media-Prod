part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserStateLoading extends UserState {
  @override
  List<Object> get props => [];
}

class FetchCurrentUserSuccess extends UserState {
  final ProfileFeedModel data;

  FetchCurrentUserSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

class FetchCurrentUserError extends UserState {
  final MainFailures failure;
  FetchCurrentUserError({required this.failure});
  @override
  List<Object> get props => [failure];
}

class FetchByIdError extends UserState {
  final MainFailures failure;
  FetchByIdError({required this.failure});
  @override
  List<Object> get props => [failure];
}

class FetchByIdSuccess extends UserState {
  final ProfileFeedModel model;

  FetchByIdSuccess({required this.model});
  @override
  List<Object> get props => [model];
}
