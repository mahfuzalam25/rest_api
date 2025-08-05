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
      backgroundColor: const Color(0xFF2e3a59),
      body: Column(
        children: [
          // 🔴 Top Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Emergency Feed",
                    style: TextStyle(
                      color: Colors.white,
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
                    icon: const Icon(Icons.add, size: 18, color: Colors.white),
                    label: const Text(
                      "Post",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
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

          const Divider(color: Colors.white10, thickness: 1),

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
      color: const Color(0xFF2E3547),
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
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  post['time'],
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // 📝 Description
            Text(
              post['description'],
              style: const TextStyle(color: Colors.white70, fontSize: 15),
            ),
            const SizedBox(height: 16),

            // 💬 Help Badge + 🔽 View Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "🚨 Need Help",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => PostDetailPage(
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
