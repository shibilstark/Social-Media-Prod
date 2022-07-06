import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:social_media/presentation/widgets/video_player.dart';

class SeePostImage extends StatelessWidget {
  const SeePostImage({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Container(
        child: Center(
          child: Image.network(
            image,
            fit: BoxFit.fitWidth,
          ),
        ),
      )),
    );
  }
}

class SeePostVideo extends StatelessWidget {
  const SeePostVideo({Key? key, required this.video}) : super(key: key);

  final String video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Container(
        child: Center(
          child: OnlineVideoPlayer(path: video),
        ),
      )),
    );
  }
}
