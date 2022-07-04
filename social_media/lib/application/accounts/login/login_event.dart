part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoggedIn extends LoginEvent {
  final String email;
  final String password;

  LoggedIn({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class LoggedOut extends LoginEvent {}
