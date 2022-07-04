part of 'create_account_bloc.dart';

abstract class CreateAccountEvent extends Equatable {}

class AccountCreated extends CreateAccountEvent {
  final UserModel model;
  final String password;
  AccountCreated({required this.model, required this.password});
  @override
  List<Object?> get props => [password, model];
}
