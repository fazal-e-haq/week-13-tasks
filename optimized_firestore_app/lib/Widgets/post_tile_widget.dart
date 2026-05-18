import 'package:flutter/material.dart';
import 'package:optimized_firestore_app/Models/post_model.dart';
import 'package:optimized_firestore_app/Services/firestore_service.dart';

class PostTileWidget extends StatelessWidget {
  const PostTileWidget({super.key, required this.post});
  final PostModel post;
  @override
  Widget build(BuildContext context) {
    final service = FirestoreService();
    return ListTile(
      title: Text(post.title),
      subtitle: Text(post.category),
      trailing: IconButton(
        onPressed: () {
          service.likePosts(post.id);
        },
        icon: const Icon(Icons.favorite),
      ),
    );
  }
}
