import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:fantasyapp/widgets/constants/sizes.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({Key? key}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: Sizes.dimen_4,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_10))),
        margin: const EdgeInsets.fromLTRB(
            Sizes.dimen_16, 0, Sizes.dimen_16, Sizes.dimen_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(Sizes.dimen_10),
                    topRight: Radius.circular(Sizes.dimen_10)),
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: GestureDetector(
                    child: VideoPlayer(_controller),
                    onTap: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                  ),
                )),
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
