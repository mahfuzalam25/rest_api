import 'package:flutter/material.dart';
import 'guide_detail_page.dart';

class SafetyGuidePage extends StatelessWidget {
  final List<Map<String, dynamic>> tips = [
    {'title': 'How to Give First Aid', 'icon': Icons.healing},
    {
      'title': 'How to Control High Blood Pressure',
      'icon': Icons.monitor_heart,
    },
    {
      'title': 'How to Stay Safe During Earthquake',
      'icon': Icons.emoji_objects,
    },
    {'title': 'Fire Safety Tips at Home', 'icon': Icons.local_fire_department},
    {
      'title': 'Electric Shock First Response',
      'icon': Icons.electrical_services,
    },
    {'title': 'Basic CPR Instructions', 'icon': Icons.volunteer_activism},
    {'title': 'Road Accident Emergency Steps', 'icon': Icons.car_crash},
    {'title': 'Flood Preparedness and Safety', 'icon': Icons.water_damage},
    {'title': 'Handling Cuts and Bleeding', 'icon': Icons.cut},
    {'title': 'Burn Recovery Measures', 'icon': Icons.whatshot},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2e3a59),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0,
        title: Text('Safety Guide'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tips.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => GuideDetailPage(title: tips[index]['title']),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.redAccent.withOpacity(0.2),
                    child: Icon(tips[index]['icon'], color: Colors.redAccent),
                  ),
                  title: Text(
                    tips[index]['title'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white70,
                    size: 18,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
