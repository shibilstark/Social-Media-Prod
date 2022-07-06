import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/get_post/get_post_bloc.dart';
import 'package:social_media/application/get_post/get_post_enums/get_post_enums.dart';
import 'package:social_media/application/user/user_bloc.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/presentation/screens/post/post_texture..dart';
import 'package:social_media/presentation/shimmers/post_shimmer.dart';
import 'package:social_media/presentation/widgets/gap.dart';

class ProfilePostsSection extends StatelessWidget {
  const ProfilePostsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetPostBloc>().add(GetPost(userId: Global.USER_DATA.id));
    });
    return Container(
      child: BlocConsumer<GetPostBloc, GetPostState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == GetPostEnums.loading ||
              state.status != GetPostEnums.success) {
            return ListView.separated(
              separatorBuilder: (context, index) => Gap(
                H: 10.sm,
              ),
              // physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) => PostTExtureLoading(),
              itemCount: 2,
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => Gap(
                H: 10.sm,
              ),
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) => PostTexture(index: index),
              itemCount: state.posts!.length,
            );
          }
        },
      ),
    );
  }
}
