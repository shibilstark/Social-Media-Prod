import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/presentation/shimmers/inner_profile_shimmer.dart';

import 'package:social_media/presentation/widgets/gap.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {});

    return const Scaffold(
      appBar:
          PreferredSize(child: ProfileAppBar(), preferredSize: appBarHeight),
      body: SafeArea(child: ProfileBody()),
    );
  }
}

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.sm),
          bottomRight: Radius.circular(40.sm)),
      child: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 15.sm),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: Text(
          "Profile",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: pureWhite),
        ),
        actions: [
          IconButton(
              onPressed: () {
                // showNewPostBottomSheet(context: context);
              },
              icon: Icon(Icons.add_photo_alternate)),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
          Gap(
            W: 15.sm,
          )
        ],
      ),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    return Padding(
      padding: constPadding,
      child: ListView(
        children: [
          // state.status == UserEnums.loading || state.model == null
          //     ? InnerProfileLoading()
          //     : InnerProfilePartInheritedWidget(
          //         model: state.model!,
          //         widget: InnerProfilePart(),
          //       ),
          Gap(
            H: 20.sm,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "POSTS",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 18),
                ),
                Divider(
                  color: primaryBlue,
                ),
                // ProfilePostsSection(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
