import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/core/colors/colors.dart';

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
    return Container(
      height: 120.sm,
      // constraints: BoxConstraints(maxHeight: 150.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {},
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
            onTap: () {},
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
  }
}
