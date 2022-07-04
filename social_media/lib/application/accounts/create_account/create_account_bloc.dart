import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/application/accounts/auth_enums/bloc_enums.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/infrastructure/accounts/account_repo.dart';

part 'create_account_event.dart';
part 'create_account_state.dart';

@injectable
class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
  final AccountRepo _accountServices;
  CreateAccountBloc(this._accountServices)
      : super(CreateAccountInitial(
            state: AuthEnum.initial, faulure: null, model: null)) {
    on<AccountCreated>((event, emit) async {
      emit(state.copyWith(
        state: AuthEnum.loading,
      ));

      final response = await _accountServices.createAccount(
          model: event.model, password: event.password);

      response.fold(
        (success) {
          emit(state.copyWith(state: AuthEnum.succes, model: success));
        },
        (failure) {
          emit(state.copyWith(
              state: AuthEnum.error,
              failure: MainFailures(
                  failureType: failure.failureType, error: failure.error)));
        },
      );
    });
  }
}
