import 'package:flutter/material.dart';
import '../models/forum_post.dart';

class ForumPostCard extends StatelessWidget {
  final ForumPost post;
  final Function(bool) onLike;
  final VoidCallback onComment;

  const ForumPostCard({
    Key? key,
    required this.post,
    required this.onLike,
    required this.onComment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post header with author info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(post.authorAvatar),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.authorName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        _formatDate(post.createdAt),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    // TODO: Implement post options menu
                  },
                ),
              ],
            ),
          ),
          // Post content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  post.content,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                // Tags
                Wrap(
                  spacing: 8,
                  children: post.tags.map((tag) {
                    return Chip(
                      label: Text(
                        tag,
                        style: const TextStyle(fontSize: 12),
                      ),
                      backgroundColor: Colors.grey[200],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Post actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Like button
                IconButton(
                  icon: Icon(
                    post.likedBy.contains('currentUserId') // TODO: Replace with actual user ID
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: post.likedBy.contains('currentUserId')
                        ? Colors.red
                        : Colors.grey,
                  ),
                  onPressed: () {
                    onLike(!post.likedBy.contains('currentUserId'));
                  },
                ),
                Text(post.likes.toString()),
                const SizedBox(width: 16),
                // Comment button
                IconButton(
                  icon: const Icon(Icons.comment),
                  onPressed: onComment,
                ),
                const Text('Comments'),
                const Spacer(),
                // Share button
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    // TODO: Implement share functionality
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
} 