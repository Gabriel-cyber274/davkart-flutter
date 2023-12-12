import 'dart:convert';

import 'package:flutter/material.dart';
import './pages/auth/getstarted.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './pages/mainPages/index_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  bool isLoggedin = false;
  Object userDetails = {};
  String token = '';

  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String? userInfo = await getData('userInfo');
    // final user = json.decode(userInfo);

    if (userInfo != null) {
      try {
        final user = json.decode(userInfo);
        setState(() {
          isLoggedin = true;
          userDetails = user['user'];
          token = user['token'];
        });

        print('User: ${user['user']}, Token: ${user['token']}');

        // Now 'user' is a Dart object representing the JSON structure.
        // print('Username: ${user['username']}, Age: ${user['age']}');
      } catch (e) {
        print('Error decoding JSON: $e');
      }
    } else {
      print('No userInfo found');
      setState(() {
        isLoggedin = false;
      });
    }
    // Now you can use userInfo as needed.
  }

  Future<String?> getData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'first app',
      // home: LoginPage(),
      home: Container(
          // child: GetStartedPage(),
          child: !isLoggedin
              ? const GetStartedPage()
              : IndexPage(
                  userInfo: userDetails,
                  token: token,
                )),
      // ),
    );
  }
}
