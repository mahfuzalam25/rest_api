import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _locationTrackingEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2e3a59),
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        iconTheme: IconThemeData(
          color: Colors.white,
        ), // ensures back icon is white
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: Text(
                'Enable Notifications',
                style: TextStyle(color: Colors.white),
              ),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            SwitchListTile(
              title: Text(
                'Enable Location Tracking',
                style: TextStyle(color: Colors.white),
              ),
              value: _locationTrackingEnabled,
              onChanged: (bool value) {
                setState(() {
                  _locationTrackingEnabled = value;
                });
              },
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.white),
              title: Text('App Version', style: TextStyle(color: Colors.white)),
              subtitle: Text('1.0.0', style: TextStyle(color: Colors.white70)),
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip, color: Colors.white),
              title: Text(
                'Privacy Policy',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Privacy Policy clicked')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
