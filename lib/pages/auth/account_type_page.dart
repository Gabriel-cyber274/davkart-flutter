import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'notification_accept.dart';

class AccountType extends StatefulWidget {
  final String email;
  final String username;

  // const AccountType({super.key});

  AccountType({Key? key, required this.email, required this.username})
      : super(key: key);

  @override
  State<AccountType> createState() => _AccountTypeState();
}

class _AccountTypeState extends State<AccountType> {
  final String url = 'http://10.0.2.2:8000/api';

  void sendData(admin) async {
    final response = await http.put(
      Uri.parse('$url/updateAdmin'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'email': widget.email,
        'admin': admin,
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
              builder: (context) => NotificationAccept(
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
    // double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              Image.asset(
                'lib/assets/davkart Logo short 1.png',
                // height: 300,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                'Hello ${widget.username} 👋',
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'To ensure you have the best buying and selling experience, Davkart will ask you a few questions to meet your needs.',
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
                  height: 450,
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
                              'lib/assets/seller.png',
                              // height: 300,
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 70),
                              child: Text(
                                'Are You Using Davkart as a buyer or a seller?',
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
                                    bool admin = false;
                                    sendData(admin);
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
                                        'I am a Buyer',
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
                                    bool admin = true;
                                    sendData(admin);
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
                                            'I am a seller',
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
              )
            ],
          ),
        )),
      ),
    );
  }
}
