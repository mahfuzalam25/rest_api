import 'package:flutter/material.dart';

class AddHelpPostForm extends StatefulWidget {
  @override
  _AddHelpPostFormState createState() => _AddHelpPostFormState();
}

class _AddHelpPostFormState extends State<AddHelpPostForm> {
  String? selectedLocation;
  final TextEditingController descriptionController = TextEditingController();
  String? selectedImagePath;

  List<String> locations = ['Dhaka', 'Chittagong', 'Sylhet', 'Khulna'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Emergency Help"),
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // 🔙 Back navigation
        ),
      ),
      backgroundColor: Color(0xFFf8f9fa),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                DropdownButtonFormField<String>(
                  value: selectedLocation,
                  hint: Text("Select Location"),
                  items:
                      locations
                          .map(
                            (loc) =>
                                DropdownMenuItem(value: loc, child: Text(loc)),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedLocation = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                  ),
                ),

                SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Write emergency description...",
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImagePath = 'image_selected.png';
                    });
                  },
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                    ),
                    child: Center(
                      child:
                          selectedImagePath == null
                              ? Text("Tap to add image")
                              : Text("Image Selected: $selectedImagePath"),
                    ),
                  ),
                ),

                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Post submitted!")),
                      );
                      Navigator.pop(context); // Optionally go back
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text("Post", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
