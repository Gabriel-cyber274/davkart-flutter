import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../mainPages/index_page.dart';
import 'dart:math';

class ProductInterest extends StatefulWidget {
  final String email;

  ProductInterest({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<ProductInterest> createState() => _ProductInterestState();
}

class _ProductInterestState extends State<ProductInterest> {
  bool isChecked = false;
  final String url = 'http://10.0.2.2:8000/api';

  final items = [
    {'name': 'Electronics', 'checked': false},
    {'name': 'Clothing and Fashion', 'checked': false},
    {'name': 'Home and Furniture', 'checked': false},
    {'name': 'Beauty and Personal Care', 'checked': false},
    {'name': 'Sports and Outdoors', 'checked': false},
    {'name': 'Books and Stationery', 'checked': false},
    {'name': 'Toys and Games', 'checked': false},
    {'name': 'Jewelry and Watches', 'checked': false},
    {'name': 'Pet Supplies', 'checked': false},
    {'name': 'Baby and Kids', 'checked': false},
    {'name': 'Appliances', 'checked': false},
    {'name': 'Jewelry and Watches', 'checked': false},
    {'name': 'Grocery and Gourmet', 'checked': false},
  ];

  void setInterest(proceed) async {
    if (proceed) {
      List<Map<String, Object>> selectedItem =
          items.where((element) => element['checked'] == true).toList();
      for (var i = 0; i < selectedItem.length; i++) {
        try {
          final response = await http.post(
            Uri.parse('$url/userInterest'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(<String, dynamic>{
              'email': widget.email,
              'category': selectedItem[i]['name'].toString(),
              // Add more key-value pairs as needed
            }),
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            Map<String, dynamic> data = jsonDecode(response.body);

            final user = data['user'];
            // final interest = data['interest'];
            final token = data['token'];

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => IndexPage(
                        userInfo: user,
                        token: token,
                      )),
            );
          } else {
            print('Request failed with status: ${response.statusCode}');
          }
        } catch (e) {
          print('Error during navigation: $e');
        }
      }
    } else {
      Random random = Random();
      int randomNumber = random.nextInt(13);

      try {
        final response = await http.post(
          Uri.parse('$url/userInterest'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, dynamic>{
            'email': widget.email,
            'category': items[randomNumber]['name'].toString(),
            // Add more key-value pairs as needed
          }),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> data = jsonDecode(response.body);

          final user = data['user'];
          final token = data['token'];

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndexPage(
                      userInfo: user,
                      token: token,
                    )),
          );
        } else {
          print('Request failed with status: ${response.statusCode}');
        }
      } catch (e) {
        print('Error during navigation: $e');
      }
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
                'Select Product Interests 📦',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  "Pick your interests for personalized recommendations and exclusive offers. We're committed to data security and transparency.",
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
                              height: 10,
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Select All',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Checkbox(
                                    side: const BorderSide(
                                        color: Color(0xFF010CA6), width: 1.2),
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                        for (var i = 0; i < items.length; i++) {
                                          items[i]['checked'] = value ?? false;
                                        }
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 320,
                              padding: EdgeInsets.all(10),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(items[index]['name'].toString()),
                                        Checkbox(
                                          side: const BorderSide(
                                              color: Color(0xFF010CA6),
                                              width: 1.2),
                                          value:
                                              items[index]['checked'] as bool?,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              items[index]['checked'] =
                                                  value ?? false;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setInterest(true);
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Proceed to Davkart',
                                            style: TextStyle(
                                                fontSize: 13.65,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.arrow_right_alt,
                                            weight: 20,
                                            color: Color(0xFFFED800),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setInterest(false);
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
