import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/presentation/widgets/gap.dart';
import 'package:video_player/video_player.dart';

late VideoPlayerController localVideoPlayerController;

class LocalVideoPlayer extends StatefulWidget {
  const LocalVideoPlayer({Key? key, required this.path}) : super(key: key);

  final String path;

  @override
  State<LocalVideoPlayer> createState() => _LocalVideoPlayerState();
}

class _LocalVideoPlayerState extends State<LocalVideoPlayer> {
  @override
  void initState() {
    localVideoPlayerController = VideoPlayerController.file(File(widget.path),
        videoPlayerOptions: VideoPlayerOptions(
            allowBackgroundPlayback: false, mixWithOthers: false))
      ..addListener(() => setState(() {}))
      ..setLooping(false)
      ..initialize().then((value) => localVideoPlayerController.pause());
    super.initState();
  }

  _getPosition() {
    final duration = Duration(
        milliseconds:
            localVideoPlayerController.value.position.inMilliseconds.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, "0"))
        .join(":");
  }

  @override
  void dispose() {
    localVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AspectRatio(
                aspectRatio: localVideoPlayerController.value.aspectRatio,
                child: VideoPlayer(localVideoPlayerController)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.sm),
              child: Row(
                children: [
                  Text(
                    _getPosition(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: pureWhite, fontSize: 12.sm),
                  ),
                  Gap(
                    W: 5.sm,
                  ),
                  Expanded(
                    child: VideoProgressIndicator(
                      localVideoPlayerController,
                      allowScrubbing: true,
                      padding: EdgeInsets.all(3),
                      colors: const VideoProgressColors(
                          playedColor: primaryBlue,
                          bufferedColor: pureWhite,
                          backgroundColor: smoothWhite),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (localVideoPlayerController.value.isPlaying) {
                            localVideoPlayerController.pause();
                          } else {
                            localVideoPlayerController.play();
                          }
                        });
                      },
                      icon: Icon(
                        localVideoPlayerController.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: pureWhite,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnlineVideoPlayer extends StatefulWidget {
  OnlineVideoPlayer({Key? key, required this.path}) : super(key: key);

  final String path;

  @override
  State<OnlineVideoPlayer> createState() => _OnlineVideoPlayerState();
}

class _OnlineVideoPlayerState extends State<OnlineVideoPlayer> {
  late VideoPlayerController onlineVideoPlayerController;
  @override
  void initState() {
    onlineVideoPlayerController = VideoPlayerController.network(widget.path,
        videoPlayerOptions: VideoPlayerOptions(
            allowBackgroundPlayback: false, mixWithOthers: false))
      ..addListener(() => setState(() {}))
      ..setLooping(false)
      ..initialize().then((value) => onlineVideoPlayerController.pause());
    super.initState();
  }

  _getPosition() {
    final duration = Duration(
        milliseconds:
            onlineVideoPlayerController.value.position.inMilliseconds.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, "0"))
        .join(":");
  }

  @override
  void dispose() {
    onlineVideoPlayerController.dispose();
    log("VideoDisposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AspectRatio(
                aspectRatio: onlineVideoPlayerController.value.aspectRatio,
                child: VideoPlayer(onlineVideoPlayerController)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.sm),
              child: Row(
                children: [
                  Text(
                    _getPosition(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: pureWhite, fontSize: 12.sm),
                  ),
                  Gap(
                    W: 5.sm,
                  ),
                  Expanded(
                    child: VideoProgressIndicator(
                      onlineVideoPlayerController,
                      allowScrubbing: true,
                      padding: EdgeInsets.all(3),
                      colors: const VideoProgressColors(
                          playedColor: primaryBlue,
                          bufferedColor: pureWhite,
                          backgroundColor: smoothWhite),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (onlineVideoPlayerController.value.isPlaying) {
                            onlineVideoPlayerController.pause();
                          } else {
                            onlineVideoPlayerController.play();
                          }
                        });
                      },
                      icon: Icon(
                        onlineVideoPlayerController.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: pureWhite,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
