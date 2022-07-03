// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../application/authentication/create_account/create_account_bloc.dart'
    as _i5;
import '../../application/authentication/email_send/email_send_bloc.dart'
    as _i6;
import '../../application/authentication/login/login_account_bloc.dart' as _i7;
import '../../infrastructure/account_services/account_repository.dart' as _i4;
import '../../infrastructure/account_services/account_services.dart'
    as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AccountServices>(() => _i4.UsersAccountRepository());
  gh.factory<_i5.CreateAccountBloc>(
      () => _i5.CreateAccountBloc(get<_i3.AccountServices>()));
  gh.factory<_i6.EmailSendBloc>(
      () => _i6.EmailSendBloc(get<_i3.AccountServices>()));
  gh.factory<_i7.LoginAccountBloc>(
      () => _i7.LoginAccountBloc(get<_i3.AccountServices>()));
  return get;
}
