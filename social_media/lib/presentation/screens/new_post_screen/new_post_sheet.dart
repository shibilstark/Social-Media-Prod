import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/new_post/new_post_bloc.dart';
import 'package:social_media/application/new_post/post_state_values.dart';

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
      builder: (ctx) => NewPostSheet());
}

class NewPostSheet extends StatelessWidget {
  const NewPostSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewPostBloc, NewPostState>(
      listener: (context, state) {
        if (state.status == PostStateValues.success) {
          Navigator.of(context).popAndPushNamed("/uploadpost");
        }

        if (state.status == PostStateValues.error) {
          Navigator.of(context).pop();
          if (state.failure!.failureType != MyAppFilures.clientFailure) {
            Util.showNormalCoolAlerr(
                context: context,
                type: CoolAlertType.error,
                okString: "Ok",
                text: state.failure!.error);
          }
        }
      },
      builder: (context, state) {
        return Container(
          height: 120.sm,
          // constraints: BoxConstraints(maxHeight: 150.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  context
                      .read<NewPostBloc>()
                      .add(PickPost(type: PostType.image));
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
                      .read<NewPostBloc>()
                      .add(PickPost(type: PostType.video));
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
