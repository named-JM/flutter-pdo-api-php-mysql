import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/main.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userId;

  @override
  void initState() {
    super.initState();
    checkSession();
  }

  Future<void> checkSession() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2/flutter_auth/check_session.php'),
    );

    print('Server response: ${response.body}'); // Debugging

    final data = json.decode(response.body);
    if (data['status'] == 'success') {
      setState(() {
        userId = data['id'];
      });
    } else {
      // Session is invalid, navigate back to login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: userId == null
            ? CircularProgressIndicator()
            : Text('Welcome! Your user ID is $userId'),
      ),
    );
  }
}
