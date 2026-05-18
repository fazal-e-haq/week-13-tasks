import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optimized_firestore_app/Models/post_model.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;
  DocumentSnapshot? lastDoc;

  Future<List<PostModel>> getPosts({
    required String category,
    String? tags,
  }) async {
    Query query = db.collection('Posts');

    query = query.where('category', isEqualTo: 'education');
    if (tags != null) {
      query = query.where('tags', arrayContains: 'flutter');
    }
    query = query.orderBy('createdAt', descending: true).limit(10);

    if (lastDoc != null) {
      query = query.startAfterDocument(lastDoc!);
    }

    final snapshot = await query.get();
    if (snapshot.docs.isNotEmpty) {
      lastDoc = snapshot.docs.last;
    }

    return snapshot.docs.map((e) => PostModel.fromDoc(e)).toList();
  }

  Future<void> likePosts(String postId) async {
    await db.collection('Posts').doc(postId).update({
      'likes': FieldValue.increment(1),
    });
  }

  Future<void> addPostBatch(List<Map<String, dynamic>> posts) async {
    final batch = db.batch();
    for (var post in posts) {
      final doc = db.collection('Posts').doc();
      batch.set(doc, post);
    }
    await batch.commit();
  }

  Future<PostModel> getPostbyId(String id) async {
    final doc = await db.collection('Posts').doc(id).get();
    return PostModel.fromDoc(doc);
  }
}
