part of 'reload_bloc.dart';

abstract class ReloadEvent extends Equatable {
  const ReloadEvent();

  @override
  List<Object> get props => [];
}

class ReloadUser extends ReloadEvent {
  final BuildContext context;
  ReloadUser({required this.context});

  @override
  List<Object> get props => [];
}
