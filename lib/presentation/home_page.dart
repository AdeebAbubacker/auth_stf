import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
//sssssssssssssssssssssssssss
class _HomePageState extends State<HomePage> {
  String data = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFzZWViIiwiaWF0IjoxNjk5NzYwODI4LCJleHAiOjE2OTk3NjQ0Mjh9.KV21jOEF697T_nLUnXS6MAFNi6ukInXBmt4OIDqRF_0";

    if (token != null) {
      final String url = 'http://192.168.1.6:3000/fetchdata';

      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        setState(() {
          data = response.body.toString();
        });

      } else if (response.statusCode == 401) {
        print('Token expired. Attempting to refresh...');
      } else {
        print('API request failed: ${response.body}');
      }

    } else {
      print('Token is missing. User is not authenticated.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text('Data from API: $data'),
          ],
        ),
      ),
    );
  }
}
