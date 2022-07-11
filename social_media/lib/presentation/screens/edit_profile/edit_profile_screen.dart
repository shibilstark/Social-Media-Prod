import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/core/controllers/text_controllers.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/presentation/screens/profile/widgets/profile_part.dart';
import 'package:social_media/presentation/widgets/common_text_field.dart';
import 'package:social_media/presentation/widgets/gap.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key, required this.userModel})
      : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: EditProfileAppBar(),
        preferredSize: appBarHeight,
      ),
      body: SafeArea(
          child: EditProfileBody(
        userModel: userModel,
      )),
    );
  }
}

class EditProfileAppBar extends StatelessWidget {
  const EditProfileAppBar({Key? key}) : super(key: key);

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
          "Edit Profile",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: pureWhite),
        ),
      ),
    );
  }
}

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({Key? key, required this.userModel}) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.sm, horizontal: 10.sm),
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.sm),
                topRight: Radius.circular(40.sm)),
            child: userModel.coverImage != "" || userModel.coverImage.isEmpty
                ? Container(
                    constraints: BoxConstraints(maxHeight: 150.sm),
                    color: primaryBlue,
                    width: double.infinity,
                  )
                : userModel.coverImage == "" || userModel.coverImage.isNotEmpty
                    ? Container(
                        width: double.infinity,
                        constraints: BoxConstraints(maxHeight: 150.sm),
                        child: Image.network(
                          userModel.coverImage,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        constraints: BoxConstraints(maxHeight: 150.sm),
                        child: Image.file(
                          File(dummyProfilePicture),
                          fit: BoxFit.cover,
                        ),
                      ),
          ),
          Gap(H: 20.sm),
          Row(
            children: [
              CircleAvatar(
                radius: 70.sm,
                backgroundColor: darkBg,
              ),
              Gap(
                W: 10.sm,
              ),
              Column(
                children: [
                  LimitedBox(
                    maxWidth: 250.sm,
                    child: TextField(
                      controller: EditProfileTextEditingControllers.name,
                      cursorColor: primaryBlue,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16.sm),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.sm),
                        hintText: "Profile name",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color!
                                    .withOpacity(0.5)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color!,
                              width: 1.sm),
                          borderRadius: BorderRadius.circular(5.sm),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color!,
                              width: 1.sm),
                          borderRadius: BorderRadius.circular(5.sm),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color!,
                            width: 1.sm,
                          ),
                          borderRadius: BorderRadius.circular(5.sm),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Gap(
            H: 10.sm,
          ),
          TextField(
            controller: EditProfileTextEditingControllers.name,
            cursorColor: primaryBlue,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 16.sm),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10.sm),
              hintText: "About you",
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .color!
                      .withOpacity(0.5)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).textTheme.bodyMedium!.color!,
                    width: 1.sm),
                borderRadius: BorderRadius.circular(5.sm),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).textTheme.bodyMedium!.color!,
                    width: 1.sm),
                borderRadius: BorderRadius.circular(5.sm),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).textTheme.bodyMedium!.color!,
                  width: 1.sm,
                ),
                borderRadius: BorderRadius.circular(5.sm),
              ),
            ),
          ),
          Gap(
            H: 30.sm,
          ),
          ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Update",
                    style: TextStyle(
                        color: smoothWhite,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sm),
                  ),
                  Gap(
                    W: 5.sm,
                  ),
                  Icon(
                    Icons.upload_sharp,
                    size: 20.sm,
                  )
                ],
              ))
        ],
      )),
    );
  }
}
