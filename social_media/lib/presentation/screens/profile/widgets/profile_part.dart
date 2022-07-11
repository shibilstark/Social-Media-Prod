import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/presentation/widgets/gap.dart';
import '../../../../application/user/user_bloc.dart';

final dummyProfilePicture = "assets/dummy/dummyDP.png";

class InnerProfilePartInheritedWidget extends InheritedWidget {
  final Widget widget;
  final UserModel model;

  InnerProfilePartInheritedWidget(
      {required this.widget, required this.model, Key? key})
      : super(
          key: key,
          child: widget,
        );

  @override
  bool updateShouldNotify(covariant InnerProfilePartInheritedWidget oldWidget) {
    return oldWidget.model != model;
  }

  static InnerProfilePartInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InnerProfilePartInheritedWidget>();
  }
}

class InnerProfilePart extends StatelessWidget {
  const InnerProfilePart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is UserStateLoading) {
        } else if (state is FetchCurrentUserSuccess) {
          final model = state.data.user;
          return Column(
            children: [
              Stack(
                // alignment: Alignment.,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.sm),
                        topRight: Radius.circular(40.sm)),
                    child: model.coverImage == "" || model.coverImage.isEmpty
                        ? Container(
                            constraints: BoxConstraints(maxHeight: 150.sm),
                            color: primaryBlue,
                            width: double.infinity,
                          )
                        : Container(
                            width: double.infinity,
                            // decoration: BoxDecoration(
                            //     image: DecorationImage(
                            //   image: NetworkImage(model.coverImage),
                            //   // fit: BoxFit.cover
                            // )),
                            constraints: BoxConstraints(maxHeight: 150.sm),
                            child: Image.network(
                              model.coverImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 90.sm, left: 10.sm, right: 10.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            model.profileImage == ""
                                ? CircleAvatar(
                                    radius: 65.sm,
                                    backgroundColor: darkBlue,
                                    child: CircleAvatar(
                                      backgroundImage:
                                          AssetImage(dummyProfilePicture),
                                      radius: 60.sm,
                                      backgroundColor: secondaryBlue,
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 65.sm,
                                    backgroundColor: darkBlue,
                                    child: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(model.profileImage),
                                      radius: 60.sm,
                                      backgroundColor: secondaryBlue,
                                    ),
                                  ),

                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.of(context).pushNamed(
                            //         "/editprofile",
                            //         arguments: ScreenArgs(
                            //             args: {'userModel': model}));
                            //   },
                            //   child: Container(
                            //     height: 28.sm,
                            //     width: 28.sm,
                            //     decoration: BoxDecoration(
                            //         color: primaryBlue,
                            //         borderRadius:
                            //             BorderRadius.circular(5.sm)),
                            //     child: Icon(
                            //       Icons.edit,
                            //       color: pureWhite,
                            //       size: 16.sm,
                            //     ),
                            //   ),
                            // )

                            const Spacer(),
                            LimitedBox(
                              child: Padding(
                                padding: EdgeInsets.only(top: 50.sm),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ItemBox(
                                        title: "Followers",
                                        value:
                                            model.followers.length.toString()),
                                    Gap(
                                      W: 10.sm,
                                    ),
                                    ItemBox(
                                        title: "Following",
                                        value:
                                            model.following.length.toString()),
                                    Gap(
                                      W: 10.sm,
                                    ),
                                    ItemBox(
                                        title: "Posts",
                                        value: model.posts.length.toString()),
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
                            model.name,
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        model.discription,
                        // maxLines: 3,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 15.sm),
                      ),
                    ),
                    model.userId != Global.USER_DATA.id
                        ? Column(
                            children: [
                              Gap(
                                H: 10.sm,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: ElevatedButton(
                                    child: Text(
                                      "Follow",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              fontSize: 15.sm,
                                              fontWeight: FontWeight.w500),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              fontSize: 15.sm,
                                              fontWeight: FontWeight.w500),
                                    ),
                                    onPressed: () {},
                                  )),
                                ],
                              ),
                            ],
                          )
                        : SizedBox(),
                  ],
                ),
              )
            ],
          );
        }

        return const Center(
          child: Text("Oops Someting went wrongs"),
        );
      },
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
