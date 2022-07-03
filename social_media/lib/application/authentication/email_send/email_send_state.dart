// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'email_send_bloc.dart';

class EmailSendState extends Equatable {
  final AuthEnum status;
  MainFailures? error;
  UserModel? model;
  int second;

  EmailSendState(
      {required this.status, this.error, this.model, required this.second});

  @override
  List<Object?> get props => [status, error, model];

  EmailSendState copyWith({
    AuthEnum? status,
    MainFailures? error,
    UserModel? model,
    int? second,
  }) {
    return EmailSendState(
      status: status ?? this.status,
      error: error ?? this.error,
      model: model ?? this.model,
      second: second ?? this.second,
    );
  }
}

class EmailSendInitial extends EmailSendState {
  EmailSendInitial(
      {required AuthEnum status,
      required MainFailures? error,
      required int second,
      required UserModel? model})
      : super(status: AuthEnum.initial, model: null, error: null, second: 30);
}
