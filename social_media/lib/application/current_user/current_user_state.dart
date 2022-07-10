// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'current_user_bloc.dart';

class CurrentUserState extends Equatable {
  final String status;
  final MainFailures? failure;
  final ProfileFeedModel? data;

  CurrentUserState(
      {required this.status, required this.failure, required this.data});

  @override
  List<Object?> get props => [status, failure, data];

  CurrentUserState copyWith({
    String? status,
    MainFailures? failure,
    ProfileFeedModel? data,
  }) {
    return CurrentUserState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      data: data ?? this.data,
    );
  }
}

class CurrentUserInitial extends CurrentUserState {
  final String status;
  final MainFailures? failure;
  final ProfileFeedModel? data;
  CurrentUserInitial(
      {required this.status, required this.failure, required this.data})
      : super(data: data, failure: failure, status: status);

  @override
  List<Object?> get props => [status, data, failure];
}
