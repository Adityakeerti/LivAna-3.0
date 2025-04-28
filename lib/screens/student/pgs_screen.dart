import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/custom_drawer.dart';

class PgsScreen extends StatefulWidget {
  const PgsScreen({Key? key}) : super(key: key);

  @override
  _PgsScreenState createState() => _PgsScreenState();
}

class _PgsScreenState extends State<PgsScreen> {
  final List<Map<String, dynamic>> _pgs = [
    {
      'name': 'Sunshine PG',
      'location': 'Near University',
      'price': '₹5000/month',
      'amenities': ['WiFi', 'AC', 'Food', 'Laundry', 'Parking'],
      'rating': 4.5,
      'image': 'assets/images/pg1.jpg',
      'description': 'A comfortable and well-maintained PG with all modern amenities.',
      'owner': 'Mr. Sharma',
      'phone': '+91 9876543210',
    },
    {
      'name': 'Green Valley PG',
      'location': 'City Center',
      'price': '₹6000/month',
      'amenities': ['WiFi', 'AC', 'Food', 'Gym', 'Parking'],
      'rating': 4.8,
      'image': 'assets/images/pg2.jpg',
      'description': 'Premium PG with gym facilities and 24/7 security.',
      'owner': 'Ms. Patel',
      'phone': '+91 9876543211',
    },
    {
      'name': 'Royal PG',
      'location': 'Near College',
      'price': '₹4500/month',
      'amenities': ['WiFi', 'Food', 'Laundry', 'Parking'],
      'rating': 4.2,
      'image': 'assets/images/pg3.jpg',
      'description': 'Affordable PG with basic amenities and good food.',
      'owner': 'Mr. Singh',
      'phone': '+91 9876543212',
    },
  ];

  int _selectedRating = 0;
  final TextEditingController _reviewController = TextEditingController();
  final List<Map<String, dynamic>> _reviews = [];

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _resetReviewForm() {
    setState(() {
      _selectedRating = 0;
      _reviewController.clear();
    });
  }

  void _addReview(String text, int rating) {
    setState(() {
      _reviews.add({
        'text': text,
        'rating': rating,
        'date': DateTime.now(),
        'user': 'You', // In a real app, this would be the actual user's name
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFF8F9FA),
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          'PGs List',
          style: TextStyle(
            color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkMode
                ? [const Color(0xFF1A1A1A), const Color(0xFF2A2A2A)]
                : [const Color(0xFFF8F9FA), const Color(0xFFE9ECEF)],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _pgs.length,
          itemBuilder: (context, index) {
            final pg = _pgs[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
              margin: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                onTap: () => _showPgDetails(context, pg, isDarkMode),
                borderRadius: BorderRadius.circular(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.asset(
                        pg['image'],
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                            child: Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: isDarkMode ? Colors.white70 : Colors.grey.shade400,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  pg['name'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2ECC71),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  pg['price'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16, color: isDarkMode ? Colors.white70 : Colors.grey.shade700),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  pg['location'],
                                  style: TextStyle(
                                    color: isDarkMode ? Colors.white70 : Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            children: pg['amenities'].map<Widget>((amenity) {
                              return Chip(
                                label: Text(
                                  amenity,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDarkMode ? Colors.white : const Color(0xFF6C5CE7),
                                  ),
                                ),
                                backgroundColor: isDarkMode 
                                    ? const Color(0xFF6C5CE7).withOpacity(0.2)
                                    : const Color(0xFF6C5CE7).withOpacity(0.1),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 20),
                                  const SizedBox(width: 4),
                                  Text(
                                    pg['rating'].toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: const Icon(Icons.phone, color: Color(0xFF2ECC71)),
                                onPressed: () => launchUrl(Uri.parse('tel:${pg['phone']}')),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1);
          },
        ),
      ),
    );
  }

  void _showPgDetails(BuildContext context, Map<String, dynamic> pg, bool isDarkMode) {
    _resetReviewForm();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                height: 4,
                width: 40,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.white30 : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pg['name'],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        pg['location'],
                        style: TextStyle(
                          color: isDarkMode ? Colors.white70 : Colors.grey.shade600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          pg['image'],
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                  color: isDarkMode ? Colors.white70 : Colors.grey.shade400,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        pg['description'],
                        style: TextStyle(
                          color: isDarkMode ? Colors.white70 : Colors.grey.shade700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Amenities',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: pg['amenities'].map<Widget>((amenity) {
                          return Chip(
                            label: Text(
                              amenity,
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : const Color(0xFF6C5CE7),
                              ),
                            ),
                            backgroundColor: isDarkMode 
                                ? const Color(0xFF6C5CE7).withOpacity(0.2)
                                : const Color(0xFF6C5CE7).withOpacity(0.1),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle view location
                          launchUrl(Uri.parse('https://www.google.com/maps'));
                        },
                        icon: const Icon(Icons.location_on, color: Colors.white),
                        label: const Text(
                          'View Location',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3498DB),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Contact Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListTile(
                        leading: Icon(
                          Icons.person,
                          color: isDarkMode ? Colors.white70 : Colors.grey.shade700,
                        ),
                        title: Text(
                          pg['owner'],
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.grey.shade800,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.phone,
                          color: isDarkMode ? Colors.white70 : Colors.grey.shade700,
                        ),
                        title: Text(
                          pg['phone'],
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.grey.shade800,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.phone, color: Color(0xFF2ECC71)),
                          onPressed: () => launchUrl(Uri.parse('tel:${pg['phone']}')),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Reviews',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: _reviewController,
                              maxLines: 2,
                              decoration: InputDecoration(
                                hintText: 'Write your review here...',
                                hintStyle: TextStyle(
                                  color: isDarkMode ? Colors.white54 : Colors.grey.shade600,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              ),
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(5, (index) {
                                    return IconButton(
                                      icon: Icon(
                                        Icons.star,
                                        color: index < _selectedRating ? Colors.amber : Colors.grey,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        setModalState(() {
                                          _selectedRating = index + 1;
                                        });
                                      },
                                      padding: const EdgeInsets.all(2),
                                    );
                                  }),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_selectedRating == 0) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Please select a rating'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                        return;
                                      }
                                      if (_reviewController.text.trim().isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Please write a review'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                        return;
                                      }
                                      setState(() {
                                        _addReview(_reviewController.text.trim(), _selectedRating);
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Review posted successfully!'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      _resetReviewForm();
                                      setModalState(() {}); // Refresh the modal state
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF6C5CE7),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    ),
                                    child: const Text(
                                      'Post Review',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (_reviews.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'No reviews yet. Be the first to review!',
                              style: TextStyle(
                                color: isDarkMode ? Colors.white70 : Colors.grey.shade600,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _reviews.length,
                          itemBuilder: (context, index) {
                            final review = _reviews[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        review['user'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isDarkMode ? Colors.white : Colors.black,
                                        ),
                                      ),
                                      Text(
                                        '${review['date'].day}/${review['date'].month}/${review['date'].year}',
                                        style: TextStyle(
                                          color: isDarkMode ? Colors.white70 : Colors.grey.shade600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: List.generate(5, (starIndex) {
                                      return Icon(
                                        Icons.star,
                                        size: 16,
                                        color: starIndex < review['rating']
                                            ? Colors.amber
                                            : Colors.grey,
                                      );
                                    }),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    review['text'],
                                    style: TextStyle(
                                      color: isDarkMode ? Colors.white70 : Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
