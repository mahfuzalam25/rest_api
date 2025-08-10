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
  bool isLoading = true;

  String name = "";
  String bio = "";
  String profileImage = "";
  String phoneNumber = "";
  String bloodGroup = "";

  int worksCompleted = 15; // Static placeholder
  int responses = 10; // Static placeholder

  Map<String, String> location = {};
  Map<String, String> experience = {};
  Map<String, String> education = {};
  Map<String, String> qualification = {};

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profileData = await ApiService.getUserProfile();

    if (profileData != null) {
      final profile = profileData['profile'];
      setState(() {
        name = "${profileData['first_name']} ${profileData['last_name']}";
        bio = profile['bio'] ?? "";
        profileImage = profile['image'] ?? "";
        phoneNumber = profile['phone'] ?? "";
        bloodGroup = profile['blood_group'] ?? "";

        location = {
          "Home Address": profile['location']?['home_address'] ?? "",
          "Office Address": profile['location']?['office_address'] ?? "",
          "City": profile['location']?['city'] ?? "",
          "District": profile['location']?['district'] ?? "",
          "Division": profile['location']?['division'] ?? "",
          "Zip Code": profile['location']?['zip_code'] ?? "",
        };

        experience = {
          "Title": profile['experience']?['experience_title'] ?? "",
          "Duration": profile['experience']?['duration'] ?? "",
          "Company": profile['experience']?['organization_name'] ?? "",
          "Location": profile['experience']?['organization_address'] ?? "",
          "Description": profile['experience']?['description'] ?? "",
        };

        education = {
          "Institution": profile['education']?['institution_name'] ?? "",
          "Duration": profile['education']?['duration'] ?? "",
          "Field": profile['education']?['department_name'] ?? "",
          "Location": profile['education']?['institution_address'] ?? "",
        };

        qualification = {
          "Title": profile['certification']?['certificate_title'] ?? "",
          "Year": profile['certification']?['year'] ?? "",
          "Description": profile['certification']?['description'] ?? "",
        };

        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E5E5),
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
                    phone: phoneNumber,
                    bloodGroup: bloodGroup,
                    location: location,
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
                  bloodGroup = result["bloodGroup"] ?? bloodGroup;
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(),
                  _buildProfileStats(),
                  _buildSection("Blood Group", {"Blood Group": bloodGroup}),
                  _buildSection("Location", location),
                  _buildSection("Experience", experience),
                  _buildSection("Education", education),
                  _buildSection("Certifications", qualification),
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
            child: CircleAvatar(
              radius: 45,
              backgroundImage: profileImage.isNotEmpty
                  ? NetworkImage(profileImage)
                  : const AssetImage("assets/default_user.png")
                      as ImageProvider,
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
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
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
      child: Row(
        children: [
          _infoCard(
              Icons.task_alt, "Works", "$worksCompleted", Colors.greenAccent),
          const SizedBox(width: 10),
          _infoCard(Icons.warning_amber_rounded, "Responses", "$responses",
              Colors.redAccent),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
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
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
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
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.withOpacity(0.1),
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
                          color: Colors.black,
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
