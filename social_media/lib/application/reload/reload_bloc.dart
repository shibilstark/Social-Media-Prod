import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'reload_event.dart';
part 'reload_state.dart';

class ReloadBloc extends Bloc<ReloadEvent, ReloadState> {
  ReloadBloc() : super(ReloadInitial()) {
    on<ReloadUser>((event, emit) {});
  }
}
