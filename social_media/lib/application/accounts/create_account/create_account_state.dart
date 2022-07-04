// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_account_bloc.dart';

class CreateAccountState extends Equatable {
  final AuthEnum state;
  MainFailures? failure;
  UserModel? model;
  CreateAccountState({required this.state, required this.failure, this.model});
  @override
  List<Object?> get props => [state, failure, model];

  CreateAccountState copyWith(
      {AuthEnum? state, MainFailures? failure, UserModel? model}) {
    return CreateAccountState(
      state: state ?? this.state,
      failure: failure ?? this.failure,
      model: model ?? this.model,
    );
  }
}

class CreateAccountInitial extends CreateAccountState {
  CreateAccountInitial(
      {required AuthEnum state, MainFailures? faulure, UserModel? model})
      : super(state: state, failure: null, model: null);
}
