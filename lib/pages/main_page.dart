import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(),
        leading: Image.asset('images/dlogo.jpeg'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: const [
              Tab(text: '블로그'),
              Tab(text: '동영상'),
              Tab(text: '사진'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                BlogPage(),
                VedioPage(),
                ImagePage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
