
import 'package:flutter/material.dart';
import 'package:frontend/add_help_post_form.dart';
import 'post_detail_page.dart';

class HelpNeededPage extends StatelessWidget {
  final List<Map<String, String>> emergencyPosts = [
    {
      'title': 'Road Accident - Dhaka',
      'description': 'Multiple people injured. Need ambulance & police.',
    },
    {
      'title': 'Flood - Kurigram',
      'description': 'Emergency food & shelter required immediately.',
    },
    {
      'title': 'Fire Breakout - Chittagong',
      'description': 'A building is burning. Urgent fire service needed.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2e3a59),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text(
                "Post Your Emergency",
                style: TextStyle(color: Colors.white), // ✅ Text color
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddHelpPostForm()),
                );
              },
            ),
          ),

          SizedBox(height: 16),
          Text(
            "Emergency Posts",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 8),

          ...emergencyPosts.map(
            (post) => Card(
              child: ListTile(
                leading: Icon(Icons.warning, color: Colors.red),
                title: Text(post['title']!),
                subtitle: Text(post['description']!),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => PostDetailPage(
                            title: post['title']!,
                            description: post['description']!,
                          ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
