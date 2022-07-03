part of 'email_send_bloc.dart';

abstract class EmailSendEvent extends Equatable {}

class EmailSend extends EmailSendEvent {
  @override
  List<Object?> get props => [];
}

class EmailVerify extends EmailSendEvent {
  @override
  List<Object?> get props => [];
}
