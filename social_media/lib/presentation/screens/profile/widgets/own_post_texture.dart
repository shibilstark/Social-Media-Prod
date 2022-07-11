import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/presentation/routes/app_router.dart';
import 'package:social_media/presentation/widgets/dummy_profile.dart';
import 'package:social_media/presentation/widgets/gap.dart';

import '../../../../application/user/user_bloc.dart';

final _dropItems = [
  "Follw",
  "Report",
];

final dummyLongText =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec egestas posuere pretium. Nam volutpat dictum lorem in volutpat. Aenean convallis ipsum sed sagittis bibendum. Sed ut bibendum velit, a consectetur est. Suspendisse feugiat nulla in felis mollis dignissim et id lectus. Nullam nec massa orci. Curabitur odio tellus, tempus ut imperdiet in, ullamcorper nec nibh. Praesent nisi nunc";

DropdownMenuItem<String> _buildMenuItem(String item) {
  return DropdownMenuItem(
    child: Text(
      item,
      style: TextStyle(
        fontSize: 15.sm,
        fontWeight: FontWeight.w400,
        color: primary,
      ),
    ),
    value: item,
  );
}

class OwnPostTexture extends StatelessWidget {
  const OwnPostTexture({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FetchCurrentUserSuccess) {
            final user = state.data.user;
            final post = state.data.post[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    LimitedBox(
                        child: Row(
                      children: [
                        // user.profileImage == "" || user.profileImage.isEmpty
                        //     ?
                        const DummyProfile(),
                        // :
                        // CircleAvatar(
                        //     radius: 20.sm,
                        //     backgroundImage: NetworkImage(user.profileImage),
                        //   ),
                        Gap(W: 10.sm),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              // "${DateTime.now().year} / ${DateTime.now().month} / ${DateTime.now().day}",
                              post.createdAt
                                  .toLocal()
                                  .toString()
                                  .split(" ")
                                  .first
                                  .split("-")
                                  .reversed
                                  .join("-"),

                              // "${currentPost.creationData.day}:${currentPost.creationData.month}:${currentPost.creationData.year}",
                              // style: Theme.of(context).textTheme.bodyMedium,
                              style:
                                  //  TextStyle(
                                  //   color: primaryBlue,
                                  //   fontSize: 12.sm,
                                  //   fontWeight: FontWeight.normal,
                                  // )
                                  Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 11.sm),
                            ),
                          ],
                        )
                      ],
                    )),
                    const Spacer(),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        items: _dropItems.map(_buildMenuItem).toList(),
                        onChanged: (value) {},
                        icon: IconTheme(
                          data: Theme.of(context).iconTheme.copyWith(size: 18),
                          child: const Icon(
                            Icons.more_vert,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Gap(H: 10.sm),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.sm),
                  child: post.type == PostType.video
                      ? GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                "/onlinevideoplayer",
                                arguments:
                                    ScreenArgs(args: {'path': post.post}));
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                child: Center(
                                  child: post.post == "" ||
                                          post.post.isEmpty ||
                                          post.post == null
                                      ? const SizedBox()
                                      : Container(
                                          // constraints:
                                          //     BoxConstraints(maxHeight: 200.sm),
                                          height: 200.sm,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.sm),
                                              border: Border.all(
                                                  width: 0.2.sm,
                                                  color: softBlack)),
                                          child: Image.network(
                                            post.videoThumbnail!,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                ),
                              ),
                              Opacity(
                                opacity: 0.6,
                                child: Container(
                                  height: 200.sm,
                                  color: darkBg,
                                ),
                              ),
                              CircleAvatar(
                                radius: 25.sm,
                                backgroundColor: darkBg.withOpacity(0.5),
                                child: Icon(
                                  Icons.play_arrow_rounded,
                                  size: 25,
                                ),
                              )
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed("/seeimageonline",
                                arguments:
                                    ScreenArgs(args: {'path': post.post}));
                          },
                          child: Container(
                            child: Center(
                              child: post.post == "" ||
                                      post.post.isEmpty ||
                                      post.post == null
                                  ? const SizedBox()
                                  : Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.sm),
                                          border: Border.all(
                                              width: 0.2.sm, color: softBlack)),
                                      child: Image.network(
                                        post.post,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                ),
                Gap(H: 10.sm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        LimitedBox(
                          child: Row(
                            children: [
                              IconTheme(
                                  data: Theme.of(context).iconTheme,
                                  child: Icon(
                                    Icons.bolt,
                                    size: 13.sm,
                                  )),
                              Text(
                                "${post.lights.length} lights",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        LimitedBox(
                          child: Row(
                            children: [
                              IconTheme(
                                  data: Theme.of(context).iconTheme,
                                  child: Icon(
                                    Icons.comment,
                                    size: 13.sm,
                                  )),
                              Text(
                                "  ${post.comments.length} Comments",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    post.tag == null || post.tag == ""
                        ? const SizedBox()
                        : Column(
                            children: [
                              Gap(H: 10.sm),
                              Row(
                                children: [
                                  Text(
                                    "#${post.tag}",
                                    // style: Theme.of(context).textTheme.bodyMedium,
                                    style: TextStyle(
                                      color: primary,
                                      fontSize: 14.sm,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ],
                          ),
                    Gap(
                      H: 5.sm,
                    ),
                    post.discription == null ||
                            post.discription.toString() == ""
                        ? const SizedBox()
                        : ReadMoreText(
                            post.discription.toString(),
                            trimMode: TrimMode.Line,
                            trimLines: 2,
                            trimCollapsedText: 'Read More',
                            trimExpandedText: 'Read Less',
                            lessStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontSize: 13.sm,
                                    color: primary.withOpacity(0.7),
                                    fontWeight: FontWeight.w500),
                            moreStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 13.sm,
                                    color: primary.withOpacity(0.7),
                                    fontWeight: FontWeight.w500),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                    Gap(H: 10.sm),
                    Row(
                      children: [
                        const PostActionButton(icon: Icons.bolt_outlined),
                        Gap(W: 10.sm),
                        const PostActionButton(icon: Icons.comment),
                        Gap(W: 10.sm),
                        const PostActionButton(icon: Icons.download),
                      ],
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Container(
              height: 150.sm,
              child: const Center(child: Text("Something went wrong")),
            );
          }
        },
      ),
    );
  }
}

class PostActionButton extends StatelessWidget {
  const PostActionButton({Key? key, required this.icon}) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.1.sm, color: darkBlue),
            borderRadius: BorderRadius.circular(15.sm)),
        child: IconButton(
          constraints: BoxConstraints(maxHeight: 36.sm, maxWidth: 36.sm),
          icon: IconTheme(
              data: Theme.of(context).iconTheme,
              child: Icon(
                icon,
                size: 22.sm,
                // color: primaryBlue.withOpacity(0.7),
              )),
          onPressed: () {},
        ),
      ),
    );
  }
}
