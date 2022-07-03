import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/application/authentication/auth_enums/bloc_enums.dart';

import 'package:social_media/application/theme/theme_bloc.dart';
import 'package:social_media/domain/db/user_cred/user_cred.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/infrastructure/account_services/account_services.dart';

part 'login_account_event.dart';
part 'login_account_state.dart';

@injectable
class LoginAccountBloc extends Bloc<LoginAccountEvent, LoginAccountState> {
  final AccountServices _accountServices;
  LoginAccountBloc(this._accountServices)
      : super(const LoginAccountInitial(
          failure: null,
          status: AuthEnum.initial,
        )) {
    on<LoggedIn>((event, emit) async {
      emit(state.copyWith(status: AuthEnum.loading));

      final result = await _accountServices.loginToAccount(
          email: event.email, password: event.password);

      result.fold(
        (success) {
          if (success) {
            emit(state.copyWith(
              status: AuthEnum.emailVerified,
            ));
          } else {
            emit(state.copyWith(
              status: AuthEnum.emailNotVerified,
            ));
          }
        },
        (failure) {
          emit(state.copyWith(
            status: AuthEnum.error,
            failure: MainFailures(
                error: failure.error, failureType: failure.failureType),
          ));
        },
      );
    });

    on<LoggedOut>((event, emit) async {
      emit(state.copyWith(status: AuthEnum.loading));

      await UserCredStore.clearUserCred();
      Global.USER_ID = "";

      emit(state.copyWith(status: AuthEnum.succes));
    });
  }
}
