import 'package:flutter/material.dart';
import '../models/forum_post.dart';
import '../services/forum_service.dart';
import '../services/community_service.dart';
import '../widgets/forum_post_card.dart';
import '../widgets/create_post_dialog.dart';
import 'community_search_screen.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> with SingleTickerProviderStateMixin {
  final ForumService _forumService = ForumService();
  final CommunityService _communityService = CommunityService();
  String? _communityId;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _loadCommunityId();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    
    _colorAnimation = ColorTween(
      begin: Colors.deepPurple,
      end: Colors.purple,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadCommunityId() async {
    final communityId = await _communityService.getCurrentUserCommunityId();
    setState(() {
      _communityId = communityId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Forum'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: _communityId == null
          ? AnimatedBuilder(
              animation: _colorAnimation,
              builder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _colorAnimation.value!,
                        _colorAnimation.value!.withOpacity(0.8),
                        Colors.deepPurple.shade300,
                      ],
                    ),
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.2),
                              ),
                              child: const Icon(
                                Icons.people_alt_rounded,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              'You need to join a community first!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black26,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Connect with your peers and start discussions',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 40),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CommunitySearchScreen(),
                                    ),
                                  ).then((_) => _loadCommunityId());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.deepPurple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.search, size: 24),
                                    SizedBox(width: 10),
                                    Text(
                                      'Find Communities',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search posts...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<ForumPost>>(
                    stream: _forumService.getCommunityPosts(_communityId!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      final posts = snapshot.data ?? [];

                      if (posts.isEmpty) {
                        return const Center(
                          child: Text(
                            'No posts yet. Be the first to start a discussion!',
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return ForumPostCard(
                            post: posts[index],
                            onLike: (isLiked) {
                              // TODO: Implement like functionality
                            },
                            onComment: () {
                              // TODO: Implement comment functionality
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: _communityId != null
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => CreatePostDialog(
                    communityId: _communityId!,
                    onPostCreated: () => setState(() {}),
                  ),
                );
              },
              child: const Icon(Icons.add),
              backgroundColor: Colors.deepPurple,
            )
          : null,
    );
  }
} 