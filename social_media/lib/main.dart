import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:social_media/application/auth/auth_bloc.dart';
import 'package:social_media/application/pick_media/pick_media_bloc.dart';
import 'package:social_media/application/theme/theme_bloc.dart';
import 'package:social_media/application/upload_post/upload_post_bloc.dart';
import 'package:social_media/application/user/user_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/themes/themes.dart';
import 'package:social_media/domain/db/user_data/user_data.dart';
import 'package:social_media/domain/injectable/injectable.dart';
import 'package:social_media/presentation/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  await Firebase.initializeApp();
  await Hive.initFlutter();
  await configureInjection();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: softBlack,
  ));

  if (!Hive.isAdapterRegistered(UserDataAdapter().typeId)) {
    Hive.registerAdapter(UserDataAdapter());
  }

  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp()),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<UserBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<UploadPostBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<PickMediaBloc>(),
        ),
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 800),
          splitScreenMode: true,
          minTextAdapt: true,
          builder: (context, child) {
            return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return MaterialApp(
                  theme: state.isDark ? MyTheme.darkTheme : MyTheme.lightTheme,
                  debugShowCheckedModeBanner: false,
                  // showPerformanceOverlay: true,
                  onGenerateRoute: _appRouter.onGenerateRoute,
                );
              },
            );
          }),
    );
  }
}
