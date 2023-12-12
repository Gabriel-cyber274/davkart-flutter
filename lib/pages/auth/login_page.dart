import 'package:davkart_app/components/textfield.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'register_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../mainPages/index_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final String url = 'http://10.0.2.2:8000/api';

  void signIn() async {
    try {
      final response = await http.post(
        Uri.parse('$url/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'email': emailController.text,
          'password': passwordController.text,
          // Add more key-value pairs as needed
        }),
      );

      Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          data['errors'] != null &&
          data['errors']['password'] != null) {
        for (var message in data['errors']['password']) {
          final banner = MaterialBanner(
            content: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            padding:
                const EdgeInsets.only(top: 10, right: 3, bottom: 10, left: 10),
            leading: const Icon(
              Icons.error,
              color: Colors.white,
            ),
            elevation: 5,
            backgroundColor: Colors.red,
            actions: [
              TextButton(
                onPressed: () {
                  // Do something when the action is pressed
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ],
          );

          ScaffoldMessenger.of(context).showMaterialBanner(banner);
          await Future.delayed(
              Duration(seconds: 1)); // Adjust the delay as needed
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        }
        print(data['errors']);
      } else if (response.statusCode == 200 && data['user'] != null) {
        // Handle the successful response
        // Access specific data from the response
        final user = data['user'];
        final token = data['token'];
        print('Response message: $user');
        print('Response message: $token');

        saveData('userInfo', data);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => IndexPage(
                    token: token,
                    userInfo: user,
                  )),
        );
      } else {
        final banner = MaterialBanner(
          content: Text(
            data['message'],
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          padding:
              const EdgeInsets.only(top: 10, right: 3, bottom: 10, left: 10),
          leading: const Icon(
            Icons.error,
            color: Colors.white,
          ),
          elevation: 5,
          backgroundColor: Colors.red,
          actions: [
            TextButton(
              onPressed: () {
                // Do something when the action is pressed
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ],
        );

        ScaffoldMessenger.of(context).showMaterialBanner(banner);
        await Future.delayed(
            Duration(seconds: 1)); // Adjust the delay as needed
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      }
    } catch (e) {
      print('Error during navigation: $e');
    }
  }

  Future<void> saveData(String key, Object value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert the object to a JSON string
    String jsonString = jsonEncode(value);

    // Save the JSON string to local storage
    prefs.setString(key, jsonString);

    // int expirationTimestamp =
    //     DateTime.now().add(expirationDuration).millisecondsSinceEpoch;
    // prefs.setInt(_getExpirationKey(), expirationTimestamp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     backgroundColor: Colors.purple,
      //     title: const Center(
      //       child: Text('trials'),
      //     )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => {Navigator.pop(context)},
                        child: Image.asset(
                          'lib/assets/Back.png',
                          // height: 30,
                        ),
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
                const Center(
                  child: Text(
                    'Sign In!',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Center(
                  child: Text(
                    'Login to Your account',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Image.asset(
                  'lib/assets/google button.png',
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'Or With Email',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        MyTextField(
                          controller: emailController,
                          hintText: 'Email',
                          obscureText: false,
                          icon: const Icon(Icons.mail),
                          confirm: false,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        MyTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                          icon: const Icon(Icons.lock),
                          confirm: false,
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Remember me',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w400),
                          ),
                          MyCheckbox(),
                        ],
                      ),
                      Text(
                        'Forgot password?',
                        style: TextStyle(
                            color: Color(0xFF010CA6),
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () => {
                    if (_formKey.currentState!.validate()) {signIn()}
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                        color: const Color(0xFF010CA6),
                        borderRadius: BorderRadius.circular(40)),
                    child: const Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don’t Have an account?.',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF3A3A3A))),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        )
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF010CA6)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyCheckbox extends StatefulWidget {
  const MyCheckbox({super.key});
  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      side: const BorderSide(color: Color(0xFF010CA6), width: 1.2),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
