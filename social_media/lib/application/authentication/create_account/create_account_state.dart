// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_account_bloc.dart';

class CreateAccountState extends Equatable {
  final AuthEnum state;
  MainFailures? failure;
  CreateAccountState({required this.state, required this.failure});
  @override
  List<Object?> get props => [state, failure];

  CreateAccountState copyWith({
    AuthEnum? state,
    MainFailures? failure,
  }) {
    return CreateAccountState(
      state: state ?? this.state,
      failure: failure ?? this.failure,
    );
  }
}

class CreateAccountInitial extends CreateAccountState {
  CreateAccountInitial({required AuthEnum state, MainFailures? faulure})
      : super(state: state, failure: null);
}
