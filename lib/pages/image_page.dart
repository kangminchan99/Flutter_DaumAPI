import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({required this.imageText, super.key});
  final String imageText;

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('image'),
    );
  }
}
