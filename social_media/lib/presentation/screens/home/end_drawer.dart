import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/theme/theme_bloc.dart';
import 'package:social_media/application/user/user_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/presentation/routes/app_router.dart';
import 'package:social_media/presentation/shimmers/profile_part_shimmer.dart';
import 'package:social_media/presentation/widgets/gap.dart';
import '../../../core/constants/enums.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<UserBloc>().add(FetchCurrentUser(id: Global.USER_DATA.id));
    // });
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.sm),
          // bottomLeft: Radius.circular(40.sm)
        ),
        child: Drawer(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const EndDrawerMiniProfile(),
                  Container(
                    padding: EdgeInsets.all(20.sm),
                    child: Column(
                      children: [
                        ThemModeButton(),
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
                        const LogOutTile(),
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
      ),
    );
  }
}

class ThemModeButton extends StatelessWidget {
  const ThemModeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return SizedBox(
          height: 35.sm,
          child: Row(
            children: [
              IconTheme(
                  data: Theme.of(context).iconTheme,
                  child: Icon(
                    state.isDark ? Icons.light_mode : Icons.dark_mode,
                    size: 20,
                  )),
              Gap(
                W: 10.sm,
              ),
              Text(
                state.isDark ? "Back to Light" : "Switch to Dark",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 18.sm, fontWeight: FontWeight.w400),
              ),
              const Spacer(),
              Builder(builder: (context) {
                bool sValue = state.isDark ? true : false;
                return Switch(
                    value: sValue,
                    onChanged: (value) async {
                      if (value) {
                        BlocProvider.of<ThemeBloc>(context)
                            .add(ChangeTheme(changeTo: MyThemeMode.dark));
                      } else {
                        BlocProvider.of<ThemeBloc>(context)
                            .add(ChangeTheme(changeTo: MyThemeMode.light));
                      }
                    });
              }),
            ],
          ),
        );
      },
    );
  }
}

class EndDrawerMiniProfile extends StatelessWidget {
  const EndDrawerMiniProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).popAndPushNamed(
          "/profile",
        );
      },
      child: Container(
        padding: EdgeInsets.all(20.sm),
        color: primaryBlue,
        child: BlocConsumer<UserBloc, UserState>(
          buildWhen: (previous, current) =>
              previous != current && current is! UserStateLoading,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is UserStateLoading || state is UserInitial) {
              return const ProfilePartLoading();
            } else if (state is FetchCurrentUserSuccess) {
              final user = state.data.user;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  user.profileImage == "" || user.profileImage.isEmpty
                      ? CircleAvatar(
                          radius: 25.sm,
                          backgroundColor: secondaryBlue,
                          backgroundImage:
                              const AssetImage("assets/dummy/dummyDP.png"),
                        )
                      : CircleAvatar(
                          radius: 25.sm,
                          backgroundColor: secondaryBlue,
                          backgroundImage: NetworkImage(user.profileImage),
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
                        user.name,
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
                        user.email,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: pureWhite.withOpacity(0.7),
                              fontSize: 12.sm,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Container(
                  child: Center(
                child: Text(
                  "OOPS",
                  style: TextStyle(color: pureWhite, fontSize: 30.sm),
                ),
              ));
            }
          },
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
    return Builder(
      builder: (context) {
        return GestureDetector(
            onTap: () async {},
            child: SizedBox(
              height: 35.sm,
              child: Row(
                children: [
                  IconTheme(
                      data: Theme.of(context).iconTheme,
                      child: const Icon(
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
                        .copyWith(fontSize: 18.sm, fontWeight: FontWeight.w400),
                    //   ),
                  ),
                ],
              ),
            ));
      },
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
