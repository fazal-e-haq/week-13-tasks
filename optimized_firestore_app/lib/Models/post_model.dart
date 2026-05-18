import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String title;
  final String category;
  final List tags;
  final int likes;
  final Timestamp createdAt;

  PostModel({
    required this.id,
    required this.title,
    required this.category,
    required this.tags,
    required this.likes,
    required this.createdAt,
  });

  factory PostModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PostModel(
      id: doc.id,
      title: data['title'],
      category: data['category'],
      tags: data['tags'],
      likes: data['likes'],
      createdAt: data['createdAt'],
    );
  }
}
