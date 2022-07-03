import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/application/authentication/auth_enums/bloc_enums.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/presentation/widgets/gap.dart';
import 'package:social_media/utility/util.dart';

import '../../../application/authentication/email_send/email_send_bloc.dart';

class LoadingForMailScreen extends StatelessWidget {
  const LoadingForMailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<EmailSendBloc, EmailSendState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Stack(
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
                      child: BlocConsumer<EmailSendBloc, EmailSendState>(
                        listener: (context, state) async {
                          if (state.status == AuthEnum.emailNotSend ||
                              state.status == AuthEnum.error) {
                            Util.showNormalCoolAlerr(
                                context: context,
                                type: CoolAlertType.error,
                                okString: "OK",
                                text: state.error!.error);
                          }

                          if (state.status == AuthEnum.emailVerified) {
                            await Util.showToast(
                                message: "Email Verified Successfully");
                            Navigator.of(context).pushReplacementNamed('/home');
                          }
                        },
                        builder: (context, state) {
                          return Column(
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
                              Column(
                                children: [
                                  SizedBox(
                                    width: 300.sm,
                                    height: 50.sm,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            context
                                                .read<EmailSendBloc>()
                                                .add(EmailVerify());
                                          });
                                        },
                                        child: Text(
                                          state.status == AuthEnum.verfiying
                                              ? "Verifying"
                                              : "Verify",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
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
                                              .addPostFrameCallback(
                                                  (timeStamp) {
                                            context
                                                .read<EmailSendBloc>()
                                                .add(EmailSend());
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
                              ),
                            ],
                          );
                        },
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
            );
          },
        ),
      ),
    );
  }
}
