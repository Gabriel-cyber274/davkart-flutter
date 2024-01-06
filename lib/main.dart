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
  bool isLoggedin = false;
  Object userDetails = {};
  String token = '';
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
    Future.delayed(Duration.zero, () async {
      await checkPage();
    });
  }

  Future<void> _initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> checkPage() async {
    int? savedTimestamp = await _getSavedTimestamp();

    if (savedTimestamp != null) {
      bool moreThanTenHours = _isMoreThanTenHours(savedTimestamp);
      print('hello: $moreThanTenHours');

      if (moreThanTenHours) {
        await deleteFromSharedPreferences('userInfo');
        await deleteFromSharedPreferences('userInfoTimestamp');
        setState(() {}); // Trigger a rebuild
      } else {
        await fetchData(); // Fetch data if not more than 10 hours
      }
    } else {
      setState(() {}); // Trigger a rebuild
    }
  }

  Future<void> deleteFromSharedPreferences(String key) async {
    await prefs?.remove(key);
  }

  // Future<void> _saveItem() async {
  //   final DateTime now = DateTime.now();
  //   await prefs?.setInt('userInfo', now.millisecondsSinceEpoch);
  //   print('Item saved at: $now');
  // }

  Future<int?> _getSavedTimestamp() async {
    prefs = await SharedPreferences.getInstance();
    int? timestamp;
    dynamic storedValue = prefs?.get('userInfoTimestamp');

    if (storedValue is int) {
      // If the stored value is already an integer, use it directly
      timestamp = storedValue;
    } else if (storedValue is String) {
      // If the stored value is a string, try to parse it as an integer
      try {
        timestamp = int.parse(storedValue);
      } catch (e) {
        print('Error parsing string to int: $e');
      }
    }

    print('Saved timestamp: $timestamp');
    return timestamp;
  }

  bool _isMoreThanTenHours(int savedTimestamp) {
    final DateTime now = DateTime.now();
    final DateTime savedDate =
        DateTime.fromMillisecondsSinceEpoch(savedTimestamp);
    final Duration difference = now.difference(savedDate);
    print('tense: ${difference.inHours}');
    return difference.inHours >= 5;
  }

  Future<void> fetchData() async {
    Object? userData = await getData('userInfo');

    if (userData != null) {
      try {
        // Explicitly cast userData to Map<String, dynamic>
        Map<String, dynamic>? userDataMap = userData as Map<String, dynamic>?;

        if (userDataMap != null) {
          final user = userDataMap['user'];
          final tokenp = userDataMap['token'];
          setState(() {
            isLoggedin = true;
            userDetails = user;
            token = tokenp;
          });

          // print('User: $user, Token: $token');
        } else {
          print('userData is not a Map<String, dynamic>');
        }
      } catch (e) {
        print('Error decoding JSON: $e');
      }
    } else {
      print('No userInfo found');
      setState(() {
        isLoggedin = false;
      });
    }
  }

  Future<Object?> getData(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jsonString = prefs.getString(key);

      if (jsonString != null) {
        // Convert the JSON string back to an object
        Object data = jsonDecode(jsonString);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting data for key $key: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Davkart App',
        // home: LoginPage(),
        home: isLoggedin
            ? IndexPage(
                userInfo: userDetails,
                token: token,
              )
            : const GetStartedPage());
  }
}
