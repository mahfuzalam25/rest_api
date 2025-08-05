import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/edit_profile_page.dart';
import 'package:image_picker/image_picker.dart';
import 'service/api.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String name = "Sourav Das Gupta";
  String bio = "I am a volunteer";
  int worksCompleted = 15;
  int responses = 10;
  String phoneNumber = "017XXXXXXXX";

  Map<String, String> location = {
    "Home Address": "Sylhet Sadar",
    "Office Address": "Leading University",
    "City": "Sylhet",
    "Town": "Ambarkhana",
    "District": "Sylhet",
    "Division": "Sylhet",
  };

  Map<String, String> experience = {
    "Title": "Emergency Volunteer",
    "Date": "Sep, 2022 - Present",
    "Duration": "2 years, 9 months",
    "Company": "Local Emergency Team",
    "Description": "Helped in emergency situations.",
    "Location": "Sylhet, Bangladesh",
  };

  Map<String, String> education = {
    "Institution": "Leading University",
    "Date": "2021 - 2025",
    "Duration": "4 years",
    "Field": "CSE",
    "Location": "Bangladesh",
  };

  Map<String, String> qualification = {
    "Title": "First Aid Certified",
    "Year": "2024",
    "Description": "Trained by Red Cross for first aid.",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D141B),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE53935),
        title: const Text("User Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProfilePage(
                    name: name,
                    bio: bio,
                    worksCompleted: worksCompleted,
                    responses: responses,
                    location: location["Home Address"] ?? "",
                    experience: experience,
                    education: education,
                    qualification: qualification,
                  ),
                ),
              );

              if (result != null) {
                setState(() {
                  name = result["name"];
                  bio = result["bio"];
                  location = Map<String, String>.from(result["location"]);
                  experience = Map<String, String>.from(result["experience"]);
                  qualification = Map<String, String>.from(
                    result["qualification"],
                  );
                });
              }
            },
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildProfileStats(),
            _buildSection("Location", location),
            _buildSection("Experience", experience),
            _buildSection("Education", education),
            _buildSection("Qualifications", qualification),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 30),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE53935), Color(0xFFB71C1C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.withOpacity(0.7),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 45,
              backgroundImage: NetworkImage(
                "https://randomuser.me/api/portraits/men/32.jpg",
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            bio,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: const Icon(Icons.call, size: 18),
            label: const Text("Call Me"),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: phoneNumber));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Number copied to clipboard"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.red[700],
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _infoCard(
                Icons.task_alt,
                "Works",
                "$worksCompleted",
                Colors.greenAccent,
              ),
              const SizedBox(width: 10),
              _infoCard(
                Icons.warning_amber_rounded,
                "Responses",
                "$responses",
                Colors.redAccent,
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _infoCard(IconData icon, String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white10),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Map<String, String> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data.entries
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "${e.key}: ${e.value}",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
