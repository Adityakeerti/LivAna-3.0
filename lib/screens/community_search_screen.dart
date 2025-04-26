import 'package:flutter/material.dart';
import '../models/community.dart';
import '../services/community_service.dart';
import '../scripts/populate_communities.dart';
import 'community_details_screen.dart';

class CommunitySearchScreen extends StatefulWidget {
  const CommunitySearchScreen({Key? key}) : super(key: key);

  @override
  _CommunitySearchScreenState createState() => _CommunitySearchScreenState();
}

class _CommunitySearchScreenState extends State<CommunitySearchScreen> {
  final CommunityService _communityService = CommunityService();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Community> _allCommunities = [];

  @override
  void initState() {
    super.initState();
    _loadCommunities();
  }

  void _loadCommunities() {
    _allCommunities = communities.map((data) {
      return Community(
        id: data['id'] as String,
        name: data['name'] as String,
        description: data['description'] as String,
        imageUrl: data['imageUrl'] as String,
        memberCount: data['memberCount'] as int,
      );
    }).toList();
  }

  List<Community> get _filteredCommunities {
    if (_searchQuery.isEmpty) {
      return _allCommunities;
    }
    return _allCommunities.where((community) {
      return community.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          community.description.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildCommunityCard(Community community) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CommunityDetailsScreen(community: community),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.school,
                      size: 36,
                      color: Colors.deepPurple.withOpacity(0.5),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      community.name,
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    community.description,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${community.memberCount} members',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 32,
                    child: ElevatedButton(
                      onPressed: () async {
                        await _communityService.joinCommunity(
                          'current_user_id',
                          community.id,
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text(
                        'Join',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Your Community'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search communities...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            Expanded(
              child: _filteredCommunities.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.search_off,
                            size: 48,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _searchQuery.isEmpty
                                ? 'No communities available yet'
                                : 'No communities found for "$_searchQuery"',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 0,
                        bottom: 16,
                      ),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: _filteredCommunities.length,
                      itemBuilder: (context, index) {
                        return _buildCommunityCard(_filteredCommunities[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
} 