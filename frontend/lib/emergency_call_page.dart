import 'package:flutter/material.dart';
import 'service_list_page.dart';

class EmergencyCallPage extends StatelessWidget {
  final services = [
    {
      'name': 'Police Station',
      'icon': Icons.local_police,
      'color': Color(0xFFc8e6c9),
    },
    {
      'name': 'Ambulance',
      'icon': Icons.local_hospital,
      'color': Color(0xFFffe0b2),
    },
    {
      'name': 'Hospital',
      'icon': Icons.local_hospital_outlined,
      'color': Color(0xFFbbdefb),
    },
    {
      'name': 'Fire Service',
      'icon': Icons.fire_extinguisher,
      'color': Color(0xFFFFCDD2),
    },
    {
      'name': 'Disaster Relief',
      'icon': Icons.warning,
      'color': Color(0xFFFFF9C4),
    },
    {
      'name': 'Electric Emergency',
      'icon': Icons.electrical_services,
      'color': Color(0xFFD1C4E9),
    },
    {
      'name': 'Gas Leak Help',
      'icon': Icons.local_gas_station,
      'color': Color(0xFFB2EBF2),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2e3a59),
      appBar: AppBar(
        title: Text('Emergency Call'),
        backgroundColor: Colors.redAccent,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: services.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final item = services[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ServiceListPage(
                      serviceType: item['name'] as String,
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  color: item['color'] as Color,
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
                        item['icon'] as IconData,
                        color: Colors.redAccent,
                        size: 36,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      item['name'] as String,
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
