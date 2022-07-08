import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:social_media/application/current_user/user_state_enum/user_state_enum.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/profile_feed/profile_feed_model.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  CurrentUserBloc()
      : super(CurrentUserInitial(
            data: null, failure: null, status: UserStateEnum.initial)) {
    on<FetchUser>((event, emit) {});
  }
}
