part of 'login_bloc.dart';

class LoginState extends Equatable {
  final AuthEnum status;
  final MainFailures? failure;

  const LoginState({
    required this.status,
    required this.failure,
  });

  @override
  List<Object?> get props => [status, failure];

  LoginState copyWith({
    AuthEnum? status,
    MainFailures? failure,
  }) {
    return LoginState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}

class LoginInitial extends LoginState {
  const LoginInitial({
    required AuthEnum status,
    MainFailures? failure,
  }) : super(status: AuthEnum.initial, failure: null);

  @override
  List<Object?> get props => [status, failure];
}
