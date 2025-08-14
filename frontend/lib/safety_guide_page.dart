import 'package:flutter/material.dart';
import 'guide_detail_page.dart';
import 'service/api.dart';

class SafetyGuidePage extends StatefulWidget {
  const SafetyGuidePage({Key? key}) : super(key: key);

  @override
  _SafetyGuidePageState createState() => _SafetyGuidePageState();
}

class _SafetyGuidePageState extends State<SafetyGuidePage> {
  late Future<List<SafetyGuide>> _futureGuides;

  @override
  void initState() {
    super.initState();
    _futureGuides = ApiService.getSafetyGuides();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E5E5),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0,
        title: const Text('Safety Guide'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<SafetyGuide>>(
        future: _futureGuides,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading guides:\n${snapshot.error}',
                style: const TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No safety guides found',
                style: TextStyle(color: Colors.black),
              ),
            );
          } else {
            final guides = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: guides.length,
              itemBuilder: (context, index) {
                final guide = guides[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => GuideDetailPage(
                            title: guide.title,
                            advices: guide.advices.map((e) => e.text).toList(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.2)),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.redAccent.withOpacity(0.2),
                          child: guide.icon.isNotEmpty
                              ? ClipOval(
                                  child: Image.network(
                                    guide.icon,
                                    width: 24,
                                    height: 24,
                                    errorBuilder: (_, __, ___) => const Icon(
                                        Icons.info,
                                        color: Colors.redAccent),
                                  ),
                                )
                              : const Icon(Icons.info, color: Colors.redAccent),
                        ),
                        title: Text(
                          guide.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
