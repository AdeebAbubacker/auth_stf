import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:authentication/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegsiterPage extends StatefulWidget {
  const RegsiterPage({super.key});

  @override
  State<RegsiterPage> createState() => _RegsiterPageState();
}

class _RegsiterPageState extends State<RegsiterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
    final String url = 'http://192.168.1.3:3000/register';

    final Map<String, dynamic> requestData = {
      'username': nameController.text,
      'password': passwordController.text,
    };

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestData),
    );

    Future<void> saveTokenToPrefs(String token) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
    }

    if (response.statusCode == 200) {
      var token = response.body;
      print("token");
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const HomePage();
        },
      ));

      print('registeration successful!');
    } else {

      print('Login failed: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 90),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    hintText: 'Enter name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                    hintText: 'Enter Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                loginUser();
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
