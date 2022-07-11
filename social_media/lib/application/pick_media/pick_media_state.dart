part of 'pick_media_bloc.dart';

class PickMediaState extends Equatable {
  const PickMediaState();

  @override
  List<Object> get props => [];
}

class PickMediaInitial extends PickMediaState {}

class PickMediaLoading extends PickMediaState {}

class PickMediaSuccess extends PickMediaState {
  final PostTypeModel postTypeModel;
  const PickMediaSuccess({required this.postTypeModel});
  @override
  List<Object> get props => [postTypeModel];
}

class PickMediaError extends PickMediaState {
  final MainFailures failure;
  const PickMediaError({required this.failure});
  @override
  List<Object> get props => [failure];
}
