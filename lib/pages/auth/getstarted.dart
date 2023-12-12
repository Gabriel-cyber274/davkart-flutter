import 'package:flutter/material.dart';
import 'login_page.dart';
// import 'package:google_fonts/google_fonts.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Column(
            children: [
              Image.asset(
                'lib/assets/Davkart Logo full.png',
                // height: 30,
              ),
              const Text(
                'Welcome to Davkart!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 25,
              ),
              Image.asset(
                'lib/assets/Smiling People.png',
                // height: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Hi there! We're thrilled to have you on board. At Davkart, we're all about simplifying the way you connect with FMCG manufacturers, wholesalers, and distributors. Let's start this journey together and explore the endless possibilities.",
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400, height: 2),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  )
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: const Color(0xFF010CA6),
                      borderRadius: BorderRadius.circular(40)),
                  child: const Center(
                    child: Text(
                      'Get Started',
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
                height: 40,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
