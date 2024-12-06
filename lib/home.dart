import 'package:flutter/material.dart';
import 'package:flutter_auth/add_business.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = '';
  String userId = '';

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'User';
      userId = prefs.getString('id') ?? 'Unknown';
    });

    // Log the user details to the console
    print('Logged-in User:');
    print('Username: $username');
    print('User ID: $userId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, $username!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the BusinessFormPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BusinessFormPage()),
                );
              },
              child: Text('Add Business'),
            ),
          ],
        ),
      ),
    );
  }
}
