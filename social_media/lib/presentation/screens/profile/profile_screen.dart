import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/domain/db/user_data/user_data.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/presentation/screens/post/post_texture.dart';
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
          IconButton(onPressed: () {}, icon: Icon(Icons.add_photo_alternate)),
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
    return Padding(
      padding: constPadding,
      child: ListView(
        children: [
          Stack(
            // alignment: Alignment.,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.sm),
                    topRight: Radius.circular(40.sm)),
                child: Container(
                  color: primaryBlue,
                  height: 150.sm,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 90.sm, left: 10.sm, right: 10.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 65.sm,
                          backgroundColor: darkBlue,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/dummy/dummyDP.png"),
                            radius: 60.sm,
                            backgroundColor: secondaryBlue,
                          ),
                        ),
                        Spacer(),
                        LimitedBox(
                          child: Padding(
                            padding: EdgeInsets.only(top: 50.sm),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ItemBox(title: "Follewers", value: "1000"),
                                Gap(
                                  W: 10.sm,
                                ),
                                ItemBox(title: "Follewing", value: "1000"),
                                Gap(
                                  W: 10.sm,
                                ),
                                ItemBox(title: "Posts", value: "1000"),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Gap(
                      H: 10.sm,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.sm),
                      child: Text(
                        "User Name",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 18.sm),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Gap(
            H: 10.sm,
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dummyLongText,
                  maxLines: 3,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 15.sm),
                ),
                Gap(
                  H: 10.sm,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      child: Text(
                        "Follow",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 15.sm, fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {},
                    )),
                    Gap(
                      W: 20.sm,
                    ),
                    Expanded(
                        child: ElevatedButton(
                      child: Text(
                        "Message",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 15.sm, fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {},
                    )),
                  ],
                )
              ],
            ),
          )

          // ClipRRect(
          //   borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(40.sm),
          //       bottomRight: Radius.circular(40.sm)),
          //   child: Container(
          //     color: primary,
          //     height: 80.sm,
          //     width: double.infinity,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class ItemBox extends StatelessWidget {
  const ItemBox({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.sm,
      width: 70.sm,
      decoration: BoxDecoration(
          // color: smoothWhite,
          borderRadius: BorderRadius.circular(10.sm)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 15.sm),
          ),
          Gap(
            H: 5.sm,
          ),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 17.sm),
          )
        ],
      ),
    );
  }
}
