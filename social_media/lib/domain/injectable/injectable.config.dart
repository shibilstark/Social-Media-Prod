// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../application/accounts/create_account/create_account_bloc.dart'
    as _i5;
import '../../application/accounts/login/login_bloc.dart' as _i6;
import '../../application/accounts/verification/verification_bloc.dart' as _i7;
import '../../infrastructure/accounts/account_repo.dart' as _i3;
import '../../infrastructure/accounts/account_services.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AccountRepo>(() => _i4.AccountServices());
  gh.factory<_i5.CreateAccountBloc>(
      () => _i5.CreateAccountBloc(get<_i3.AccountRepo>()));
  gh.factory<_i6.LoginBloc>(() => _i6.LoginBloc(get<_i3.AccountRepo>()));
  gh.factory<_i7.VerificationBloc>(
      () => _i7.VerificationBloc(get<_i3.AccountRepo>()));
  return get;
}
