import 'package:flutter/material.dart';
import 'map_user.dart'; // Import the map_user.dart file

class UserDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapUserPage()),
                );
              },
              child: Text('Point Leakage'),
            ),
          ],
        ),
      ),
    );
  }
}
