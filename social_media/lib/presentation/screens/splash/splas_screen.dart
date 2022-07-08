import 'dart:developer';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/application/accounts/auth_enums/bloc_enums.dart';
import 'package:social_media/application/accounts/verification/verification_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/domain/db/user_data/user_data.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/utility/util.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VerificationBloc>().add(Verify());
    });
    return Scaffold(
      backgroundColor: primaryBlue,
      body: BlocConsumer<VerificationBloc, VerificationState>(
        listener: (context, state) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
            final data = await UserDataStore.getUserData();
            if (data == null) {
              log("credential not found");
              Navigator.of(context).pushReplacementNamed("/login");
            } else {
              Global.USER_DATA = data;
              if (state.status == AuthEnum.emailNotVerified) {
                log("emial not verified");
                Navigator.of(context).pushReplacementNamed("verifyemail");
              }
              if (state.status == AuthEnum.emailVerified &&
                  Global.USER_DATA.email != "") {
                log("emial  verified");
                Navigator.of(context).pushReplacementNamed("/home");
              }
              if (state.status == AuthEnum.error) {
                Util.showNormalCoolAlerr(
                    context: context,
                    type: CoolAlertType.error,
                    okString: "OK",
                    text: state.failure!.error);
              }
            }
          });
        },
        builder: (context, state) {
          return const Center(
              child: CircularProgressIndicator(
            color: secondaryBlue,
          ));
        },
      ),
    );
  }
}
