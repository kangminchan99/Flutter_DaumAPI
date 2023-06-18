import 'package:daum_api/model/image_model.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({required this.imageText, super.key});
  final String imageText;

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  List<dynamic> imageList = [];
  ImageModel imageModel = ImageModel();
  void update() => setState(() {});

  @override
  void initState() {
    imageModel.recenImage();
    super.initState();
    fetchImageData();
  }

  Future<void> fetchImageData() async {
    try {
      update();
      imageList = imageModel.imageList;
      if (widget.imageText == '' || widget.imageText.isEmpty) {
        update();
        imageModel.recenImage();
      } else {
        await imageModel.fetchImage(widget.imageText);
      }
    } catch (error) {
      print('error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: imageModel.fetchImage(widget.imageText),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              imageList = imageModel.imageList;
              return ListView.builder(
                  itemCount: imageList.length,
                  itemBuilder: (context, index) {
                    final imageData = imageList[index];
                    return InkWell(
                      onTap: () {
                        imageModel.goToImageUrl(imageData['imageUrl']);
                      },
                      child: ListTile(
                        title: Text(imageData['docUrl']),
                        subtitle: Text(imageData['imageUrl']),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
