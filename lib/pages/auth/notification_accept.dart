import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'location_set_page.dart';

class NotificationAccept extends StatefulWidget {
  final String email;

  NotificationAccept({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<NotificationAccept> createState() => _NotificationAcceptState();
}

class _NotificationAcceptState extends State<NotificationAccept> {
  final String url = 'http://10.0.2.2:8000/api';
  void updateNotification(not) async {
    final response = await http.put(
      Uri.parse('$url/updateNotification'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'email': widget.email,
        'notification': not,
        // Add more key-value pairs as needed
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      final user = data['user'];

      print('Response message: ${user}');
      try {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LocationSet(
                    email: user['email'],
                  )),
        );
      } catch (e) {
        print('Error during navigation: $e');
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => {Navigator.pop(context)},
                      child: Image.asset(
                        'lib/assets/Back.png',
                        // height: 300,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth / 2.9,
                    ),
                    Image.asset(
                      'lib/assets/davkart Logo short 1.png',
                      // height: 300,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Notifications 🔔',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  "Notifications enable you to stay informed about new products and important updates. They also help you track your orders in real-time, ensuring you're always aware of expected delivery times.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF3A3A3A),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 2),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  width: screenWidth,
                  height: 550,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        20.0), // Adjust the border radius as needed
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF010CA6),
                        Color(0xFFFFDB00),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white),
                        width: screenWidth,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Image.asset(
                              'lib/assets/rafiki.png',
                              // height: 300,
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Text(
                                'Allow Davkart to notify you immediately something important happens.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF3A3A3A),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 55,
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    updateNotification(true);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    width: screenWidth,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF010CA6),
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: const Center(
                                      child: Text(
                                        'Yes, allow Notifications',
                                        style: TextStyle(
                                            fontSize: 13.65,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    updateNotification(false);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    width: screenWidth,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          20.0), // Adjust the border radius as needed
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFFFFDB00),
                                          Color(0xFF010CA6),
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: Container(
                                        // padding: const EdgeInsets.all(20),
                                        height: 40,
                                        width: screenWidth,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'I’ll do this later',
                                            style: TextStyle(
                                                fontSize: 13.65,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF010CA6)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(
                height: 60,
              )
            ],
          ),
        )),
      ),
    );
  }
}
