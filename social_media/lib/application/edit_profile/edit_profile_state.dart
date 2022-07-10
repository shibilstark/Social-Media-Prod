// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  final String status;
  final EditProfileModel? model;
  final MainFailures? failure;

  EditProfileState(
      {required this.status, required this.model, required this.failure});

  @override
  List<Object?> get props => [status, failure, model];

  EditProfileState copyWith({
    String? status,
    EditProfileModel? model,
    MainFailures? failure,
  }) {
    return EditProfileState(
      status: status ?? this.status,
      model: model ?? this.model,
      failure: failure ?? this.failure,
    );
  }
}

class EditProfileInitial extends EditProfileState {
  EditProfileInitial(
      {required String status,
      required EditProfileModel? model,
      required MainFailures? failure})
      : super(status: status, model: model, failure: failure);

  @override
  List<Object?> get props => [status, failure, model];
}
