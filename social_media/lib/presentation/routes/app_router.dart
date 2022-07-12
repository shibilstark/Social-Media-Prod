import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/presentation/screens/edit_profile/edit_profile_screen.dart';
import 'package:social_media/presentation/screens/home/home_screen.dart';
import 'package:social_media/presentation/screens/login/login_screen.dart';
import 'package:social_media/presentation/screens/media_view/media_view_screen.dart';
import 'package:social_media/presentation/screens/new_post_screen/upload_post.dart';
import 'package:social_media/presentation/screens/profile/profile_screen.dart';
import 'package:social_media/presentation/screens/signup/signup_screen.dart';
import 'package:social_media/presentation/screens/splash/splas_screen.dart';
import 'package:social_media/presentation/settings/settings_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routSettings) {
    switch (routSettings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case "/login":
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case "/profile":
        return MaterialPageRoute(builder: (_) => ProfileScreen());

      case "/signup":
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case "/home":
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case "/settings":
        return MaterialPageRoute(builder: (_) => SettingsScreen());

      case "/uploadpost":
        return MaterialPageRoute(builder: (_) => const UploadPostScreen());
      // case "/editprofile":
      //   return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case "/onlinevideoplayer":
        final args = routSettings.arguments as ScreenArgs;
        return MaterialPageRoute(
            builder: (_) => SeePostVideoOnline(
                  video: args.args['path'],
                ));
      case "/offlinevideoplayer":
        final args = routSettings.arguments as ScreenArgs;
        return MaterialPageRoute(
            builder: (_) => SeePostVideoOffline(
                  video: args.args['path'],
                ));
      case "/seeimageonline":
        final args = routSettings.arguments as ScreenArgs;
        return MaterialPageRoute(
            builder: (_) => SeePostImageNetwork(
                  image: args.args['path'],
                ));
      case "/seeassetimage":
        final args = routSettings.arguments as ScreenArgs;
        return MaterialPageRoute(
            builder: (_) => SeeAssetImage(
                  image: args.args['path'],
                ));
      case "/seeimageoffline":
        final args = routSettings.arguments as ScreenArgs;
        return MaterialPageRoute(
            builder: (_) => SeePostImageOffline(
                  image: args.args['path'],
                ));

      // case "/profile":
      //   return MaterialPageRoute(builder: (_) => ProfileScreen());

      default:
        // return MaterialPageRoute(builder: (_) => SplashScreen());
        return null;
    }
  }
}

class ScreenArgs {
  final Map<String, dynamic> args;
  ScreenArgs({required this.args});
}
