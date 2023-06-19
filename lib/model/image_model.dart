import 'dart:convert';

import 'package:daum_api/components/remove_html.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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
      imageList = data['documents'];

      imageList = imageList.map((image) {
        final docUrl = removeHtml.delHtml(image['doc_url']);
        final imageUrl = removeHtml.delHtml(image['image_url']);
        return {
          'docUrl': docUrl,
          'imageUrl': imageUrl,
        };
      }).toList();
    } else {
      print('api error: ${response.statusCode}');
    }
  }

  Future<void> recenImage() async {
    const apiUrl =
        'https://dapi.kakao.com/v2/search/image?query=recent&sort=recency';
    final header = {'Authorization': 'KakaoAK $apiKey'};
    final response = await http.get(Uri.parse(apiUrl), headers: header);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      imageList = data['documents'];
      // HTML 태그 제거
      imageList = imageList.map((image) {
        final docUrl = removeHtml.delHtml(image['doc_url']);
        final imageUrl = removeHtml.delHtml(image['image_url']);
        return {
          'docUrl': docUrl,
          'imageUrl': imageUrl,
        };
      }).toList();
    } else {
      print('api error: ${response.statusCode}');
    }
  }

  // Future<void> goToImageUrl(String url) async {
  //   final Uri uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}
