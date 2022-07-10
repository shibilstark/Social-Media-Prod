import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/application/accounts/auth_enums/bloc_enums.dart';
import 'package:social_media/domain/db/user_data/user_data.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/infrastructure/accounts/account_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AccountRepo _accountServices;
  LoginBloc(this._accountServices)
      : super(LoginInitial(
          failure: null,
          status: AuthStateValue.initial,
        )) {
    on<LoggedIn>((event, emit) async {
      emit(state.copyWith(status: AuthStateValue.loading));

      final result = await _accountServices.login(
          email: event.email, password: event.password);

      result.fold(
        (model) {
          emit(state.copyWith(status: AuthStateValue.verfiying));

          if (model.isEmailVerified) {
            emit(state.copyWith(status: AuthStateValue.emailVerified));
          } else {
            emit(state.copyWith(status: AuthStateValue.emailNotVerified));
            Fluttertoast.showToast(
                msg:
                    "We Have send an email to ${Global.USER_DATA.email} please check your email and verify");
            _accountServices.sendVerifiacationEmail(
                email: Global.USER_DATA.email);
          }
        },
        (failure) {
          emit(state.copyWith(
            status: AuthStateValue.error,
            failure: MainFailures(
                error: failure.error, failureType: failure.failureType),
          ));
        },
      );
    });

    on<LoggedOut>((event, emit) async {
      emit(state.copyWith(status: AuthStateValue.loading));
      await UserDataStore.clearUserData();
      emit(state.copyWith(status: AuthStateValue.succes));
    });
  }
}
