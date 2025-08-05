import 'package:flutter/material.dart';
import 'post_detail_page.dart';

class NotificationPage extends StatelessWidget {
  final List<String> responded = [
    'Mahfuz responded on your post.',
    'Arina responded on your post.',
    'Sourav responded on your post.',
  ];

  final List<String> ongoing = [
    'Mahfuz is on going.',
    'Arina is on going.',
    'Sourav is on going.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E5E5),
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView(
        children: [
          _buildSectionTitle('Response on your post'),
          ...responded.map(
            (message) => _buildNotificationCard(message, context),
          ),
          _buildSectionTitle('On going'),
          ...ongoing.map((message) => _buildNotificationCard(message, context)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildNotificationCard(String message, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PostDetailPage(title: 'Notification', description: message),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.notifications_active, color: Colors.redAccent),
            SizedBox(width: 10),
            Expanded(child: Text(message, style: TextStyle(fontSize: 16))),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
