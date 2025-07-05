import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'service/api.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool isEditing = false;
  bool isLoading = true;
  String error = '';

  String name = '';
  String bio = '';
  String phone = '';
  String address1 = '';
  String address2 = '';
  String city = '';
  String state = '';
  String zip = '';
  String imageUrl = '';

  File? selectedImage;
  String oldPassword = '';
  String newPassword = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    setState(() {
      isLoading = true;
      error = '';
    });

    final profileData = await ApiService.getUserProfile();
    if (profileData == null) {
      setState(() {
        error = 'Failed to load profile data.';
        isLoading = false;
      });
      return;
    }

    final profile = profileData['profile'] ?? {};

    setState(() {
      name = profileData['username'] ?? '';
      bio = profile['bio'] ?? '';
      phone = profile['phone'] ?? '';
      address1 = profile['present_address'] ?? '';
      address2 = profile['permanent_address'] ?? '';
      city = profile['city'] ?? '';
      state = profile['state'] ?? '';
      zip = profile['zip_code'] ?? '';
      imageUrl = profile['image'] ?? '';
      isLoading = false;
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    final result = await ApiService.updateUserProfile(
      phone: phone,
      address1: address1,
      address2: address2,
      city: city,
      state: state,
      zip: zip,
      bio: bio,
      imageFile: selectedImage,
      oldPassword: oldPassword.isNotEmpty ? oldPassword : null,
      newPassword: newPassword.isNotEmpty ? newPassword : null,
    );

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      await _loadUserProfile();
      setState(() {
        oldPassword = '';
        newPassword = '';
        selectedImage = null;
        isEditing = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Update failed: ${result['error']}')),
      );
    }
  }

  Widget _buildField(String label, String value, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: isEditing
          ? TextFormField(
              initialValue: value,
              onChanged: onChanged,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: const Color(0xFF3d4d6f),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return '$label cannot be empty';
                }
                return null;
              },
            )
          : _buildDisplay(label, value),
    );
  }

  Widget _buildPasswordField(String label, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        obscureText: true,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: const Color(0xFF3d4d6f),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (val) {
          if (label == "New Password" &&
              val != null &&
              val.isNotEmpty &&
              oldPassword.isEmpty) {
            return 'Old Password is required to set a new password';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDisplay(String label, String value) {
    return Card(
      color: const Color(0xFF3d4d6f),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        subtitle: Text(value, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (error.isNotEmpty) {
      return Scaffold(
        body: Center(child: Text(error)),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF2e3a59),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.redAccent, Color(0xFF2e3a59)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: isEditing ? _pickImage : null,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: selectedImage != null
                              ? FileImage(selectedImage!)
                              : (imageUrl.isNotEmpty
                                      ? NetworkImage(imageUrl)
                                      : const AssetImage('assets/avatar.png'))
                                  as ImageProvider,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      _buildField("Bio", bio, (val) => bio = val),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (isEditing) {
                            if (_formKey.currentState!.validate()) {
                              await _saveProfile();
                            }
                          }
                          setState(() => isEditing = !isEditing);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        icon: Icon(isEditing ? Icons.save : Icons.edit),
                        label: Text(isEditing ? "Save" : "Edit"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildField("Phone", phone, (val) => phone = val),
                    _buildField(
                        "Present Address", address1, (val) => address1 = val),
                    _buildField(
                        "Permanent Address", address2, (val) => address2 = val),
                    _buildField("City", city, (val) => city = val),
                    _buildField("State", state, (val) => state = val),
                    _buildField("Zip Code", zip, (val) => zip = val),
                    if (isEditing) ...[
                      _buildPasswordField(
                          "Old Password", (val) => oldPassword = val),
                      _buildPasswordField(
                          "New Password", (val) => newPassword = val),
                    ] else
                      _buildDisplay("Password", '••••••••'),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
