part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCurrentUser extends UserEvent {
  final String id;
  bool shoudReload;
  FetchCurrentUser({required this.id, this.shoudReload = false});
}

class RemovePrfileImage extends UserEvent {}

class ChangeProfilePic extends UserEvent {}
