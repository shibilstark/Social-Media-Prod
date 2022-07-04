import 'package:flutter/material.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/domain/db/user_data/user_data.dart';
import 'package:social_media/domain/global/global_variables.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final data = (await UserDataStore.getUserData());

      if (data == null) {
        Navigator.of(context).pushReplacementNamed("/login");
      } else {
        Global.USER_DATA = data;
        Navigator.of(context).pushReplacementNamed("/home");
      }
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
