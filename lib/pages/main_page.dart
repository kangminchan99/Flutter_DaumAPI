import 'package:daum_api/controller/tab_page_controller.dart';
import 'package:flutter/material.dart';
import '../model/blog_model.dart';
import 'blog_page.dart';
import 'image_page.dart';
import 'vedio_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 3, vsync: this);
  String blogText = '';
  String vedioText = '';
  String imageText = '';
  BlogModel blogModel = BlogModel();
  TabPageController tabpageController = TabPageController();

  @override
  void initState() {
    super.initState();
    tabpageController.blogEditingController = TextEditingController();
    tabpageController.vedioEditingController = TextEditingController();
    tabpageController.imageEditingController = TextEditingController();
  }

  void update() => setState(() {});

  void handleSearch() {
    update();
    blogText = tabpageController.blogEditingController.text; // 텍스트 값 저장
    vedioText = tabpageController.vedioEditingController.text;
    imageText = tabpageController.vedioEditingController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: tabpageController.textEditingController,
        ),
        leading: Image.asset('images/dlogo.jpeg'),
        actions: [
          IconButton(
            onPressed: handleSearch,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: tabController,
            onTap: tabpageController.handleTabChange,
            tabs: const [
              Tab(text: '블로그'),
              Tab(text: '동영상'),
              Tab(text: '사진'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                BlogPage(
                  blogText: blogText,
                ),
                VedioPage(
                  vedioText: vedioText,
                ),
                ImagePage(
                  imageText: imageText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
