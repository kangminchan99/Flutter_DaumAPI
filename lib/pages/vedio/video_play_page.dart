import 'package:daum_api/model/video_model.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class VideoPlayPage extends StatefulWidget {
  VideoPlayPage({required this.videoUrl, super.key});
  String videoUrl;

  @override
  State<VideoPlayPage> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  late YoutubePlayerController youtubePlayerController;

  void update() => setState(() {});

  @override
  void initState() {
    super.initState();
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: VideoModel().extractVideoId(widget.videoUrl),
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
    update();
  }

  @override
  void dispose() {
    youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: YoutubePlayer(
          controller: youtubePlayerController,
          showVideoProgressIndicator: true,
          progressColors: const ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          update();
          youtubePlayerController.value.isPlaying
              ? youtubePlayerController.pause()
              : youtubePlayerController.play();
        },
        child: Icon(
          youtubePlayerController.value.isPlaying
              ? Icons.pause
              : Icons.play_arrow,
        ),
      ),
    );
  }
}
