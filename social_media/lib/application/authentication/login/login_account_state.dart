part of 'login_account_bloc.dart';

class LoginAccountState extends Equatable {
  final AuthEnum status;
  final MainFailures? failure;

  const LoginAccountState({
    required this.status,
    required this.failure,
  });

  @override
  List<Object?> get props => [status, failure];

  LoginAccountState copyWith({
    AuthEnum? status,
    MainFailures? failure,
  }) {
    return LoginAccountState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}

class LoginAccountInitial extends LoginAccountState {
  const LoginAccountInitial({
    required AuthEnum status,
    MainFailures? failure,
  }) : super(status: AuthEnum.initial, failure: null);

  @override
  List<Object?> get props => [status, failure];
}
