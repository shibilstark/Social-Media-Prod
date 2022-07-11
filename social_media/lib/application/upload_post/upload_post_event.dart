part of 'upload_post_bloc.dart';

abstract class UploadPostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UploadPost extends UploadPostEvent {
  final PostModel postModel;
  UploadPost({required this.postModel});
  @override
  List<Object> get props => [postModel];
}
