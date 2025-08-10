// edit_profile_page.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'service/api.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String bio;
  final int worksCompleted;
  final int responses;
  final String phone;
  final String bloodGroup;
  final Map<String, String> location;
  final Map<String, String> experience;
  final Map<String, String> education;
  final Map<String, String> qualification;

  const EditProfilePage({
    Key? key,
    required this.name,
    required this.bio,
    required this.worksCompleted,
    required this.responses,
    required this.phone,
    required this.bloodGroup,
    required this.location,
    required this.experience,
    required this.education,
    required this.qualification,
  }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController bioController;
  late TextEditingController phoneController;
  late TextEditingController bloodGroupController;
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  late Map<String, TextEditingController> locationControllers;
  late Map<String, TextEditingController> experienceControllers;
  late Map<String, TextEditingController> educationControllers;
  late Map<String, TextEditingController> qualificationControllers;

  File? _profileImage;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    bioController = TextEditingController(text: widget.bio);
    phoneController = TextEditingController(text: widget.phone);
    bloodGroupController = TextEditingController(text: widget.bloodGroup);
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    locationControllers = {
      for (var entry in widget.location.entries)
        entry.key: TextEditingController(text: entry.value),
    };

    experienceControllers = {
      for (var entry in widget.experience.entries)
        entry.key: TextEditingController(text: entry.value),
    };

    educationControllers = {
      for (var entry in widget.education.entries)
        entry.key: TextEditingController(text: entry.value),
    };

    qualificationControllers = {
      for (var entry in widget.qualification.entries)
        entry.key: TextEditingController(text: entry.value),
    };
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    phoneController.dispose();
    bloodGroupController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();

    for (var c in locationControllers.values) c.dispose();
    for (var c in experienceControllers.values) c.dispose();
    for (var c in educationControllers.values) c.dispose();
    for (var c in qualificationControllers.values) c.dispose();

    super.dispose();
  }

  Widget _buildBox({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 15),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
          {bool obscure = false}) =>
      TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white12,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );

  Widget _buildMapFields(Map<String, TextEditingController> controllers) {
    return Column(
      children: controllers.entries
          .map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildTextField(e.key, e.value),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E5E5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE53935),
        foregroundColor: Colors.black,
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Picture Upload
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white24),
              ),
              child: Column(children: [
                const Text("Upload a Profile Picture",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () async {
                    final picked = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (picked != null) {
                      setState(() {
                        _profileImage = File(picked.path);
                      });
                    }
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? const Icon(Icons.camera_alt,
                            size: 40, color: Colors.black54)
                        : null,
                  ),
                ),
              ]),
            ),

            _buildBox(
              title: "Personal Info",
              children: [
                _buildTextField("Name", nameController),
                const SizedBox(height: 12),
                _buildTextField("Bio", bioController),
                const SizedBox(height: 12),
                _buildTextField("Phone", phoneController),
                const SizedBox(height: 12),
                _buildTextField("Blood Group", bloodGroupController),
              ],
            ),

            _buildBox(
              title: "Location",
              children: [_buildMapFields(locationControllers)],
            ),

            _buildBox(
              title: "Experience",
              children: [_buildMapFields(experienceControllers)],
            ),

            _buildBox(
              title: "Education",
              children: [_buildMapFields(educationControllers)],
            ),

            _buildBox(
              title: "Certifications",
              children: [_buildMapFields(qualificationControllers)],
            ),

            _buildBox(
              title: "Change Password",
              children: [
                _buildTextField("Current Password", currentPasswordController,
                    obscure: true),
                const SizedBox(height: 12),
                _buildTextField("New Password", newPasswordController,
                    obscure: true),
                const SizedBox(height: 12),
                _buildTextField("Confirm Password", confirmPasswordController,
                    obscure: true),
              ],
            ),

            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _onSave,
              icon: const Icon(Icons.save),
              label: const Text("Save Changes"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE53935),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSave() async {
    if (newPasswordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("New password and confirmation do not match.")));
      return;
    }

    final resp = await ApiService.updateUserProfile(
      phone: phoneController.text,
      address1: locationControllers["Home Address"]?.text ?? "",
      address2: locationControllers["Office Address"]?.text ?? "",
      city: locationControllers["City"]?.text ?? "",
      state: locationControllers["District"]?.text ?? "",
      division: locationControllers["Division"]?.text ?? "",
      zip: locationControllers["Zip Code"]?.text ?? "",
      experience_title: experienceControllers["Title"]?.text ?? "",
      experience_duration: experienceControllers["Duration"]?.text ?? "",
      experience_company: experienceControllers["Company"]?.text ?? "",
      experience_organization_address:
          experienceControllers["Location"]?.text ?? "",
      experience_description: experienceControllers["Description"]?.text ?? "",
      education_institution: educationControllers["Institution"]?.text ?? "",
      education_duration: educationControllers["Duration"]?.text ?? "",
      education_department_name: educationControllers["Field"]?.text ?? "",
      education_institution_address:
          educationControllers["Location"]?.text ?? "",
      certification_title: qualificationControllers["Title"]?.text ?? "",
      certification_year: qualificationControllers["Year"]?.text ?? "",
      certification_description:
          qualificationControllers["Description"]?.text ?? "",
      bio: bioController.text,
      imageFile: _profileImage,
      oldPassword: currentPasswordController.text.isNotEmpty
          ? currentPasswordController.text
          : null,
      newPassword: newPasswordController.text.isNotEmpty
          ? newPasswordController.text
          : null,
      bloodGroup: bloodGroupController.text,
      experience: {
        for (var e in experienceControllers.entries) e.key: e.value.text,
      },
      certification: {
        for (var e in qualificationControllers.entries) e.key: e.value.text,
      },
    );

    if (resp["success"] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully.")));
      Navigator.pop(context, {
        "name": nameController.text,
        "bio": bioController.text,
        "phone": phoneController.text,
        "bloodGroup": bloodGroupController.text,
        "location": {
          for (var e in locationControllers.entries) e.key: e.value.text,
        },
        "experience": {
          for (var e in experienceControllers.entries) e.key: e.value.text,
        },
        "qualification": {
          for (var e in qualificationControllers.entries) e.key: e.value.text,
        },
        "profileImagePath": _profileImage?.path,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(resp["error"] ?? "Failed to update profile.")));
    }
  }
}
