import 'dart:convert';

import 'package:daum_api/components/remove_html.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class VedioModel {
  static String? apiKey = dotenv.env['Rest_ApiKey'];
  List<dynamic> vedioData = [];
  RemoveHtml removeHtml = RemoveHtml();

  Future<void> fetchVedio(String vedioQuery) async {
    final apiUrl =
        // encode로 받아오고
        'https://dapi.kakao.com/v2/search/vclip?query=${Uri.encodeComponent(vedioQuery)}';
    final headers = {
      'Authorization': 'KakaoAK $apiKey',
    };
    final response = await http.get(Uri.parse(apiUrl), headers: headers);

    // decode로 표시
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      vedioData = data['documents'];

      // HTML 태그 제거
      vedioData = vedioData.map((vedio) {
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
      vedioData = data['documents'];

      // HTML 태그 제거
      vedioData = vedioData.map((vedio) {
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
}
