import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/application/user/user_enums/user_enums.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc()
      : super(UserInitial(
            failure: null, model: null, status: UserEnums.initial)) {
    on<GetCurrenUser>((event, emit) {
      emit(state.copyWith(status: UserEnums.loading));
    });
  }
}
