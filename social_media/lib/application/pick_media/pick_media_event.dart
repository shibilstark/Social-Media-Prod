part of 'pick_media_bloc.dart';

abstract class PickMediaEvent extends Equatable {
  const PickMediaEvent();

  @override
  List<Object> get props => [];
}

class PickMedia extends PickMediaEvent {
  final String type;
  PickMedia({required this.type});
  @override
  List<Object> get props => [type];
}

class PickCoverImage extends PickMediaEvent {
  final String type;
  PickCoverImage({required this.type});
  @override
  List<Object> get props => [type];
}

class PickProfileImage extends PickMediaEvent {
  final String type;
  PickProfileImage({required this.type});
  @override
  List<Object> get props => [type];
}
