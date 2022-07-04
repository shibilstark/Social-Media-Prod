part of 'verification_bloc.dart';

class VerificationState extends Equatable {
  final AuthEnum status;
  final MainFailures? failure;

  const VerificationState({
    required this.status,
    required this.failure,
  });

  @override
  List<Object?> get props => [status, failure];

  VerificationState copyWith({
    AuthEnum? status,
    MainFailures? failure,
  }) {
    return VerificationState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}

class VerificationInitial extends VerificationState {
  const VerificationInitial({
    required AuthEnum status,
    MainFailures? failure,
  }) : super(status: AuthEnum.initial, failure: null);

  @override
  List<Object?> get props => [status, failure];
}
