import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/application/accounts/auth_enums/bloc_enums.dart';
import 'package:social_media/domain/db/user_data/user_data.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/infrastructure/accounts/account_repo.dart';

part 'verification_event.dart';
part 'verification_state.dart';

@injectable
class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final AccountRepo _accountRepo;
  VerificationBloc(this._accountRepo)
      : super(VerificationInitial(status: AuthEnum.initial, failure: null)) {
    on<Verify>((event, emit) async {
      emit(state.copyWith(status: AuthEnum.loading));

      final userData = (await UserDataStore.getUserData());

      final result = await _accountRepo.verifyEmail(email: userData!.email);

      result.fold(
        (status) {
          if (status) {
            emit(state.copyWith(status: AuthEnum.emailVerified));
          } else {
            emit(state.copyWith(status: AuthEnum.emailNotVerified));
            Fluttertoast.showToast(
                msg: "Email Not Verified yet plaese Verify first");
            // _accountRepo.sendVerifiacationEmail(email: Global.USER_DATA.email);
          }
        },
        (failure) {
          emit(state.copyWith(
              status: AuthEnum.error,
              failure: MainFailures(
                  failureType: failure.failureType, error: failure.error)));
        },
      );
    });

    on<ResendEmail>((event, emit) async {
      emit(state.copyWith(status: AuthEnum.loading));

      final userData = (await UserDataStore.getUserData())!;

      final result =
          await _accountRepo.sendVerifiacationEmail(email: userData.email);

      result.fold(
        (status) {
          if (status) {
            emit(state.copyWith(status: AuthEnum.emailSend));
          }
        },
        (failure) {
          emit(state.copyWith(
              status: AuthEnum.error,
              failure: MainFailures(
                  failureType: failure.failureType, error: failure.error)));
        },
      );
    });
  }
}
