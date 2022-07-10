part of 'new_post_bloc.dart';

abstract class NewPostEvent extends Equatable {}

class PickPost extends NewPostEvent {
  final String type;
  PickPost({required this.type});

  @override
  List<Object?> get props => [type];
}

class UploadPost extends NewPostEvent {
  final PostModel model;
  UploadPost({required this.model});

  @override
  List<Object?> get props => [model];
}
