import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:injectable/injectable.dart';
import 'package:social_media/application/authentication/auth_enums/bloc_enums.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/infrastructure/account_services/account_services.dart';
import 'package:video_player/video_player.dart';
import '../../../domain/models/user_model/user_model.dart';
part 'email_send_event.dart';
part 'email_send_state.dart';

@injectable
class EmailSendBloc extends Bloc<EmailSendEvent, EmailSendState> {
  AccountServices _accountServices;
  EmailSendBloc(this._accountServices)
      : super(EmailSendInitial(
            model: null, status: AuthEnum.initial, error: null, second: 10)) {
    on<EmailSend>((event, emit) async {
      emit(state.copyWith(status: AuthEnum.sendingEmail));

      final result = await _accountServices.sendVerificationEmail();

      result.fold(
        (success) {
          if (success) {
            log("Email send success");
            state.copyWith(status: AuthEnum.emailVerified);
          } else {
            log("Email send error");
            state.copyWith(
              status: AuthEnum.emailNotVerified,
            );
          }
        },
        (failure) {
          state.copyWith(
              status: AuthEnum.emailNotSend,
              error: MainFailures(
                  failureType: failure.failureType, error: failure.error));
        },
      );
    });

    on<EmailVerify>((event, emit) async {
      emit(state.copyWith(status: AuthEnum.verfiying));

      final result = await _accountServices.verifyEmail();

      result.fold(
        (status) {
          if (status) {
            emit(state.copyWith(status: AuthEnum.emailVerified));
          } else {
            emit(state.copyWith(status: AuthEnum.emailNotVerified));
          }
        },
        (failure) {
          emit(state.copyWith(
              status: AuthEnum.error,
              error: MainFailures(
                  failureType: failure.failureType, error: failure.error)));
        },
      );
    });
  }
}
