import 'package:daum_api/model/blog_model.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({required this.blogText, super.key});
  final String blogText;

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  BlogModel blogModel = BlogModel();
  List<dynamic> blogList = []; // 블로그 데이터를 저장할 리스트

  void update() => setState(() {});
  @override
  void initState() {
    blogModel.recenBlog();
    super.initState();
    // fetchBlog 메서드 호출 예시
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      if (widget.blogText == '' || widget.blogText.isEmpty) {
        update();
        blogModel.recenBlog();
      } else {
        await blogModel.fetchBlog(widget.blogText);
      }
      update();
      blogList = blogModel.blogData; // 블로그 데이터를 리스트에 저장
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: blogModel.fetchBlog(widget.blogText),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            blogList = blogModel.blogData;
            return ListView.builder(
              itemCount: blogList.length,
              itemBuilder: (context, index) {
                final blogData = blogList[index];
                return ListTile(
                  title: Text(blogData['title']),
                  subtitle: Text(blogData['contents']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
