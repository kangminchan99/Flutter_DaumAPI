import 'package:daum_api/model/video_model.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'video_play_page.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({required this.videoText, super.key});
  final String videoText;

  @override
  State<VideoPage> createState() => _VideoState();
}

class _VideoState extends State<VideoPage> {
  VideoModel videoModel = VideoModel();
  List<dynamic> videoList = [];

  @override
  void initState() {
    videoModel.recenVedio();
    super.initState();
    // fetchBlog 메서드 호출 예시
    fetchVedioData();
  }

  void update() => setState(() {});

  Future<void> fetchVedioData() async {
    try {
      update();
      videoList = videoModel.videoList; // 블로그 데이터를 리스트에 저장
      if (widget.videoText == '' || widget.videoText.isEmpty) {
        update();
        videoModel.recenVedio();
      } else {
        await videoModel.fetchVideo(widget.videoText);
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: videoModel.fetchVideo(widget.videoText),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('error: ${snapshot.error}');
          } else {
            videoList = videoModel.videoList;
            return ListView.builder(
              itemCount: videoList.length,
              itemBuilder: (context, index) {
                final videoData = videoList[index];
                return ListTile(
                  title: Text(videoData['title']),
                  subtitle: GestureDetector(
                    child: Text(videoData['url']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VideoPlayPage(videoUrl: videoData['url']!),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
