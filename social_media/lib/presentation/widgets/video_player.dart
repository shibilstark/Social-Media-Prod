import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class LocalVideoPlayer extends StatefulWidget {
  const LocalVideoPlayer({Key? key, required this.path}) : super(key: key);

  final String path;

  @override
  State<LocalVideoPlayer> createState() => _LocalVideoPlayerState();
}

class _LocalVideoPlayerState extends State<LocalVideoPlayer> {
  late final BetterPlayerController _controller;

  @override
  void initState() {
    _controller = BetterPlayerController(
      const BetterPlayerConfiguration(),
      betterPlayerDataSource: BetterPlayerDataSource.file(widget.path),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
