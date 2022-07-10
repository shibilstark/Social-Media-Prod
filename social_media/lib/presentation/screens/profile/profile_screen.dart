import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/current_user/current_user_bloc.dart';
import 'package:social_media/application/current_user/user_state_enum/user_state_enum.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/presentation/screens/profile/widgets/post_section.dart';
import 'package:social_media/presentation/screens/profile/widgets/profile_part.dart';
import 'package:social_media/presentation/shimmers/inner_profile_shimmer.dart';

import 'package:social_media/presentation/widgets/gap.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<CurrentUserBloc>()
          .add(FetchUser(userId: Global.USER_DATA.id, shouldLoad: true));
    });

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
    return BlocConsumer<CurrentUserBloc, CurrentUserState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Padding(
          padding: constPadding,
          child: ListView(
            children: [
              state.status == UserStatesValues.loading || state.data == null
                  ? InnerProfileLoading()
                  : InnerProfilePartInheritedWidget(
                      model: state.data!.user,
                      widget: InnerProfilePart(),
                    ),
              Gap(
                H: 20.sm,
              ),
              Padding(
                padding: EdgeInsets.symmetric(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "POSTS",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 18),
                    ),
                    Divider(),
                    ProfilePostsSection(),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

final dummyUserModel = UserModel(
    userId: Global.USER_DATA.id,
    name: "sdfjaosjdf",
    email: "sdfjaosjdf",
    isAgreed: true,
    isPrivate: true,
    isBlocked: true,
    creationDate: DateTime.now(),
    followers: [],
    following: [],
    posts: [],
    discription: "discription",
    profileImage:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2iD6awG7ugwALMWGiwNVjjIPGu58gfRKhEg&usqp=CAU",
    coverImage:
        "https://media.istockphoto.com/photos/abstract-geometric-network-polygon-globe-graphic-background-picture-id1208738316?b=1&k=20&m=1208738316&s=170667a&w=0&h=f4KWULKjL770nceDM6xi32EbfIgMtBwSp5fPxIx08wc=",
    isEmailVerified: true);
