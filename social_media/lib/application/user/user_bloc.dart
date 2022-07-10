import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/profile_feed/profile_feed_model.dart';
import 'package:social_media/infrastructure/user_services/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepo _userRepo;

  UserBloc(this._userRepo) : super(UserInitial()) {
    on<FetchCurrentUser>((event, emit) async {
      // if ((state is UserInitial && !event.shoudReload) ||
      //     (state is! UserInitial && event.shoudReload)) {
      emit(UserStateLoading());

      final result = await _userRepo.fetchUser(id: event.id);

      final newState = result.fold(
        (data) {
          return FetchCurrentUserSuccess(data: data);
        },
        (failure) {
          return FetchCurrentUserError(failure: failure);
        },
      );

      emit(newState);
      // }
    });
  }
}
