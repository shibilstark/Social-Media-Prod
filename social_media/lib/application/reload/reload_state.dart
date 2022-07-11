part of 'reload_bloc.dart';

abstract class ReloadState extends Equatable {
  const ReloadState();
  
  @override
  List<Object> get props => [];
}

class ReloadInitial extends ReloadState {}
