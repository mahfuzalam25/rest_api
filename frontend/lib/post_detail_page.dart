import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
  final String title;
  final String description;

  const PostDetailPage({
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2e3a59),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Emergency Detail"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo Banner
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/emergency_banner.jpg',
                  ), // replace with actual image or network
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 12),

            // Location Map Placeholder
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Location",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(Icons.map, color: Colors.white54, size: 80),
                ),
                // TODO: Replace this with a Google Map widget or map image later
              ),
            ),

            SizedBox(height: 20),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 12),

            // Description Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "What happened",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent,
                ),
              ),
            ),

            SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.4,
                ),
              ),
            ),

            SizedBox(height: 20),

            // Emergency Needs Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Emergency Help Needed",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent,
                ),
              ),
            ),

            SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "• Ambulance\n• Police\n• Fire Service\n• Medical Aid\n\n"
                "Please respond immediately to assist.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.4,
                ),
              ),
            ),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
