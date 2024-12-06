import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//BUSINESS PAGE
class BusinessFormPage extends StatefulWidget {
  @override
  _BusinessFormPageState createState() => _BusinessFormPageState();
}

class _BusinessFormPageState extends State<BusinessFormPage> {
  final TextEditingController _bnameController = TextEditingController();
  final TextEditingController _bnumController = TextEditingController();
  final TextEditingController _baddressController = TextEditingController();
  final TextEditingController _bcategoryController = TextEditingController();

  // Business form submission logic (this will send the form data to the backend)
  Future<void> submitBusinessForm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('id') ?? '';

    final response = await http.post(
      Uri.parse('http://10.0.2.2/flutter_auth/add_business.php'),
      body: {
        'bname': _bnameController.text,
        'bnum': _bnumController.text,
        'baddress': _baddressController.text,
        'bcategory': _bcategoryController.text,
        'user_id': userId, // Send the logged-in user ID
      },
    );

    // Log the response body for debugging
    print('Response body: ${response.body}');
    print('Response status code: ${response.statusCode}');

    // Check if the response is successful
    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Business added successfully!')),
          );
          Navigator.pop(context); // Go back to the home page or another page
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'])),
          );
        }
      } catch (e) {
        print('Error decoding JSON: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add business. Please try again.')),
        );
      }
    } else {
      print('Server returned status code ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Server error. Please try again later.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Business Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _bnameController,
              decoration: InputDecoration(labelText: 'Business Name'),
            ),
            TextField(
              controller: _bnumController,
              decoration: InputDecoration(labelText: 'Business Number'),
            ),
            TextField(
              controller: _baddressController,
              decoration: InputDecoration(labelText: 'Business Address'),
            ),
            TextField(
              controller: _bcategoryController,
              decoration: InputDecoration(labelText: 'Business Category'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitBusinessForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
