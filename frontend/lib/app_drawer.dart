import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/home_page.dart';
import 'package:frontend/leaderboard_page.dart';
import 'emergency_call_page.dart';
import 'safety_guide_page.dart';
import 'login_screen.dart';
import 'settings_page.dart';
import 'user_profile_page.dart';
import 'package:frontend/service/api.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String username = 'Loading...';
  String email = '';
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    final data = await ApiService.getUserProfile();
    if (data != null) {
      final profile = data['profile'] ?? {};
      setState(() {
        username = data['username'] ?? 'Unknown User';
        email = data['email'] ?? '';
        imageUrl = profile['image'] ??
            'https://ui-avatars.com/api/?name=${data['username'] ?? "User"}&background=ff5252&color=fff';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.redAccent),
            accountName: Text(username),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
          _buildNavItem(Icons.help_outline, 'Help Needed', () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => HomePage()));
          }),
          _buildNavItem(Icons.call, 'Emergency Call', () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => EmergencyCallPage()));
          }),
          _buildNavItem(Icons.menu_book, 'Safety Guide', () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => SafetyGuidePage()));
          }),
          _buildNavItem(Icons.person, 'User Profile', () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const UserProfilePage()));
          }),
          ListTile(
            leading: const Icon(Icons.leaderboard, color: Colors.black),
            title: const Text(
              'Leaderboard',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LeaderboardPage()),
              );
            },
          ),
          const Divider(color: Colors.black, indent: 16, endIndent: 16),
          _buildNavItem(Icons.settings, 'Settings', () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => SettingsPage()));
          }),
          _buildNavItem(Icons.logout, 'Logout', () async {
            await ApiService.logout();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
              (route) => false,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(text,
            style: const TextStyle(color: Colors.white70, fontSize: 14)),
      );

  Widget _buildNavItem(IconData icon, String title, VoidCallback onTap) =>
      ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(title, style: const TextStyle(color: Colors.black)),
        onTap: onTap,
      );
}
