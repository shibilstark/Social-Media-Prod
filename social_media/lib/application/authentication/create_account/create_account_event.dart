part of 'create_account_bloc.dart';

abstract class CreateAccountEvent extends Equatable {}

class AccountCreated extends CreateAccountEvent {
  final UserModel model;
  AccountCreated({required this.model});
  @override
  List<Object?> get props => [];
}
