import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BlogModel {
  static String? apiKey = dotenv.env['Rest_ApiKey'];

  Future<void> fetchBlog(String blogQuery) async {
    final apiUrl =
        'https://dapi.kakao.com/v2/search/blog?query=${Uri.encodeComponent(blogQuery)}';
    final headers = {
      'Authorization': 'KakaoAK $apiKey',
    };
    final response = await http.get(Uri.parse(apiUrl), headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
    } else {
      print('api error: ${response.statusCode}');
    }
  }
}
