import 'package:flutter/material.dart';
import 'service_list_page.dart';
import 'service/api.dart';

class EmergencyCallPage extends StatefulWidget {
  @override
  _EmergencyCallPageState createState() => _EmergencyCallPageState();
}

class _EmergencyCallPageState extends State<EmergencyCallPage> {
  List<Map<String, dynamic>> categories = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      final data = await ApiService.getEmergencyCalls();
      setState(() {
        categories = data;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  IconData getCategoryIcon(String title) {
    title = title.toLowerCase();
    if (title.contains('police')) return Icons.local_police;
    if (title.contains('ambulance')) return Icons.local_hospital;
    if (title.contains('hospital')) return Icons.local_hospital_outlined;
    if (title.contains('fire')) return Icons.fire_extinguisher;
    if (title.contains('disaster')) return Icons.warning;
    if (title.contains('electric')) return Icons.electrical_services;
    if (title.contains('gas')) return Icons.local_gas_station;
    return Icons.help; // default
  }

  Color getCategoryColor(String title) {
    title = title.toLowerCase();
    if (title.contains('police')) return Color(0xFFc8e6c9);
    if (title.contains('ambulance')) return Color(0xFFffe0b2);
    if (title.contains('hospital')) return Color(0xFFbbdefb);
    if (title.contains('fire')) return Color(0xFFFFCDD2);
    if (title.contains('disaster')) return Color(0xFFFFF9C4);
    if (title.contains('electric')) return Color(0xFFD1C4E9);
    if (title.contains('gas')) return Color(0xFFB2EBF2);
    return Colors.grey[200]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Emergency Call'),
        backgroundColor: Color(0xFFE53935),
        elevation: 4,
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final item = categories[index];
                  final title = item['station_title'] ?? '';
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ServiceListPage(
                            serviceType: title,
                            stations: (item['info'] as List)
                                .map((station) => {
                                      'station_name':
                                          station['station_name']?.toString() ??
                                              '',
                                      'phone':
                                          station['phone']?.toString() ?? '',
                                      'station_location':
                                          station['station_location']
                                                  ?.toString() ??
                                              '',
                                    })
                                .toList(),
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: getCategoryColor(title),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.redAccent.withOpacity(0.1),
                            child: Icon(
                              getCategoryIcon(title),
                              color: Color(0xFFE53935),
                              size: 36,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2e3a59),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
