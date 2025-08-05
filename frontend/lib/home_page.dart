import 'package:flutter/material.dart';
import 'app_drawer.dart';
import 'notification_page.dart';
import 'help_needed_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResQlink', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // <-- this sets the drawer icon color
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NotificationPage()),
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: HelpNeededPage(),
    );
  }
}
