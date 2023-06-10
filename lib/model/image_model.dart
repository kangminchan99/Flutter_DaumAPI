import 'dart:convert';

import 'package:daum_api/components/remove_html.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ImageModel {
  static String? apiKey = dotenv.env['Rest_ApiKey'];
  List<dynamic> imageList = [];
  RemoveHtml removeHtml = RemoveHtml();

  Future<void> fetchImage(String imageQuery) async {
    final apiUrl =
        'https://dapi.kakao.com/v2/search/image?query=${Uri.encodeComponent(imageQuery)}';
    final header = {'Authorization': 'KakaoAK $apiKey'};

    final response = await http.get(Uri.parse(apiUrl), headers: header);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      imageData = data['documents'];
    }
  }
}
