import 'package:flutter/material.dart';
import '../../components/bottom_navigation_bar.dart';
import 'index_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/nav.dart';
import '../auth/login_page.dart';
import 'my_products.dart';

class MySettings extends StatefulWidget {
  final Object userInfo;
  final String token;

  const MySettings({super.key, required this.userInfo, required this.token});

  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  int _currentIndex = 4;

  @override
  void initState() {
    setState(() {
      _currentIndex = 4;
    });
  }

  void Logout() async {
    Future.delayed(Duration(seconds: 2), () {});
    await deleteFromSharedPreferences('userInfo');
    await deleteFromSharedPreferences('userInfoTimestamp');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Future<void> deleteFromSharedPreferences(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isHorizontal = screenWidth > screenHeight;

    double childAspectRatio = isHorizontal ? 1.3 : 0.5;
    return MaterialApp(
      home: Scaffold(
        appBar: const MyNav(),
        bottomNavigationBar: MyBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });

            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => IndexPage(
                          token: widget.token,
                          userInfo: widget.userInfo,
                        )),
              );
            }

            if (index == 4) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MySettings(
                          token: widget.token,
                          userInfo: widget.userInfo,
                        )),
              );
            }

            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyProducts(
                          token: widget.token,
                          userInfo: widget.userInfo,
                        )),
              );
            }
          },
        ),
        backgroundColor: Color.fromARGB(255, 217, 217, 221),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Stack(
              children: [
                // Other widgets in the background
                Container(
                  // color: Colors.blueGrey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Center(
                      child: Column(
                        children: [
                          const Text(
                            'Profile',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: screenWidth,
                            padding: EdgeInsets.fromLTRB(14, 16, 14, 16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), // Shadow color
                                    spreadRadius: 5, // Spread radius
                                    blurRadius: 7, // Blur radius
                                    offset: Offset(
                                        0, 3), // Offset in the x, y direction
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'My Account',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Container(
                                      width: 220,
                                      child: Text(
                                        'profile information, password, profile picture...',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ],
                                ),
                                SvgPicture.asset(
                                  'lib/assets/ARROW LEFT.svg',
                                  width: 32,
                                  height: 32,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: screenWidth,
                            padding: EdgeInsets.fromLTRB(14, 16, 14, 16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), // Shadow color
                                    spreadRadius: 5, // Spread radius
                                    blurRadius: 7, // Blur radius
                                    offset: Offset(
                                        0, 3), // Offset in the x, y direction
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order History',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Container(
                                      width: 220,
                                      child: Text(
                                        'past orders, Order tracking, Precious purchases...',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ],
                                ),
                                SvgPicture.asset(
                                  'lib/assets/ARROW LEFT (1).svg',
                                  width: 32,
                                  height: 32,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: screenWidth,
                            padding: EdgeInsets.fromLTRB(14, 16, 14, 16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), // Shadow color
                                    spreadRadius: 5, // Spread radius
                                    blurRadius: 7, // Blur radius
                                    offset: Offset(
                                        0, 3), // Offset in the x, y direction
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Wallet and Payments',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Container(
                                      width: 220,
                                      child: Text(
                                        'Airtime & bills, Payment methods/receipts...',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ],
                                ),
                                SvgPicture.asset(
                                  'lib/assets/ARROW LEFT (2).svg',
                                  width: 32,
                                  height: 32,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: screenWidth,
                            padding: EdgeInsets.fromLTRB(14, 16, 14, 16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), // Shadow color
                                    spreadRadius: 5, // Spread radius
                                    blurRadius: 7, // Blur radius
                                    offset: Offset(
                                        0, 3), // Offset in the x, y direction
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 260,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Settings',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Container(
                                        width: 220,
                                        child: Text(
                                          'Change location, notification settings, Account preferences...',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SvgPicture.asset(
                                  'lib/assets/ARROW LEFT (3).svg',
                                  width: 32,
                                  height: 32,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: screenWidth,
                            padding: EdgeInsets.fromLTRB(14, 16, 14, 16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), // Shadow color
                                    spreadRadius: 5, // Spread radius
                                    blurRadius: 7, // Blur radius
                                    offset: Offset(
                                        0, 3), // Offset in the x, y direction
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Help and Support',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Container(
                                      width: 220,
                                      child: Text(
                                        'FAQs, customer support...',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ],
                                ),
                                SvgPicture.asset(
                                  'lib/assets/ARROW LEFT (4).svg',
                                  width: 32,
                                  height: 32,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: Logout,
                            child: Container(
                              width: screenWidth,
                              padding: EdgeInsets.fromLTRB(14, 16, 14, 16),
                              decoration: BoxDecoration(
                                  color: Color(0xFF3A3A3A),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // Shadow color
                                      spreadRadius: 5, // Spread radius
                                      blurRadius: 7, // Blur radius
                                      offset: Offset(
                                          0, 3), // Offset in the x, y direction
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Log out',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        'Sign out of Davkart',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                  SvgPicture.asset(
                                    'lib/assets/ARROW LEFT (5).svg',
                                    width: 32,
                                    height: 32,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Fixed Container at the top
                // const MyNav()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
