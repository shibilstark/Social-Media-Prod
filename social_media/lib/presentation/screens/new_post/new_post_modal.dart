import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/new_post/new_post_bloc.dart';
import 'package:social_media/application/new_post/new_post_enums/new_post_enums.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/enums.dart';
import 'package:social_media/presentation/widgets/gap.dart';

showNewPostBottomSheet({required BuildContext context}) {
  showModalBottomSheet(
      context: context,
      builder: (ctx) => BlocConsumer<NewPostBloc, NewPostState>(
            listener: (context, state) {
              if (state.status == NewPostEnum.filePicked) {
                Navigator.of(context).popAndPushNamed("/newpost");
              }
              if (state.status == NewPostEnum.fileNotPicked) {
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              return Container(
                height: 150.sm,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context
                            .read<NewPostBloc>()
                            .add(SelectPost(type: PostType.image));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50.sm,
                            width: 50.sm,
                            decoration: BoxDecoration(
                              // color: Colors.redAccent,
                              color: primaryBlue,
                              borderRadius: BorderRadius.circular(5.sm),
                            ),
                            child: Icon(
                              Icons.image,
                              color: pureWhite,
                            ),
                          ),
                          Gap(
                            H: 10.sm,
                          ),
                          Text("Image",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: 15.sm,
                                  ))
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<NewPostBloc>()
                            .add(SelectPost(type: PostType.video));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50.sm,
                            width: 50.sm,
                            decoration: BoxDecoration(
                              // color: Colors.redAccent,
                              color: primaryBlue,
                              borderRadius: BorderRadius.circular(5.sm),
                            ),
                            child: Icon(
                              Icons.video_call,
                              color: pureWhite,
                            ),
                          ),
                          Gap(
                            H: 10.sm,
                          ),
                          Text("Video",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: 15.sm,
                                  ))
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ));
}
