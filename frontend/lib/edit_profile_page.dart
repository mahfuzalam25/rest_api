import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String bio;
  final int worksCompleted;
  final int responses;
  final String location;
  final Map<String, String> experience;
  final Map<String, String> education;
  final Map<String, String> qualification;

  const EditProfilePage({
    super.key,
    required this.name,
    required this.bio,
    required this.worksCompleted,
    required this.responses,
    required this.location,
    required this.experience,
    required this.education,
    required this.qualification,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController bioController;

  late Map<String, TextEditingController> locationControllers;
  late Map<String, TextEditingController> experienceControllers;
  late Map<String, TextEditingController> qualificationControllers;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.name);
    bioController = TextEditingController(text: widget.bio);

    locationControllers = {
      "Home Address": TextEditingController(text: ""),
      "Office Address": TextEditingController(text: ""),
      "City": TextEditingController(text: ""),
      "Town": TextEditingController(text: ""),
      "District": TextEditingController(text: ""),
      "Division": TextEditingController(text: ""),
    };

    experienceControllers = {
      for (var entry in widget.experience.entries)
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
    for (var c in locationControllers.values) {
      c.dispose();
    }
    for (var c in experienceControllers.values) {
      c.dispose();
    }
    for (var c in qualificationControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Widget _buildBox({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
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
          const SizedBox(height: 15),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white12,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildMapFields(Map<String, TextEditingController> controllers) {
    return Column(
      children:
          controllers.entries
              .map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildTextField(entry.key, entry.value),
                ),
              )
              .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1D25),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB71C1C),
        foregroundColor: Colors.white,
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildBox(
              title: "Edit Your Personal Info",
              children: [
                _buildTextField("Name", nameController),
                const SizedBox(height: 15),
                _buildTextField("Bio", bioController),
              ],
            ),
            _buildBox(
              title: "Add Your Location",
              children: [_buildMapFields(locationControllers)],
            ),
            _buildBox(
              title: "Experience",
              children: [_buildMapFields(experienceControllers)],
            ),
            _buildBox(
              title: "Qualification",
              children: [_buildMapFields(qualificationControllers)],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                final updatedData = {
                  "name": nameController.text,
                  "bio": bioController.text,
                  "location": {
                    for (var entry in locationControllers.entries)
                      entry.key: entry.value.text,
                  },
                  "experience": {
                    for (var entry in experienceControllers.entries)
                      entry.key: entry.value.text,
                  },
                  "qualification": {
                    for (var entry in qualificationControllers.entries)
                      entry.key: entry.value.text,
                  },
                };

                Navigator.pop(context, updatedData);
              },
              icon: const Icon(Icons.save),
              label: const Text("Save Changes"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red[700],
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
