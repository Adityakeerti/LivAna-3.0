import 'package:cloud_firestore/cloud_firestore.dart';

class ForumPost {
  final String id;
  final String title;
  final String content;
  final String authorId;
  final String authorName;
  final String authorAvatar;
  final String communityId;
  final List<String> tags;
  final int likes;
  final List<String> likedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  ForumPost({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.authorName,
    required this.authorAvatar,
    required this.communityId,
    required this.tags,
    required this.likes,
    required this.likedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ForumPost.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return ForumPost(
      id: doc.id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      authorId: data['authorId'] ?? '',
      authorName: data['authorName'] ?? '',
      authorAvatar: data['authorAvatar'] ?? '',
      communityId: data['communityId'] ?? '',
      tags: List<String>.from(data['tags'] ?? []),
      likes: data['likes'] ?? 0,
      likedBy: List<String>.from(data['likedBy'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'authorId': authorId,
      'authorName': authorName,
      'authorAvatar': authorAvatar,
      'communityId': communityId,
      'tags': tags,
      'likes': likes,
      'likedBy': likedBy,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
} 