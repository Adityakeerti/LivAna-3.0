import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/forum_post.dart';
import '../models/forum_comment.dart';

class ForumService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all posts for a specific community
  Stream<List<ForumPost>> getCommunityPosts(String communityId) {
    return _firestore
        .collection('forum_posts')
        .where('communityId', isEqualTo: communityId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ForumPost.fromFirestore(doc)).toList();
    });
  }

  // Create a new post
  Future<void> createPost(ForumPost post) async {
    await _firestore.collection('forum_posts').add(post.toMap());
  }

  // Get comments for a specific post
  Stream<List<ForumComment>> getPostComments(String postId) {
    return _firestore
        .collection('forum_comments')
        .where('postId', isEqualTo: postId)
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ForumComment.fromFirestore(doc)).toList();
    });
  }

  // Add a comment to a post
  Future<void> addComment(ForumComment comment) async {
    await _firestore.collection('forum_comments').add(comment.toMap());
  }

  // Like/unlike a post
  Future<void> togglePostLike(String postId, String userId, bool isLiked) async {
    final postRef = _firestore.collection('forum_posts').doc(postId);
    
    if (isLiked) {
      await postRef.update({
        'likes': FieldValue.increment(1),
        'likedBy': FieldValue.arrayUnion([userId]),
      });
    } else {
      await postRef.update({
        'likes': FieldValue.increment(-1),
        'likedBy': FieldValue.arrayRemove([userId]),
      });
    }
  }

  // Like/unlike a comment
  Future<void> toggleCommentLike(String commentId, String userId, bool isLiked) async {
    final commentRef = _firestore.collection('forum_comments').doc(commentId);
    
    if (isLiked) {
      await commentRef.update({
        'likes': FieldValue.increment(1),
        'likedBy': FieldValue.arrayUnion([userId]),
      });
    } else {
      await commentRef.update({
        'likes': FieldValue.increment(-1),
        'likedBy': FieldValue.arrayRemove([userId]),
      });
    }
  }
} 