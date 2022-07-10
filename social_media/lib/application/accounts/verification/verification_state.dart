part of 'verification_bloc.dart';

class VerificationState extends Equatable {
  final String status;
  final MainFailures? failure;

  const VerificationState({
    required this.status,
    required this.failure,
  });

  @override
  List<Object?> get props => [status, failure];

  VerificationState copyWith({
    String? status,
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
    required String status,
    MainFailures? failure,
  }) : super(status: AuthStateValue.initial, failure: null);

  @override
  List<Object?> get props => [status, failure];
}
