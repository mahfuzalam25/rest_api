import 'package:flutter/material.dart';
import 'app_drawer.dart';
import 'help_needed_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency App'),
        backgroundColor: Colors.redAccent,
      ),
      drawer: AppDrawer(),
      body: HelpNeededPage(),
    );
  }
}
