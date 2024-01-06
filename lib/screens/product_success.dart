import 'package:flutter/material.dart';
import '../pages/mainPages/my_products.dart';

class MyProductSuccess extends StatefulWidget {
  final userInfo;
  final String token;

  const MyProductSuccess({
    super.key,
    required this.userInfo,
    required this.token,
  });

  @override
  State<MyProductSuccess> createState() => _MyProductSuccessState();
}

class _MyProductSuccessState extends State<MyProductSuccess> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'lib/assets/davkart Logo short 1.png',
          height: 28,
        ),
        title: Center(
            child: Text(
          'New Product',
          style: TextStyle(color: Color(0xFF3A3A3A)),
        )),
        backgroundColor:
            Colors.transparent, // Set background color to transparent
        elevation: 0.0,
        actions: [
          Image.asset(
            'lib/assets/Notification.png',
            height: 28,
            // height: 300,
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
              child: Text(
            'SUCCESS!',
            style: TextStyle(color: Color(0xFF3A3A3A99), fontSize: 18),
          )),
          const SizedBox(
            height: 45,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      child: Stack(children: [
                        Container(
                          width: screenWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 203,
                                // padding: const EdgeInsets.all(8.0),
                                child: const Text(
                                  'Your Product has been successfully published',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Image.asset(
                                'lib/assets/check.png',
                                height: 60,
                                width: 60,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                padding: const EdgeInsets.all(2),
                                width: 200,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 25),
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
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyProducts(
                                                  token: widget.token,
                                                  userInfo: widget.userInfo,
                                                )),
                                      );
                                    },
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
                                          'Close',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF3A3A3A)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Image.asset(
                            'lib/assets/Character.png',
                            height: 178.36,
                            width: 66.63,
                          ),
                        ),
                        Positioned(
                          bottom: 95,
                          left: -5,
                          child: Image.asset(
                            'lib/assets/speech-bubble.png',
                            height: 178.36,
                            width: 66.63,
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ))),
    );
  }
}
