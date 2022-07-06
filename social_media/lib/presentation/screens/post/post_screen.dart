import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/get_post/get_post_bloc.dart';
import 'package:social_media/application/get_post/get_post_enums/get_post_enums.dart';
import 'package:social_media/application/user/user_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/presentation/screens/post/all_post_texture.dart';
import 'package:social_media/presentation/screens/post/post_texture..dart';
import 'package:social_media/presentation/shimmers/post_shimmer.dart';
import 'package:social_media/presentation/widgets/gap.dart';
import 'package:social_media/utility/util.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(((timeStamp) {
      context.read<GetPostBloc>().add(GetAllPostFeeds());
    }));
    return Center(
        child: Container(
      constraints: BoxConstraints(maxWidth: 998.sm),
      child: SingleChildScrollView(
        child: Padding(
          padding: postScreenPadding,
          child: BlocConsumer<GetPostBloc, GetPostState>(
            listener: (context, state) {
              if (state.status == GetPostEnums.error) {
                Util.showNormalCoolAlerr(
                    context: context,
                    type: CoolAlertType.error,
                    okString: "Close",
                    text: state.failure!.error);
              }
            },
            builder: (context, state) {
              if (state.status == GetPostEnums.loading ||
                  state.status == GetPostEnums.error ||
                  state.feed == null) {
                return ListView.separated(
                  separatorBuilder: (context, index) => Gap(
                    H: 10.sm,
                  ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => PostTExtureLoading(),
                  itemCount: 3,
                );
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) => Gap(
                    H: 10.sm,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return AllPostFeedsTexture(
                      index: index,
                    );
                  },
                  itemCount: state.feed!.length,
                );
              }
            },
          ),
        ),
      ),
    ));
  }
}
