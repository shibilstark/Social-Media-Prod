import 'dart:ui';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media/application/accounts/auth_enums/bloc_enums.dart';
import 'package:social_media/application/accounts/login/login_bloc.dart';
import 'package:social_media/application/theme/theme_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/presentation/shimmers/profile_part_shimmer.dart';
import 'package:social_media/presentation/widgets/gap.dart';
import 'package:social_media/utility/util.dart';
import '../../../core/constants/enums.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});

    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.sm),
          // bottomLeft: Radius.circular(40.sm)
        ),
        child: Drawer(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).popAndPushNamed("/profile");
                  },
                  child: Container(
                    padding: EdgeInsets.all(20.sm),
                    color: primaryBlue,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30.sm,
                          backgroundColor: secondaryBlue,
                          backgroundImage:
                              AssetImage("assets/dummy/dummyDP.png"),
                        ),
                        Gap(
                          W: 10.sm,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              // user == null ? "" : user.name,
                              "JhoneFeverough",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontSize: 17.sm,
                                      fontWeight: FontWeight.w500,
                                      color: pureWhite),
                            ),
                            Gap(
                              H: 3.sm,
                            ),
                            Text(
                              // user == null ? "" : user.email,
                              "jhonefeverogh@gmail.com",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: pureWhite.withOpacity(0.7),
                                    fontSize: 12.sm,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.sm),
                  child: Column(
                    children: [
                      BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, state) {
                          return SizedBox(
                            height: 35.sm,
                            child: Row(
                              children: [
                                IconTheme(
                                    data: Theme.of(context).iconTheme,
                                    child: Icon(
                                      state.isDark
                                          ? Icons.light_mode
                                          : Icons.dark_mode,
                                      size: 20,
                                    )),
                                Gap(
                                  W: 10.sm,
                                ),
                                Text(
                                  state.isDark
                                      ? "Back to Light"
                                      : "Switch to Dark",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: 18.sm,
                                          fontWeight: FontWeight.w400),
                                ),
                                const Spacer(),
                                Builder(builder: (context) {
                                  bool sValue = state.isDark ? true : false;
                                  return Switch(
                                      value: sValue,
                                      onChanged: (value) async {
                                        if (value) {
                                          BlocProvider.of<ThemeBloc>(context)
                                              .add(ChangeTheme(
                                                  changeTo: MyThemeMode.dark));
                                        } else {
                                          BlocProvider.of<ThemeBloc>(context)
                                              .add(ChangeTheme(
                                                  changeTo: MyThemeMode.light));
                                        }
                                      });
                                }),
                              ],
                            ),
                          );
                        },
                      ),
                      const Divider(),
                      const MenuTiles(
                        icon: Icons.settings,
                        title: "Settings",
                        whereTo: Scaffold(),
                      ),
                      const Divider(),
                      const MenuTiles(
                        icon: Icons.privacy_tip,
                        title: "Privacy Policy",
                        whereTo: Scaffold(),
                      ),
                      const Divider(),
                      const MenuTiles(
                        icon: Icons.gavel,
                        title: "Terms % Conditions",
                        whereTo: Scaffold(),
                      ),
                      const Divider(),
                      const MenuTiles(
                        icon: Icons.info,
                        title: "About",
                        whereTo: Scaffold(),
                      ),
                      const Divider(),
                      const MenuTiles(
                        icon: Icons.redeem,
                        title: "Invite a Friend",
                        whereTo: Scaffold(),
                      ),
                      const Divider(),
                      const MenuTiles(
                        icon: Icons.spoke,
                        title: "Connect with us",
                        whereTo: Scaffold(),
                      ),
                      const Divider(),
                      LogOutTile(),
                      const Divider(
                        color: primary,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LogOutTile extends StatelessWidget {
  const LogOutTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (state.status == AuthEnum.succes) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
      }
    }, builder: (context, state) {
      return Builder(
        builder: (context) {
          return GestureDetector(
              onTap: () async {
                await CoolAlert.show(
                    showCancelBtn: true,
                    backgroundColor: primary,
                    context: context,
                    type: CoolAlertType.warning,
                    text: "Are you sure",
                    confirmBtnText: state.status == AuthEnum.loading
                        ? "loggin Out"
                        : "Log Out",
                    onConfirmBtnTap: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        context.read<LoginBloc>().add(LoggedOut());
                        Fluttertoast.showToast(msg: "Logged Out Seccessfully");
                      });
                    });
              },
              child: SizedBox(
                height: 35.sm,
                child: Row(
                  children: [
                    IconTheme(
                        data: Theme.of(context).iconTheme,
                        child: Icon(
                          Icons.logout,
                          size: 20,
                        )),
                    Gap(
                      W: 10.sm,
                    ),
                    Text(
                      "Log Out",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 18.sm, fontWeight: FontWeight.w400),
                      //   ),
                    ),
                  ],
                ),
              ));
        },
      );
    });
  }
}

class MenuTiles extends StatelessWidget {
  const MenuTiles(
      {Key? key,
      required this.icon,
      required this.title,
      required this.whereTo})
      : super(key: key);

  final String title;
  final IconData icon;
  final Scaffold whereTo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => whereTo));
      },
      child: SizedBox(
        height: 35.sm,
        child: Row(
          children: [
            IconTheme(
                data: Theme.of(context).iconTheme,
                child: Icon(
                  icon,
                  size: 20,
                )),
            Gap(
              W: 10.sm,
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 18.sm, fontWeight: FontWeight.w400),
              //   ),
            ),
          ],
        ),
      ),
    );
  }
}
