import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/domain/models/profile_feed/profile_feed_model.dart';
import 'package:social_media/infrastructure/post/post_repo.dart';
import 'package:social_media/infrastructure/post/post_services.dart';
import 'package:social_media/infrastructure/user_services/user_repository.dart';
import 'package:social_media/infrastructure/user_services/user_services.dart';
import 'package:social_media/presentation/screens/home/home_screen.dart';

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
      // log("user state loading");

      final result = await _userRepo.fetchUser(id: event.id);

      final newState = result.fold(
        (data) {
          // log("user state success");
          return FetchCurrentUserSuccess(data: data);
        },
        (failure) {
          return FetchCurrentUserError(failure: failure);
        },
      );

      emit(newState);
      // }
    });
    on<RemovePrfileImage>((event, emit) async {
      // if ((state is UserInitial && !event.shoudReload) ||
      //     (state is! UserInitial && event.shoudReload)) {
      emit(RemoveProfileLoading());

      final result = await _userRepo.removeProfileImage();

      final newState = result.fold(
        (status) {
          Fluttertoast.showToast(msg: "Profile Removed Successfully");
          return RemoveProfileSuccess();
        },
        (failure) {
          Fluttertoast.showToast(
              msg: "Something went wrong please try again later");
          return RemoveProfileError(failure: failure);
        },
      );

      emit(newState);

      // }
    });
    on<ChangeProfilePic>((event, emit) async {
      emit(UserStateLoading());

      final PostRepo _postRepo = PostServices();

      final result = await _postRepo.pickPost(type: PostType.image);

      final newState = await result.fold((model) async {
        final mewResult = await _userRepo.changeProfilePic(pic: model!.file);

        final UserState lastState = mewResult.fold((status) {
          return ChangeProfilePicSuccess();
        }, (failure) {
          return ChangeProfilPicError(failure: failure);
        });

        return lastState;
      }, (failure) {
        emit(ChangeProfilPicError(failure: failure));
      });

      emit(newState!);
    });
  }
}
