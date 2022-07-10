part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String status;
  final MainFailures? failure;

  const LoginState({
    required this.status,
    required this.failure,
  });

  @override
  List<Object?> get props => [status, failure];

  LoginState copyWith({
    String? status,
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
    required String status,
    MainFailures? failure,
  }) : super(status: AuthStateValue.initial, failure: null);

  @override
  List<Object?> get props => [status, failure];
}
