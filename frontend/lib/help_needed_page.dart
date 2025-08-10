import 'package:flutter/material.dart';
import 'package:frontend/add_help_post_form.dart';
import 'post_detail_page.dart';

class HelpNeededPage extends StatelessWidget {
  final List<Map<String, dynamic>> emergencyPosts = [
    {
      'title': 'Road Accident - Dhaka',
      'description': 'Multiple people injured. Need immediate assistance.',
      'time': '2 mins ago',
    },
    {
      'title': 'Flood - Kurigram',
      'description': 'Emergency food & shelter required immediately.',
      'time': '15 mins ago',
    },
    {
      'title': 'Fire Breakout - Chittagong',
      'description': 'Urgent fire service and volunteer needed.',
      'time': '45 mins ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E5E5), //change the color
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Emergency Feed",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AddHelpPostForm()),
                      );
                    },
                    icon: const Icon(Icons.add,
                        size: 18, color: Colors.white), //change the color
                    label: const Text(
                      "Post",
                      style: TextStyle(color: Colors.white), //change the color
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE53935), //change the color
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Divider(color: Colors.black, thickness: 1), //change the color

          // 📰 Feed List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: emergencyPosts.length,
              itemBuilder: (context, index) {
                final post = emergencyPosts[index];
                return _buildPostCard(context, post);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, Map<String, dynamic> post) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white, //change the color
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 Title + Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    post['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87, //change the color
                    ),
                  ),
                ),
                Text(
                  post['time'],
                  style: const TextStyle(
                      color: Colors.black, fontSize: 12), //change the color
                ),
              ],
            ),
            const SizedBox(height: 8),

            // 📝 Description
            Text(
              post['description'],
              style: const TextStyle(
                  color: Colors.black, fontSize: 15), //change the color
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[300], //change the color
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "🚨 Need Help",
                    style: TextStyle(
                      color: Colors.blueAccent, //change the color
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios,
                      color: Colors.grey), //change the color
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PostDetailPage(
                          title: post['title'],
                          description: post['description'],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
