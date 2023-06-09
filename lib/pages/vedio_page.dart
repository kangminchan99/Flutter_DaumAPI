import 'package:daum_api/model/vedio_model.dart';
import 'package:flutter/material.dart';

class VedioPage extends StatefulWidget {
  const VedioPage({required this.vedioText, super.key});
  final String vedioText;

  @override
  State<VedioPage> createState() => _VedioPageState();
}

class _VedioPageState extends State<VedioPage> {
  VedioModel vedioModel = VedioModel();
  List<dynamic> vedioList = [];

  @override
  void initState() {
    vedioModel.recenVedio();
    super.initState();
    // fetchBlog 메서드 호출 예시
    fetchVedioData();
  }

  void update() => setState(() {});

  Future<void> fetchVedioData() async {
    try {
      if (widget.vedioText == '' || widget.vedioText.isEmpty) {
        update();
        vedioModel.recenVedio();
      } else {
        await vedioModel.fetchVedio(widget.vedioText);
      }
      update();
      vedioList = vedioModel.vedioData; // 블로그 데이터를 리스트에 저장
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: vedioModel.fetchVedio(widget.vedioText),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('error: ${snapshot.error}');
          } else {
            vedioList = vedioModel.vedioData;
            return ListView.builder(
              itemCount: vedioList.length,
              itemBuilder: (context, index) {
                final vedioData = vedioList[index];
                return ListTile(
                  title: Text(vedioData['title']),
                  subtitle: Text(vedioData['url']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
