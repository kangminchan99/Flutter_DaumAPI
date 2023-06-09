import 'package:flutter/material.dart';

class TabPageController {
  TextEditingController textEditingController = TextEditingController();
  late TextEditingController blogEditingController;
  late TextEditingController vedioEditingController;
  late TextEditingController imageEditingController;

  void handleTabChange(int index) {
    if (index == 0) {
      textEditingController = blogEditingController;
    } else if (index == 1) {
      textEditingController = vedioEditingController;
    } else if (index == 2) {
      textEditingController = imageEditingController;
    }
  }
}
