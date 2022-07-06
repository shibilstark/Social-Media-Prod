import 'package:flutter/material.dart';
import 'package:social_media/presentation/screens/home/home_screen.dart';
import 'package:social_media/presentation/screens/login/loading_for_mail_screen.dart';
import 'package:social_media/presentation/screens/login/login_screen.dart';
import 'package:social_media/presentation/screens/new_post/new_post_screen.dart';
import 'package:social_media/presentation/screens/profile/profile_screen.dart';
import 'package:social_media/presentation/screens/seepost_screen/seeepost_screen.dart';
import 'package:social_media/presentation/screens/signup/signup_screen.dart';
import 'package:social_media/presentation/screens/splash/splas_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routSettings) {
    switch (routSettings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case "/login":
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case "/signup":
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case "/home":
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case "/verifyemail":
        return MaterialPageRoute(builder: (_) => LoadingForMailScreen());
      case "/profile":
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case "/newpost":
        return MaterialPageRoute(builder: (_) => NewPostScreen());
      case "/viewimage":
        final seePostImage = routSettings.arguments as ScreenArgs;
        return MaterialPageRoute(
            builder: (_) => SeePostImage(image: seePostImage.args));
      case "/viewvideo":
        final seePostVideo = routSettings.arguments as ScreenArgs;
        return MaterialPageRoute(
            builder: (_) => SeePostVideo(video: seePostVideo.args));

      default:
        // return MaterialPageRoute(builder: (_) => SplashScreen());
        return null;
    }
  }
}

class ScreenArgs {
  final String args;
  ScreenArgs({required this.args});
}
