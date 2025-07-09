import 'dart:ui';
import 'package:flutter/material.dart';

class ServiceListPage extends StatefulWidget {
  final String serviceType;
  ServiceListPage({required this.serviceType});

  @override
  _ServiceListPageState createState() => _ServiceListPageState();
}

class _ServiceListPageState extends State<ServiceListPage> {
  final List<Map<String, String>> mockList = [
    {'location': '8 Bazar', 'number': '0123456789'},
    {'location': '5.2 Bazar', 'number': '0987654321'},
    {'location': '2.5 Bazar', 'number': '0112233445'},
    {'location': 'Kamal Bazar', 'number': '01733445566'},
    {'location': 'Moulvibazar', 'number': '01555667788'},
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    final filteredList =
        mockList
            .where(
              (item) =>
                  item['location']!.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    return Scaffold(
      backgroundColor: Color(0xFF2e3a59),
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.serviceType),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: '🔍 Search by area...',
                hintStyle: TextStyle(color: Colors.white70),
                fillColor: Colors.white.withOpacity(0.1),
                filled: true,
                prefixIcon: Icon(Icons.search, color: Colors.white70),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => setState(() => query = value),
            ),
          ),

          // 📋 Service Cards
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final s = filteredList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Stack(
                    children: [
                      // 🎨 Glass-style Card
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(16),
                              leading: CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(0.15),
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                s['location']!,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Call: ${s['number']}',
                                style: TextStyle(color: Colors.white70),
                              ),
                              trailing: Container(
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.call,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Call',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                // Add call action here
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
