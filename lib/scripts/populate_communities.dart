import 'package:cloud_firestore/cloud_firestore.dart';

final List<Map<String, dynamic>> communities = [
  {
    'id': 'iitb',
    'name': 'IIT Bombay',
    'description': 'Indian Institute of Technology Bombay - One of the premier engineering institutions in India',
    'imageUrl': 'https://upload.wikimedia.org/wikipedia/en/thumb/4/4c/IIT_Bombay_Logo.svg/1200px-IIT_Bombay_Logo.svg.png',
    'memberCount': 0,
  },
  {
    'id': 'iitd',
    'name': 'IIT Delhi',
    'description': 'Indian Institute of Technology Delhi - A leading technical university in India',
    'imageUrl': 'https://upload.wikimedia.org/wikipedia/en/thumb/3/3d/IIT_Delhi_Logo.svg/1200px-IIT_Delhi_Logo.svg.png',
    'memberCount': 0,
  },
  {
    'id': 'geu',
    'name': 'Graphic Era University',
    'description': 'Graphic Era University - A leading private university in Uttarakhand',
    'imageUrl': 'https://www.geu.ac.in/content/dam/geu/images/logo.png',
    'memberCount': 0,
  },
  {
    'id': 'hill',
    'name': 'Graphic Era Hill University',
    'description': 'Hill University - A prestigious educational institution',
    'imageUrl': 'https://example.com/hill-university-logo.png',
    'memberCount': 0,
  },
  {
    'id': 'iitk',
    'name': 'IIT Kanpur',
    'description': 'Indian Institute of Technology Kanpur - A premier engineering institution',
    'imageUrl': 'https://upload.wikimedia.org/wikipedia/en/thumb/5/5c/IIT_Kanpur_Logo.svg/1200px-IIT_Kanpur_Logo.svg.png',
    'memberCount': 0,
  },
  {
    'id': 'iitm',
    'name': 'IIT Madras',
    'description': 'Indian Institute of Technology Madras - One of the top technical universities in India',
    'imageUrl': 'https://upload.wikimedia.org/wikipedia/en/thumb/2/2d/IIT_Madras_Logo.svg/1200px-IIT_Madras_Logo.svg.png',
    'memberCount': 0,
  },
];

Future<void> populateCommunities() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  for (final community in communities) {
    await firestore.collection('communities').doc(community['id']).set(community);
  }
  
  print('Communities populated successfully!');
} 