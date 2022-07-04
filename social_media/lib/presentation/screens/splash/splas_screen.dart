import 'package:flutter/material.dart';
import 'package:social_media/core/colors/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(seconds: 1));
      Navigator.of(context).pushReplacementNamed("/login");
    });

    return const Scaffold(
      backgroundColor: primaryBlue,
      body: Center(
          child: CircularProgressIndicator(
        color: secondaryBlue,
      )),
    );
  }
}
