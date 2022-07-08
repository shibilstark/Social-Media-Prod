import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:social_media/presentation/screens/post/post_texture.dart';
import 'package:social_media/presentation/shimmers/post_shimmer.dart';
import 'package:social_media/presentation/widgets/gap.dart';

class ProfilePostsSection extends StatelessWidget {
  const ProfilePostsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    return Container(
        child: ListView.separated(
      separatorBuilder: (context, index) => Gap(
        H: 10.sm,
      ),
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) => PostTexture(index: index),
      itemCount: 10,
    ));
  }
}
