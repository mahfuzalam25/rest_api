import 'package:flutter/material.dart';

class PostDetailPage extends StatefulWidget {
  final String title;
  final String description;

  const PostDetailPage({
    required this.title,
    required this.description,
    super.key,
  });

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  int responseCount = 0;
  int ongoingCount = 0;

  void incrementResponse() {
    setState(() {
      responseCount++;
    });
  }

  void incrementOngoing() {
    setState(() {
      ongoingCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E5E5), //change the color
      appBar: AppBar(
        backgroundColor: Color(0xFFE53935), //change the color
        title: const Text("Emergency Detail",
            style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/emergency_banner.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Location",
                style: TextStyle(
                  color: Colors.black, //change the color
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white, //change the color
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.map,
                      color: Colors.white, size: 80), //change the color
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, //change the color
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white, //change the color
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: Color(0xFFE53935)), //change the color
                ),
                child: Text(
                  widget.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87, //change the color
                    height: 1.4,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Please respond immediately to assist",
                style: TextStyle(
                  color: Color(0xFFE53935), //change the color
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: incrementResponse,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, //change the color
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Respond",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black), //change the color
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: incrementOngoing,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue, //change the color
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Ongoing",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black), //change the color
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white, //change the color
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black), //change the color
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildCountBadge("Responded", responseCount,
                        Colors.green), //change the color
                    _buildCountBadge("Ongoing", ongoingCount,
                        Colors.lightBlue), //change the color
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCountBadge(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          "$count",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label,
            style: const TextStyle(
                fontSize: 14, color: Colors.black)), //change the color
      ],
    );
  }
}
