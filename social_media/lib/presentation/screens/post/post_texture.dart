import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/presentation/widgets/dummy_profile.dart';
import 'package:social_media/presentation/widgets/gap.dart';

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

class PostTexture extends StatelessWidget {
  const PostTexture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserInfoRow(),
        Gap(H: 10.sm),
        PostImage(),
        Gap(H: 5.sm),
        LikeAndCommentRow(),
        Gap(H: 10.sm),
        PostDiscription(),
        Gap(H: 10.sm),
        PostTag()
      ],
    );
  }
}

class PostTag extends StatelessWidget {
  const PostTag({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "#tag",
          // style: Theme.of(context).textTheme.bodyMedium,
          style: TextStyle(
            color: primary,
            fontSize: 14.sm,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Text(
          "12/10/1002",
          // style: Theme.of(context).textTheme.bodyMedium,
          style: TextStyle(
            color: primary,
            fontSize: 12.sm,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class PostDiscription extends StatelessWidget {
  const PostDiscription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      dummyLongText,
      trimMode: TrimMode.Line,
      trimLines: 2,
      trimCollapsedText: 'Read More',
      trimExpandedText: 'Read Less',
      lessStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 13.sm,
          color: primary.withOpacity(0.7),
          fontWeight: FontWeight.w500),
      moreStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 13.sm,
          color: primary.withOpacity(0.7),
          fontWeight: FontWeight.w500),
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
//  Like, Comment and date Block

class LikeAndCommentRow extends StatelessWidget {
  const LikeAndCommentRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    "1099 lights",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Spacer(),
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
                    "1099 Comments",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
        Gap(
          H: 5.sm,
        ),
        Row(
          children: [
            PostActionButton(icon: Icons.bolt_outlined),
            Gap(W: 10.sm),
            PostActionButton(icon: Icons.comment),
            Gap(W: 10.sm),
            PostActionButton(icon: Icons.download),
          ],
        ),
      ],
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
            border: Border.all(width: 0.1.sm, color: primary),
            borderRadius: BorderRadius.circular(15.sm)),
        child: IconButton(
          constraints: BoxConstraints(maxHeight: 36.sm, maxWidth: 36.sm),
          icon: IconTheme(
              data: Theme.of(context).iconTheme,
              child: Icon(
                icon,
                size: 20.sm,
              )),
          onPressed: () {},
        ),
      ),
    );
  }
}

//  The image in the Post

class PostImage extends StatelessWidget {
  const PostImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.sm),
      child: Container(
        child: Image.asset(
          "assets/dummy/2.jpg",
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}

// User Information and The Report Button

class UserInfoRow extends StatelessWidget {
  const UserInfoRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LimitedBox(
            child: Row(
          children: [
            DummyProfile(),
            Gap(W: 10.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "User Name",
                  style: Theme.of(context).textTheme.bodyLarge!,
                ),
                // Text(
                //   "Follow",
                //   style: Theme.of(context).textTheme.bodyMedium,
                // )
              ],
            )
          ],
        )),
        Spacer(),
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            items: _dropItems.map(_buildMenuItem).toList(),
            onChanged: (value) {},
            icon: IconTheme(
              data: Theme.of(context).iconTheme.copyWith(size: 18),
              child: Icon(
                Icons.more_vert,
              ),
            ),
          ),
        )
      ],
    );
  }
}
