import 'package:davkart_app/components/textfield.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'account_type_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final userNameController = TextEditingController();

  final phoneController = TextEditingController();

  final confirmPasswordController = TextEditingController();
  final String url = 'http://10.0.2.2:8000/api';

  void sendData() async {
    if (confirmPasswordController.text == passwordController.text) {
      final response = await http.post(
        Uri.parse('$url/register'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'email': emailController.text.toUpperCase(),
          'password': passwordController.text,
          'number': phoneController.text,
          'password_confirmation': confirmPasswordController.text,
          'firstname': userNameController.text.split(' ')[0].toUpperCase(),
          'surname': userNameController.text.split(' ').length > 1
              ? userNameController.text.split(' ')[1].toUpperCase()
              : userNameController.text.split(' ')[0].toUpperCase(),
          // Add more key-value pairs as needed
        }),
      );

      Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          data['errors'] != null &&
          data['errors']['email'] != null) {
        for (var message in data['errors']['email']) {
          final banner = MaterialBanner(
            content: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 16),
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
      } else if (response.statusCode == 200 &&
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
      } else if (response.statusCode == 200 && data['user'] != null) {
        // Handle the successful response
        // Access specific data from the response
        final user = data['user'];
        print('Response message: $user');

        try {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AccountType(
                      username:
                          userNameController.text.split(' ')[0].toUpperCase(),
                      email: emailController.text.toUpperCase(),
                    )),
          );
        } catch (e) {
          print('Error during navigation: $e');
        }
      } else {
        // Handle errors
        print('Request failed with status: ${response.statusCode}');
      }
    } else {
      final banner = MaterialBanner(
        content: const Text(
          'Confirm password is incorrect',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        padding: const EdgeInsets.only(top: 10, right: 3, bottom: 10, left: 10),
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
      await Future.delayed(Duration(seconds: 1)); // Adjust the delay as needed
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    }
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
                    'Sign Up!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Center(
                  child: Text(
                    'Create Your account',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyTextField(
                        controller: userNameController,
                        hintText: 'Username',
                        obscureText: false,
                        icon: const Icon(Icons.person),
                        confirm: false,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
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
                        controller: phoneController,
                        hintText: 'Phone number',
                        obscureText: false,
                        icon: const Icon(Icons.phone),
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
                      const SizedBox(
                        height: 30,
                      ),
                      MyTextField(
                          controller: confirmPasswordController,
                          hintText: 'Confirm Password',
                          obscureText: true,
                          icon: const Icon(Icons.lock),
                          confirm: confirmPasswordController.text ==
                                  passwordController.text &&
                              true),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                      color: Color(0xFF3A3A3A), fontSize: 10),
                                  children: [
                                    TextSpan(
                                      text:
                                          'By completing the registration process, you hereby accept and acknowledge our ',
                                    ),
                                    TextSpan(
                                      text: 'Terms of use',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF010CA6),
                                          fontSize:
                                              10), // Adjust the style as needed
                                    ),
                                    TextSpan(
                                      text: ' and ',
                                    ),
                                    TextSpan(
                                      text: 'privacy policy',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF010CA6),
                                          fontSize:
                                              10), // Adjust the style as needed
                                    ),
                                    TextSpan(
                                      text: '.',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const MyCheckbox(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () => {
                          if (_formKey.currentState!.validate()) {sendData()}
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          decoration: BoxDecoration(
                              color: const Color(0xFF010CA6),
                              borderRadius: BorderRadius.circular(40)),
                          child: const Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already Have an account?.',
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
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        )
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF010CA6)),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
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
