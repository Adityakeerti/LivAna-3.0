import 'package:cloud_firestore/cloud_firestore.dart';

class ForumComment {
  final String id;
  final String postId;
  final String content;
  final String authorId;
  final String authorName;
  final String authorAvatar;
  final int likes;
  final List<String> likedBy;
  final DateTime createdAt;

  ForumComment({
    required this.id,
    required this.postId,
    required this.content,
    required this.authorId,
    required this.authorName,
    required this.authorAvatar,
    required this.likes,
    required this.likedBy,
    required this.createdAt,
  });

  factory ForumComment.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return ForumComment(
      id: doc.id,
      postId: data['postId'] ?? '',
      content: data['content'] ?? '',
      authorId: data['authorId'] ?? '',
      authorName: data['authorName'] ?? '',
      authorAvatar: data['authorAvatar'] ?? '',
      likes: data['likes'] ?? 0,
      likedBy: List<String>.from(data['likedBy'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'content': content,
      'authorId': authorId,
      'authorName': authorName,
      'authorAvatar': authorAvatar,
      'likes': likes,
      'likedBy': likedBy,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
} 