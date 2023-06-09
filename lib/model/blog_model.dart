import 'dart:convert';
import 'package:daum_api/components/remove_html.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BlogModel {
  static String? apiKey = dotenv.env['Rest_ApiKey'];
  List<dynamic> blogData = [];
  RemoveHtml removeHtml = RemoveHtml();

  Future<void> fetchBlog(String blogQuery) async {
    final apiUrl =
        'https://dapi.kakao.com/v2/search/blog?query=${Uri.encodeComponent(blogQuery)}';
    final headers = {
      'Authorization': 'KakaoAK $apiKey',
    };
    final response = await http.get(Uri.parse(apiUrl), headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      blogData = data['documents'];

      // HTML 태그 제거
      blogData = blogData.map((blog) {
        final title = removeHtml.delHtml(blog['title']);
        final contents = removeHtml.delHtml(blog['contents']);
        return {
          'title': title,
          'contents': contents,
        };
      }).toList();
    } else {
      print('api error: ${response.statusCode}');
    }
  }

  // 다음 블로그 최신순으로 나타내기
  Future<void> recenBlog() async {
    const apiUrl =
        'https://dapi.kakao.com/v2/search/blog?query=recent&sort=recency';

    final headers = {
      'Authorization': 'KakaoAK $apiKey',
    };

    final response = await http.get(Uri.parse(apiUrl), headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      blogData = data['documents'];

      // HTML 태그 제거
      blogData = blogData.map((blog) {
        final title = removeHtml.delHtml(blog['title']);
        final contents = removeHtml.delHtml(blog['contents']);
        return {
          'title': title,
          'contents': contents,
        };
      }).toList();
    } else {
      print('api error: ${response.statusCode}');
    }
  }
}
