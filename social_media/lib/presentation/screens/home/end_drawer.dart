import 'dart:ui';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/theme/theme_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/presentation/widgets/gap.dart';
import 'package:social_media/utility/util.dart';
import '../../../core/constants/enums.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ClipRRect(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.sm, horizontal: 20.sm),
            child: Container(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.of(context).popAndPushNamed("/profile");
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25.sm,
                              backgroundImage:
                                  const AssetImage("assets/dummy/dummyDP.png"),
                            ),
                            Gap(
                              W: 10.sm,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "   model!.name",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontSize: 17.sm,
                                          fontWeight: FontWeight.w500),
                                ),
                                Gap(
                                  H: 3.sm,
                                ),
                                Text(
                                  "{   model.email}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: grey,
                                        fontSize: 12.sm,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Gap(
                        H: 5.sm,
                      ),
                      Divider(
                        color: primary,
                        thickness: 2.sm,
                      ),
                      Column(
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
                                              BlocProvider.of<ThemeBloc>(
                                                      context)
                                                  .add(ChangeTheme(
                                                      changeTo:
                                                          MyThemeMode.dark));
                                            } else {
                                              BlocProvider.of<ThemeBloc>(
                                                      context)
                                                  .add(ChangeTheme(
                                                      changeTo:
                                                          MyThemeMode.light));
                                            }
                                          });
                                    }),
                                  ],
                                ),
                              );
                            },
                          ),
                          const Divider(
                            color: primary,
                          ),
                          const MenuTiles(
                            icon: Icons.settings,
                            title: "Settings",
                            whereTo: Scaffold(),
                          ),
                          const Divider(
                            color: primary,
                          ),
                          const MenuTiles(
                            icon: Icons.privacy_tip,
                            title: "Privacy Policy",
                            whereTo: Scaffold(),
                          ),
                          const Divider(
                            color: primary,
                          ),
                          const MenuTiles(
                            icon: Icons.gavel,
                            title: "Terms % Conditions",
                            whereTo: Scaffold(),
                          ),
                          const Divider(
                            color: primary,
                          ),
                          const MenuTiles(
                            icon: Icons.info,
                            title: "About",
                            whereTo: Scaffold(),
                          ),
                          const Divider(
                            color: primary,
                          ),
                          const MenuTiles(
                            icon: Icons.redeem,
                            title: "Invite a Friend",
                            whereTo: Scaffold(),
                          ),
                          const Divider(
                            color: primary,
                          ),
                          const MenuTiles(
                            icon: Icons.spoke,
                            title: "Connect with us",
                            whereTo: Scaffold(),
                          ),
                          const Divider(
                            color: primary,
                          ),
                          Builder(builder: (context) {
                            return GestureDetector(
                                onTap: () {
                                  Util.showLogoutCoolAlert(
                                      context: context,
                                      type: CoolAlertType.warning,
                                      okString: "Sure",
                                      text: "Do you want to logout");
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontSize: 18.sm,
                                                fontWeight: FontWeight.w400),
                                        //   ),
                                      ),
                                    ],
                                  ),
                                ));
                          }),
                          const Divider(
                            color: primary,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
