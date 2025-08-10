import 'package:flutter/material.dart';

class GuideDetailPage extends StatelessWidget {
  final String title;
  final List<String> advices;

  const GuideDetailPage({
    Key? key,
    required this.title,
    required this.advices,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> content =
        advices.isNotEmpty ? advices : ['No detailed information available.'];

    return Scaffold(
      backgroundColor: const Color(0xFF2e3a59),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: ListView.builder(
            itemCount: content.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "• ",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Expanded(
                      child: Text(
                        content[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
