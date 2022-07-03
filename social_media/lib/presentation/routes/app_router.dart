import 'package:flutter/material.dart';
import 'package:social_media/presentation/screens/home/home_screen.dart';
import 'package:social_media/presentation/screens/login/loading_for_mail_screen.dart';
import 'package:social_media/presentation/screens/login/login_screen.dart';
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
      // case "/profile":
      //   return MaterialPageRoute(builder: (_) => ProfileScreen());

      default:
        // return MaterialPageRoute(builder: (_) => SplashScreen());
        return null;
    }
  }
}