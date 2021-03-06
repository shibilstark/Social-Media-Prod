import 'dart:developer';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media/application/pick_media/pick_media_bloc.dart';

import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/utility/util.dart';

openNewPostSheet({required BuildContext context}) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.sm),
              topRight: Radius.circular(40.sm))),
      context: context,
      builder: (ctx) => const NewPostSheet());
}

class NewPostSheet extends StatelessWidget {
  const NewPostSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PickMediaBloc, PickMediaState>(
      listener: (context, state) {
        if (state is PickMediaSuccess) {
          Navigator.of(context).popAndPushNamed("/uploadpost");
        }
        if (state is PickMediaLoading) {
          // Navigator.of(context).pop();
        }
        if (state is PickMediaError) {
          log("error");
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: state.failure.error);
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: 120.sm,
          // constraints: BoxConstraints(maxHeight: 150.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  context
                      .read<PickMediaBloc>()
                      .add(PickMedia(type: PostType.image));
                },
                child: Container(
                  height: 50.sm,
                  width: 50.sm,
                  decoration: BoxDecoration(
                      color: primaryBlue,
                      borderRadius: BorderRadius.circular(10.sm)),
                  child: Icon(
                    Icons.add_photo_alternate,
                    color: pureWhite,
                    size: 28.sm,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context
                      .read<PickMediaBloc>()
                      .add(PickMedia(type: PostType.video));
                },
                child: Container(
                  height: 50.sm,
                  width: 50.sm,
                  decoration: BoxDecoration(
                      color: primaryBlue,
                      borderRadius: BorderRadius.circular(10.sm)),
                  child: Icon(
                    Icons.video_call,
                    color: pureWhite,
                    size: 28.sm,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
