import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/application/accounts/auth_enums/bloc_enums.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/infrastructure/accounts/account_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AccountRepo _accountServices;
  LoginBloc(this._accountServices)
      : super(const LoginInitial(
          failure: null,
          status: AuthEnum.initial,
        )) {
    on<LoggedIn>((event, emit) async {
      emit(state.copyWith(status: AuthEnum.loading));

      final result = await _accountServices.login(
          email: event.email, password: event.password);

      result.fold(
        (model) {
          emit(state.copyWith(status: AuthEnum.verfiying));

          if (model.isEmailVerified) {
            emit(state.copyWith(status: AuthEnum.emailVerified));
          } else {
            emit(state.copyWith(status: AuthEnum.emailNotVerified));
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
      await _accountServices.logOut();
      emit(state.copyWith(status: AuthEnum.succes));
    });
  }
}
