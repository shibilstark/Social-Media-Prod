import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/application/current_user/user_state_enum/user_state_enum.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/profile_feed/profile_feed_model.dart';
import '../../infrastructure/user_services/user_repository.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

@injectable
class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  final UserRepo _userRepo;
  CurrentUserBloc(this._userRepo)
      : super(CurrentUserInitial(
            data: null, failure: null, status: UserStatesValues.initial)) {
    on<FetchUser>((event, emit) async {
      if (state.data?.user != null && event.shouldLoad == false) {
        emit(state.copyWith(data: state.data));
      } else {
        emit(state.copyWith(status: UserStatesValues.loading));

        final result = await _userRepo.fetchUser(id: event.userId);

        final newState = result.fold(
          (data) {
            return state.copyWith(status: UserStatesValues.success, data: data);
          },
          (failure) {
            return state.copyWith(
                status: UserStatesValues.success,
                failure: MainFailures(
                    failureType: failure.failureType, error: failure.error));
          },
        );

        emit(newState);
      }
    });
  }
}
