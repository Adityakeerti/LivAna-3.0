import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/community.dart';

class CommunityService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all available communities
  Stream<List<Community>> getCommunities() {
    return _firestore
        .collection('communities')
        .orderBy('name')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Community.fromJson(doc.data()))
            .toList());
  }

  // Search communities by name
  Stream<List<Community>> searchCommunities(String query) {
    if (query.isEmpty) {
      return getCommunities();
    }
    
    return _firestore
        .collection('communities')
        .orderBy('name')
        .startAt([query.toLowerCase()])
        .endAt([query.toLowerCase() + '\uf8ff'])
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Community.fromJson(doc.data()))
            .toList());
  }

  // Join a community
  Future<void> joinCommunity(String userId, String communityId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .update({'communityId': communityId});
  }

  // Get current user's community ID
  Future<String?> getCurrentUserCommunityId() async {
    // TODO: Implement getting current user's ID
    final userId = 'current_user_id'; // Replace with actual user ID
    final doc = await _firestore.collection('users').doc(userId).get();
    return doc.data()?['communityId'] as String?;
  }
} 