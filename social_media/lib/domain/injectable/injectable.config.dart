// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../application/auth/auth_bloc.dart' as _i5;
import '../../application/user/user_bloc.dart' as _i10;
import '../../infrastructure/accounts/account_repo.dart' as _i3;
import '../../infrastructure/accounts/account_services.dart' as _i4;
import '../../infrastructure/post/post_repo.dart' as _i6;
import '../../infrastructure/post/post_services.dart' as _i7;
import '../../infrastructure/user_services/user_repository.dart' as _i8;
import '../../infrastructure/user_services/user_services.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AccountRepo>(() => _i4.AccountServices());
  gh.factory<_i5.AuthBloc>(() => _i5.AuthBloc(get<_i3.AccountRepo>()));
  gh.lazySingleton<_i6.PostRepo>(() => _i7.PostServices());
  gh.lazySingleton<_i8.UserRepo>(() => _i9.UserServices());
  gh.factory<_i10.UserBloc>(() => _i10.UserBloc(get<_i8.UserRepo>()));
  return get;
}
