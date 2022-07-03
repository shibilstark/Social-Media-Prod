part of 'login_account_bloc.dart';

class LoginAccountEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoggedIn extends LoginAccountEvent {
  final String email;
  final String password;

  LoggedIn({required this.email, required this.password});
  @override
  List<Object?> get props => [];
}

class LoggedOut extends LoginAccountEvent {}
