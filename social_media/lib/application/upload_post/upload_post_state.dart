part of 'upload_post_bloc.dart';

abstract class UploadPostState extends Equatable {
  @override
  List<Object> get props => [];
}

class UploadPostInitial extends UploadPostState {}

class UploadPostLoading extends UploadPostState {}

class UploadPostSuccess extends UploadPostState {
  final bool status;
  UploadPostSuccess({required this.status});
}

class UploadPostError extends UploadPostState {
  final MainFailures failure;
  UploadPostError({required this.failure});
}
