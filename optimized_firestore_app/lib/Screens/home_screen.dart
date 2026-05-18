import 'package:flutter/material.dart';
import 'package:optimized_firestore_app/Models/post_model.dart';
import 'package:optimized_firestore_app/Services/firestore_service.dart';
import 'package:optimized_firestore_app/Widgets/post_tile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final services = FirestoreService();
  List<PostModel> posts = [];
  bool loading = false;

  Future loadPosts() async {
    setState(() {
      loading = true;
    });
    final data = await services.getPosts(
      category: 'education',
      tags: 'Flutter',
    );

    posts.addAll(data);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Firebase Optimize')),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return PostTileWidget(post: posts[index]);
                },
              ),
            ),
            ElevatedButton(
              onPressed: loadPosts,
              child: const Text('Load more'),
            ),
          ],
        ),
      ),
    );
  }
}
