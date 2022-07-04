// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

class UserState extends Equatable {
  final UserEnums status;
  UserModel? model;
  MainFailures? failure;

  UserState({required this.status, required this.failure, required this.model});

  @override
  List<Object?> get props => throw [failure, model, status];

  UserState copyWith({
    UserEnums? status,
    UserModel? model,
    MainFailures? failure,
  }) {
    return UserState(
      status: status ?? this.status,
      model: model ?? this.model,
      failure: failure ?? this.failure,
    );
  }
}

class UserInitial extends UserState {
  UserInitial(
      {required UserEnums status,
      required MainFailures? failure,
      required UserModel? model})
      : super(status: status, failure: failure, model: model);

  @override
  List<Object?> get props => throw [failure, model, status];
}
