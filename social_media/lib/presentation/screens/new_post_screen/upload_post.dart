import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/pick_media/pick_media_bloc.dart';
import 'package:social_media/application/upload_post/upload_post_bloc.dart';
import 'package:social_media/application/user/user_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/presentation/routes/app_router.dart';
import 'package:social_media/presentation/widgets/gap.dart';
import 'package:uuid/uuid.dart';
import '../../../core/controllers/text_controllers.dart';
import '../../widgets/common_text_field.dart';

class UploadPostScreen extends StatelessWidget {
  const UploadPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        child: NewPostAppBar(),
        preferredSize: appBarHeight,
      ),
      body: SafeArea(child: UploadPostBody()),
      // bottomSheet: UploadPostBottomSheetWidget(),
    );
  }
}

class UploadPostBody extends StatelessWidget {
  const UploadPostBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.sm, horizontal: 10.sm),
          child: BlocBuilder<PickMediaBloc, PickMediaState>(
            builder: (context, state) {
              if (state is PickMediaSuccess) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Gap(H: 20.sm),
                    state.postTypeModel.type == PostType.image
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  "/seeimageoffline",
                                  arguments: ScreenArgs(args: {
                                    'path': state.postTypeModel.file
                                  }));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .bottomSheetTheme
                                      .backgroundColor,
                                  borderRadius: BorderRadius.circular(12.sm),
                                  border: Border.all(
                                      width: 1.sm, color: softBlack)),
                              constraints: BoxConstraints(maxHeight: 400.sm),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.sm),
                                child: Image.file(
                                  File(state.postTypeModel.file),
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  "/offlinevideoplayer",
                                  arguments: ScreenArgs(args: {
                                    'path': state.postTypeModel.file
                                  }));
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.sm),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: darkBg,
                                    ),
                                    width: width,
                                    height: width * 0.7,
                                    child: Opacity(
                                      opacity: 0.8,
                                      child: Image.file(
                                        File(state.postTypeModel.thumbnail!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: darkBg.withOpacity(0.5),
                                  radius: 30.sm,
                                  child: Icon(
                                    Icons.play_arrow,
                                    size: 30.sm,
                                    color: pureWhite,
                                  ),
                                )
                              ],
                            ),
                          ),
                    Gap(H: 40.sm),
                    Center(
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 400.sm),
                        child: Column(
                          children: [
                            CommonTextField(
                                controller:
                                    PostTextFieldControllers.discription,
                                hint: "discription",
                                length: 250),
                            CommonTextField(
                                controller: PostTextFieldControllers.tag,
                                hint: "tag",
                                length: 30),
                            Gap(H: 30.sm),
                            SizedBox(
                              height: 40.sm,
                              width: 200.sm,
                              child:
                                  BlocConsumer<UploadPostBloc, UploadPostState>(
                                listener: (context, postState) {
                                  if (postState is UploadPostLoading) {
                                    Navigator.of(context)
                                        .pushReplacementNamed("/home");
                                  }
                                  if (state is UploadPostSuccess) {}
                                },
                                builder: (context, postState) {
                                  return ElevatedButton(
                                      onPressed: () {
                                        final String? _discription =
                                            PostTextFieldControllers
                                                    .discription.text
                                                    .trim()
                                                    .isEmpty
                                                ? null
                                                : PostTextFieldControllers
                                                    .discription.text
                                                    .trim();
                                        final String? _tag =
                                            PostTextFieldControllers.tag.text
                                                    .trim()
                                                    .isEmpty
                                                ? null
                                                : PostTextFieldControllers
                                                    .tag.text
                                                    .trim();
                                        final time = DateTime.now();
                                        final postModel = PostModel(
                                            postId: Uuid().v4(),
                                            userId: Global.USER_DATA.id,
                                            post: state.postTypeModel.file,
                                            createdAt: time,
                                            laseEdit: time,
                                            comments: [],
                                            lights: [],
                                            type: state.postTypeModel.type,
                                            videoThumbnail:
                                                state.postTypeModel.thumbnail,
                                            discription: _discription,
                                            tag: _tag,
                                            reports: []);

                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          context.read<UploadPostBloc>().add(
                                              UploadPost(postModel: postModel));
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Upload",
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
                                      ));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return Container(
                  height: 150.sm,
                  child: Center(child: Text("Media Not Selected")),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class NewPostAppBar extends StatelessWidget {
  const NewPostAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.sm),
          bottomRight: Radius.circular(40.sm)),
      child: AppBar(
        elevation: 2,
        leading: Padding(
          padding: EdgeInsets.only(left: 30.sm),
          child: Builder(builder: (context) {
            return Center(
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: IconTheme(
                    data: Theme.of(context).primaryIconTheme,
                    child: Icon(
                      Icons.arrow_back,
                      size: 25.sm,
                    ),
                  )),
            );
          }),
        ),
        automaticallyImplyLeading: false,
        title: Text("Add New Post",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 23, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
