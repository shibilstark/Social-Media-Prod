import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/application/user/user_enums/user_enums.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/infrastructure/user/user_repo.dart';
import 'package:social_media/infrastructure/user/user_servieces.dart';

part 'user_event.dart';
part 'user_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepo _userServices;
  UserBloc(this._userServices)
      : super(UserInitial(
            failure: null, model: null, status: UserEnums.initial)) {
    on<GetCurrenUser>((event, emit) async {
      emit(state.copyWith(status: UserEnums.loading));

      final responseData = await _userServices.getCurrentUser();

      responseData.fold(
        (model) {
          emit(state.copyWith(status: UserEnums.success, model: model));
        },
        (failure) {
          emit(state.copyWith(
              status: UserEnums.error,
              failure: MainFailures(
                  failureType: failure.failureType, error: failure.error)));
        },
      );
    });
  }
}
