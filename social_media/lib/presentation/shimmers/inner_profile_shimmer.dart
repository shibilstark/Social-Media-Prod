import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/presentation/screens/post/post_texture.dart';
import 'package:social_media/presentation/shimmers/base.dart';
import 'package:social_media/presentation/widgets/gap.dart';

class InnerProfileLoading extends StatelessWidget {
  const InnerProfileLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerBaseCircleWIdget(
                rad: 40.sm,
              ),
              ShimmerBasicRectangleWidget(
                H: 70.sm,
                W: 70.sm,
              ),
              ShimmerBasicRectangleWidget(
                H: 70.sm,
                W: 70.sm,
              ),
              ShimmerBasicRectangleWidget(
                H: 70.sm,
                W: 70.sm,
              ),
              Gap(
                H: 20.sm,
              ),
            ],
          ),
          Gap(
            H: 20.sm,
          ),
          ShimmerBasicRectangleWidget(
            W: 70.sm,
          ),
          Gap(
            H: 5.sm,
          ),
          ShimmerBasicRectangleWidget(
            W: 70.sm,
            H: 10.sm,
          ),
          Gap(
            H: 20.sm,
          ),
          ShimmerBasicRectangleWidget(
            W: double.infinity,
            H: 60.sm,
          ),
          Gap(
            H: 10.sm,
          ),
          Row(
            children: [
              Expanded(
                child: ShimmerBasicRectangleWidget(H: 30.sm),
              ),
              Gap(
                W: 30.sm,
              ),
              Expanded(
                child: ShimmerBasicRectangleWidget(H: 30.sm),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DummyBox extends StatelessWidget {
  const _DummyBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 70.sm,
        width: 70.sm,
        decoration: BoxDecoration(
            // color: smoothWhite,
            borderRadius: BorderRadius.circular(10.sm)),
      ),
    );
  }
}
