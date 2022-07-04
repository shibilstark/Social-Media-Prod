import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media/application/accounts/auth_enums/bloc_enums.dart';
import 'package:social_media/application/accounts/verification/verification_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/presentation/widgets/gap.dart';
import 'package:social_media/utility/util.dart';

class LoadingForMailScreen extends StatelessWidget {
  const LoadingForMailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [primaryBlue, primary, primaryBlue],
              )),
              child: Center(
                child: Padding(
                  padding: constPadding,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 250.sm,
                        child:
                            // state.status == AuthEnum.sendingEmail
                            //     ?
                            Column(
                          children: [
                            Text(
                              "Conform Email",
                              style: TextStyle(
                                  fontSize: 25.sm,
                                  fontWeight: FontWeight.bold,
                                  color: pureWhite),
                            ),

                            // Lottie.asset(
                            //     "assets/lottie/lf30_editor_vw2ysryk.json"),
                            SvgPicture.asset(
                              "assets/svg/undraw_opened_re_i38e.svg",
                              height: 400.sm,
                            )
                          ],
                        ),
                      ),
                      Gap(
                        H: 30.sm,
                      ),
                      BlocConsumer<VerificationBloc, VerificationState>(
                        listener: (context, state) {
                          if (state.status == AuthEnum.emailVerified) {
                            Navigator.of(context).pushReplacementNamed("/home");
                          }

                          if (state.status == AuthEnum.error) {
                            Util.showNormalCoolAlerr(
                                context: context,
                                type: CoolAlertType.error,
                                okString: "Close",
                                text: state.failure!.error);
                          }
                          if (state.status == AuthEnum.emailSend) {
                            Fluttertoast.showToast(
                                msg: "We send an email to your account");
                          }
                        },
                        builder: (context, state) {
                          return Column(
                            children: [
                              SizedBox(
                                width: 300.sm,
                                height: 50.sm,
                                child: ElevatedButton(
                                    onPressed: () {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        context
                                            .read<VerificationBloc>()
                                            .add(Verify());
                                      });
                                    },
                                    child: Text(
                                      "Verify",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                              ),
                              Gap(
                                H: 30.sm,
                              ),
                              SizedBox(
                                width: 300.sm,
                                height: 50.sm,
                                child: ElevatedButton(
                                    onPressed: () {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        context
                                            .read<VerificationBloc>()
                                            .add(ResendEmail());
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Send Verification Email",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.sm),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    size: 30.sm,
                    color: pureWhite,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
