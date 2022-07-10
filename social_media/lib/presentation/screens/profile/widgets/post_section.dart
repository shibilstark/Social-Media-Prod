import 'dart:developer';

import 'package:cool_alert/cool_alert.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/current_user/user_state_enum/user_state_enum.dart';

import 'package:social_media/presentation/screens/post/post_texture.dart';
import 'package:social_media/presentation/shimmers/post_shimmer.dart';
import 'package:social_media/presentation/widgets/gap.dart';
import 'package:social_media/utility/util.dart';

import '../../../../application/current_user/current_user_bloc.dart';

class ProfilePostsSection extends StatelessWidget {
  const ProfilePostsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrentUserBloc, CurrentUserState>(
      listener: (context, state) {
        if (state.status == UserStatesValues.loading) {
          Util.showNormalCoolAlerr(
              context: context,
              type: CoolAlertType.error,
              okString: "OK",
              text: state.failure!.error);
        }
      },
      builder: (context, state) {
        return Container();
        // return state.status == UserStatesValues.loading
        //     ? Container(
        //         child: ListView.separated(
        //         separatorBuilder: (context, index) => Gap(
        //           H: 10.sm,
        //         ),
        //         physics: NeverScrollableScrollPhysics(),
        //         scrollDirection: Axis.vertical,
        //         shrinkWrap: true,
        //         itemBuilder: (context, index) => PostTExtureLoading(),
        //         itemCount: 2,
        //       ))
        //     : state.data!.user.posts.isEmpty
        //         ? SizedBox()
        //         : Container(
        //             child: ListView.separated(
        //             separatorBuilder: (context, index) => Gap(
        //               H: 10.sm,
        //             ),
        //             physics: NeverScrollableScrollPhysics(),
        //             scrollDirection: Axis.vertical,
        //             shrinkWrap: true,
        //             itemBuilder: (context, index) =>
        //                 OwnPostTexture(index: index),
        //             itemCount: state.data!.user.posts.length,
        //           ));
      },
    );
  }
}
