import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/presentation/screens/post/post_texture..dart';
import 'package:social_media/presentation/shimmers/post_shimmer.dart';
import 'package:social_media/presentation/widgets/gap.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 998.sm),
        child: SingleChildScrollView(
          child: Padding(
            padding: postScreenPadding,
            child: Column(
                children: List.generate(
              10,
              (index) => Column(
                children: [
                  PostTexture(),
                  Divider(
                    color: smoothWhite.withOpacity(0.5),
                  ),
                  PostTExtureLoading(),
                  Divider()
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
