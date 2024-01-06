import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product_interest.dart';

class LocationSet extends StatefulWidget {
  final String email;

  LocationSet({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<LocationSet> createState() => _LocationSetState();
}

class _LocationSetState extends State<LocationSet> {
  String selectedValue = 'State';
  String selectedValueP = 'City / LGA';
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> dataLga = [];
  bool lgaLoad = false;
  final String url = 'http://10.0.2.2:8000/api';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://nigeria-states-towns-lga.onrender.com/api/states'));

      if (response.statusCode == 200) {
        // If the request was successful, parse the response data
        final responseData = json.decode(response.body);
        // // Assuming the response contains a list of items, adjust accordingly
        // final items = responseData['data'];
        print(json.decode(response.body));
        setState(() {
          // Update the state with the parsed data
          data = List<Map<String, dynamic>>.from(responseData);
        });
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void getLga(state) async {
    final fullState = state.split(' ');

    if (fullState.length == 1 || fullState[1] != 'State') {
      try {
        setState(() {
          // Update the state with the parsed data
          lgaLoad = true;
        });
        final response = await http.get(Uri.parse(
            'https://nigeria-states-towns-lga.onrender.com/api/${fullState.join().toUpperCase()}/lgas'));

        setState(() {
          // Update the state with the parsed data
          lgaLoad = false;
        });
        if (response.statusCode == 200) {
          // If the request was successful, parse the response data
          final responseData = json.decode(response.body);
          // // Assuming the response contains a list of items, adjust accordingly
          // final items = responseData['data'];
          print(json.decode(response.body));
          setState(() {
            // Update the state with the parsed data
            dataLga = List<Map<String, dynamic>>.from(responseData);
          });
        } else {
          print('Failed to fetch data. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    } else {
      try {
        setState(() {
          // Update the state with the parsed data
          lgaLoad = true;
        });
        final response = await http.get(Uri.parse(
            'https://nigeria-states-towns-lga.onrender.com/api/${fullState[0].toUpperCase()}/lgas'));

        setState(() {
          // Update the state with the parsed data
          lgaLoad = false;
        });
        if (response.statusCode == 200) {
          // If the request was successful, parse the response data
          final responseData = json.decode(response.body);
          // // Assuming the response contains a list of items, adjust accordingly
          // final items = responseData['data'];
          print(json.decode(response.body));
          setState(() {
            // Update the state with the parsed data
            dataLga = List<Map<String, dynamic>>.from(responseData);
          });
        } else {
          print('Failed to fetch data. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }

    // print(fullState[0].toUpperCase());
  }

  void updateState(pro) async {
    if (pro) {
      final response = await http.put(
        Uri.parse('$url/updateState'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'email': widget.email,
          'state': selectedValue,
          'lga': selectedValueP
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
                builder: (context) => ProductInterest(
                      email: user['email'],
                    )),
          );
        } catch (e) {
          print('Error during navigation: $e');
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductInterest(
                  email: widget.email,
                )),
      );
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
                'Set your Location 🏠',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  "Let's tailor your experience to your preferred location.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF3A3A3A),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'lib/assets/Group 14.png',
                      // height: 300,
                    ),
                  ],
                ),
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
                            Container(
                              padding: const EdgeInsets.all(1.5),
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    2.0), // Adjust the border radius as needed
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF010CA6),
                                    Color(0xFFFFDB00),
                                  ],
                                ),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle button press
                                  print('Button pressed');
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Replace with your desired icon
                                    // Adjust the spacing between icon and text
                                    Text(
                                      'Enable Auto-location',
                                      style:
                                          TextStyle(color: Color(0xFF3A3A3A)),
                                    ),
                                    SizedBox(width: 8.0),
                                    Icon(
                                      Icons.location_on,
                                      color: Color(0xFF010CA6),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Text(
                                'Type or Select',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xFF3A3A3A),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Column(
                                children: [
                                  data.isEmpty
                                      ? CircularProgressIndicator()
                                      : Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: DropdownButton<String>(
                                            value: selectedValue,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedValue = newValue!;
                                              });
                                              getLga(newValue);
                                            },
                                            isExpanded: true,
                                            underline: Container(),
                                            items: [
                                              DropdownMenuItem<String>(
                                                value: 'State',
                                                child: Text('State'),
                                              ),
                                              for (var item in data)
                                                DropdownMenuItem<String>(
                                                  value: item['name'],
                                                  child: Text(item['name']),
                                                ),
                                            ],
                                          ),
                                        ),
                                 
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  lgaLoad
                                      ? CircularProgressIndicator()
                                      : Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: DropdownButton<String>(
                                            value: selectedValueP,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedValueP = newValue!;
                                              });
                                            },
                                            isExpanded: true,
                                            underline: Container(),
                                            items: [
                                              DropdownMenuItem<String>(
                                                value: 'City / LGA',
                                                child: Text('City / LGA'),
                                              ),
                                              for (var item in dataLga)
                                                DropdownMenuItem<String>(
                                                  value: item['name'],
                                                  child: Text(item['name']),
                                                ),
                                              // DropdownMenuItem<String>(
                                              //   value: 'Option 18',
                                              //   child: Text('Option 18'),
                                              // ),
                                            ],
                                          ),
                                        ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text(
                                    'Your location helps us show nearby stores and products. We prioritize your privacy and ensure data security',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    updateState(true);
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
                                        'Done',
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
                                    updateState(false);
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
