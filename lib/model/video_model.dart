import 'dart:convert';

import 'package:daum_api/components/remove_html.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class VideoModel {
  static String? apiKey = dotenv.env['Rest_ApiKey'];
  List<dynamic> videoList = [];
  RemoveHtml removeHtml = RemoveHtml();

  Future<void> fetchVideo(String videoQuery) async {
    final apiUrl =
        // encode로 받아오고
        'https://dapi.kakao.com/v2/search/vclip?query=${Uri.encodeComponent(videoQuery)}';
    final headers = {
      'Authorization': 'KakaoAK $apiKey',
    };
    final response = await http.get(Uri.parse(apiUrl), headers: headers);

    // decode로 표시
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      videoList = data['documents'];

      // HTML 태그 제거
      videoList = videoList.map((vedio) {
        final title = removeHtml.delHtml(vedio['title']);
        final url = removeHtml.delHtml(vedio['url']);
        return {
          'title': title,
          'url': url,
        };
      }).toList();
    } else {
      print('api error: ${response.statusCode}');
    }
  }

  // 다음 블로그 최신순으로 나타내기
  Future<void> recenVedio() async {
    const apiUrl =
        'https://dapi.kakao.com/v2/search/vclip?query=recent&sort=recency';

    final headers = {
      'Authorization': 'KakaoAK $apiKey',
    };

    final response = await http.get(Uri.parse(apiUrl), headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      videoList = data['documents'];

      // HTML 태그 제거
      videoList = videoList.map((video) {
        final title = removeHtml.delHtml(video['title']);
        final url = removeHtml.delHtml(video['url']);
        return {
          'title': title,
          'url': url,
        };
      }).toList();
    } else {
      print('api error: ${response.statusCode}');
    }
  }

  // v 다음에 나오는거 추출
  String extractVideoId(String url) {
    Uri uri = Uri.parse(url);
    String videoId = uri.queryParameters['v'] ?? '';
    return videoId;
  }
}
