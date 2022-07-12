import 'dart:developer';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media/application/pick_media/pick_media_bloc.dart';
import 'package:social_media/application/user/user_bloc.dart';

import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/infrastructure/user_services/user_repository.dart';
import 'package:social_media/infrastructure/user_services/user_services.dart';
import 'package:social_media/presentation/routes/app_router.dart';
import 'package:social_media/presentation/screens/profile/widgets/profile_part.dart';
import 'package:social_media/presentation/widgets/gap.dart';

openEditProfileImageSheet({required BuildContext context}) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.sm),
              topRight: Radius.circular(40.sm))),
      context: context,
      builder: (ctx) => const EditProfileSheet());
}

class EditProfileSheet extends StatelessWidget {
  const EditProfileSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, userState) {},
      builder: (context, userState) {
        if (userState is FetchCurrentUserSuccess) {
          final user = userState.data.user;
          return BlocConsumer<PickMediaBloc, PickMediaState>(
            listener: (context, state) {},
            builder: (context, state) {
              return SizedBox(
                height: 140.sm,
                // constraints: BoxConstraints(maxHeight: 150.sm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (user.profileImage == "" ||
                            user.profileImage.isEmpty) {
                          Navigator.of(context).popAndPushNamed(
                              "/seeassetimage",
                              arguments: ScreenArgs(
                                  args: {'path': dummyProfilePicture}));
                        } else {
                          Navigator.of(context).popAndPushNamed(
                              "/seeimageonline",
                              arguments: ScreenArgs(
                                  args: {'path': user.profileImage}));
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 25.sm,
                            backgroundColor: primaryBlue,
                            child: Icon(
                              Icons.visibility,
                              color: pureWhite,
                              size: 25.sm,
                            ),
                          ),
                          Gap(H: 5.sm),
                          Text("Show Image")
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<UserBloc>().add(RemovePrfileImage());
                        Navigator.of(context).pop();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 25.sm,
                            backgroundImage: AssetImage(dummyProfilePicture),
                          ),
                          Gap(H: 5.sm),
                          Text("Remove Img")
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<UserBloc>().add(ChangeProfilePic());
                        Navigator.of(context).pop();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 25.sm,
                            backgroundColor: primaryBlue,
                            child: Icon(
                              Icons.add_photo_alternate,
                              color: pureWhite,
                              size: 25.sm,
                            ),
                          ),
                          Gap(H: 5.sm),
                          Text("Change Image")
                        ],
                      ),
                    ),

                    // GestureDetector(
                    //   onTap: () {
                    //     context
                    //         .read<PickMediaBloc>()
                    //         .add(PickMedia(type: PostType.video));
                    //   },
                    //   child: Container(
                    //     height: 50.sm,
                    //     width: 50.sm,
                    //     decoration: BoxDecoration(
                    //         color: primaryBlue,
                    //         borderRadius: BorderRadius.circular(10.sm)),
                    //     child: Icon(
                    //       Icons.video_call,
                    //       color: pureWhite,
                    //       size: 28.sm,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              );
            },
          );
        } else if (userState is FetchCurrentUserError) {
          return Center(
            child: Text("Something went wrong please reload again"),
          );
        }
        return Center(
          child: Text("Loading"),
        );
      },
    );
  }
}
