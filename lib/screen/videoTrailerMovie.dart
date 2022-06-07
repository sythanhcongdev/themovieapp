import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoTrailerMovie extends StatefulWidget {
  const VideoTrailerMovie({ Key? key }) : super(key: key);

  @override
  State<VideoTrailerMovie> createState() => _VideoTrailerMovieState();
}

class _VideoTrailerMovieState extends State<VideoTrailerMovie> {
  late VideoPlayerController playerController;
  late VoidCallback listener;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}