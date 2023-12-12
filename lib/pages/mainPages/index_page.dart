import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dots_indicator/dots_indicator.dart';

class IndexPage extends StatefulWidget {
  final Object userInfo;
  final String token;

  IndexPage({Key? key, required this.userInfo, required this.token})
      : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class DisplayEntry {
  int uid;
  List<dynamic> display;
  // int current;

  DisplayEntry({
    required this.uid,
    required this.display,
  });
  @override
  String toString() {
    return 'DisplayEntry(uid: $uid, display: $display, )';
  }
}

class DisplayEntry2 {
  int uid;
  List<int> filters;

  DisplayEntry2({required this.uid, required this.filters});
  @override
  String toString() {
    return 'DisplayEntry(uid: $uid, display: $filters)';
  }
}

class DisplayEntry3 {
  int uid;
  int current;

  DisplayEntry3({required this.uid, required this.current});
  @override
  String toString() {
    return 'DisplayEntry(uid: $uid, display: $current)';
  }
}

class _IndexPageState extends State<IndexPage> {
  int _selectedIndex = 0;
  List<String> itemsDot = [];
  final CarouselController _controller = CarouselController();
  List currentIndex = [];
  int currentIndex2 = 0;
  final String url = 'http://10.0.2.2:8000/api';

  @override
  void initState() {
    super.initState();
    // arrangeData();
    getProductsHome();
  }

  List<String> filteredList = [];
  List<int> indexes = [];
  List indexes2 = [];
  List mainDisplay = [];
  List productData = [];
  List filteredList2 = [];

  void getProductsHome() async {
    // final String tokenU = ;
    // print(widget.token);
    try {
      final response = await http.get(
        Uri.parse('$url/getUserInterestProducts'),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        // Successful request, handle the data here
        Map<String, dynamic> data = json.decode(response.body);

        setState(() {
          productData = data['cat'];
        });

        // print('Data: ${productData}');
        // mainArrangement(
        //   0,
        // );
        mainArrangement2();
      } else {
        // Request failed, handle the error
        print('Failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error during navigation: $e');
    }
  }

  // void set2(index, dotI) {
  //   setState(() {
  //     currentIndex.add(index);
  //     currentIndex2 = dotI;
  //   });
  // }

  void mainArrangement2() {
    for (var i = 0; i < productData.length; i++) {
      setState(() {
        filteredList2 = productData[i]['category']
            .asMap()
            .entries
            .where((entry) => (entry.key + 1) % 6 == 0)
            .map((entry) => entry.value)
            .toList();
      });

      bool check = currentIndex.where((entry) => entry.uid == i).isNotEmpty;

      if (check) {
        setState(() {
          currentIndex.firstWhere((entry) => entry.uid == i).current = 0;
        });
      } else {
        setState(() {
          currentIndex.add(DisplayEntry3(
            uid: i,
            current: 0,
          ));
        });
      }

      if (productData[i]['category'].length <= 6) {
        bool check = mainDisplay.where((entry) => entry.uid == i).isNotEmpty;
        if (check) {
          setState(() {
            mainDisplay.firstWhere((entry) => entry.uid == i).display =
                productData[i]['category'];
          });
        } else {
          setState(() {
            mainDisplay.add(DisplayEntry(
              uid: i,
              display: productData[i]['category'],
            ));
          });
        }

        setState(() {
          filteredList2 = ['item'];
        });

        // return {
        //   'dot': ['item'],
        //   // 'display': productData[index].category,
        // };
      } else if (productData[i]['category'].length > 6 &&
          ((filteredList2.length * 6) != productData[i]['category'].length)) {
        // List dotList = filteredList2;
        setState(() {
          filteredList2.add('item');
        });
        List<dynamic> slicedList = productData[i]['category'].sublist(0, 6);
        bool check = mainDisplay.where((entry) => entry.uid == i).isNotEmpty;

        if (check) {
          setState(() {
            mainDisplay.firstWhere((entry) => entry.uid == i).display =
                slicedList;
          });
        } else {
          setState(() {
            mainDisplay.add(DisplayEntry(
              uid: i,
              display: slicedList,
            ));
          });
        }

        for (var j = 0; j < filteredList2.length; j++) {
          bool check2 = indexes2.where((entry) => entry.uid == i).isNotEmpty;

          if (check2 &&
              !(indexes2.firstWhere((entry) => entry.uid == i).filters.contains(
                  productData[i]['category'].indexOf(filteredList2[j])))) {
            setState(() {
              indexes2
                  .firstWhere((entry) => entry.uid == i)
                  .filters
                  .add(productData[i]['category'].indexOf(filteredList2[j]));
            });
          } else if (!check2) {
            setState(() {
              indexes2.add(DisplayEntry2(uid: i, filters: [
                productData[i]['category'].indexOf(filteredList2[j])
              ]));
            });
          }
        }

        // return {
        //   'dot': filteredList2,
        //   // 'display': slicedList,
        // };
      } else if (productData[i]['category'].length > 6 &&
          ((filteredList2.length * 6) == productData[i]['category'].length)) {
        List<dynamic> slicedList = productData[i]['category'].sublist(0, 6);
        bool check = mainDisplay.where((entry) => entry.uid == i).isNotEmpty;

        if (check) {
          // Entry with the specified index already exists, update it
          setState(() {
            mainDisplay.firstWhere((entry) => entry.uid == i).display =
                slicedList;
          });
        } else {
          // Entry with the specified index doesn't exist, add a new one
          setState(() {
            mainDisplay.add(DisplayEntry(
              uid: i,
              display: slicedList,
            ));
          });
        }

        for (var j = 0; j < filteredList2.length; j++) {
          bool check2 = indexes2.where((entry) => entry.uid == i).isNotEmpty;

          if (check2 &&
              !(indexes2.firstWhere((entry) => entry.uid == i).filters.contains(
                  productData[i]['category'].indexOf(filteredList2[j])))) {
            setState(() {
              indexes2
                  .firstWhere((entry) => entry.uid == i)
                  .filters
                  .add(productData[i]['category'].indexOf(filteredList2[j]));
            });
          } else if (!check2) {
            setState(() {
              indexes2.add(DisplayEntry2(uid: i, filters: [
                productData[i]['category'].indexOf(filteredList2[j])
              ]));
            });
          }
        }

        // return {
        //   'dot': filteredList2,
        //   // 'display': slicedList,
        // };
      }
    }
  }

  Map<String, dynamic> mainArrangement(int index) {
    List filteredList2 = productData[index]['category']
        .asMap()
        .entries
        .where((entry) => (entry.key + 1) % 6 == 0)
        .map((entry) => entry.value)
        .toList();

    if (productData[index]['category'].length <= 6) {
      bool check = mainDisplay.where((entry) => entry.uid == index).isNotEmpty;
      if (check) {
        // Entry with the specified index already exists, update it
        mainDisplay.firstWhere((entry) => entry.uid == index).display =
            productData[index]['category'];
      } else {
        // Entry with the specified index doesn't exist, add a new one
        mainDisplay.add(DisplayEntry(
          uid: index,
          display: productData[index]['category'],
        ));
      }

      return {
        'dot': ['item'],
        // 'display': productData[index].category,
      };
    } else if (productData[index]['category'].length > 6 &&
        ((filteredList2.length * 6) != productData[index]['category'].length)) {
      // List dotList = filteredList2;
      filteredList2.add('item');
      List<dynamic> slicedList = productData[index]['category'].sublist(0, 6);
      bool check = mainDisplay.where((entry) => entry.uid == index).isNotEmpty;

      if (check) {
        // Entry with the specified index already exists, update it
        mainDisplay.firstWhere((entry) => entry.uid == index).display =
            slicedList;
      } else {
        // Entry with the specified index doesn't exist, add a new one
        mainDisplay.add(DisplayEntry(
          uid: index,
          display: slicedList,
        ));
      }

      for (var i = 0; i < filteredList2.length; i++) {
        bool check2 = indexes2.where((entry) => entry.uid == index).isNotEmpty;

        if (check2 &&
            !(indexes2
                .firstWhere((entry) => entry.uid == index)
                .filters
                .contains(productData[index]['category']
                    .indexOf(filteredList2[i])))) {
          indexes2
              .firstWhere((entry) => entry.uid == index)
              .filters
              .add(productData[index]['category'].indexOf(filteredList2[i]));
        } else if (!check2) {
          indexes2.add(DisplayEntry2(uid: index, filters: [
            productData[index]['category'].indexOf(filteredList2[i])
          ]));
        }
        print('boy: ${indexes2}');
      }
      return {
        'dot': filteredList2,
        // 'display': slicedList,
      };
    } else if (productData[index]['category'].length > 6 &&
        ((filteredList2.length * 6) == productData[index]['category'].length)) {
      List<dynamic> slicedList = productData[index]['category'].sublist(0, 6);
      bool check = mainDisplay.where((entry) => entry.uid == index).isNotEmpty;

      if (check) {
        // Entry with the specified index already exists, update it
        mainDisplay.firstWhere((entry) => entry.uid == index).display =
            slicedList;
      } else {
        // Entry with the specified index doesn't exist, add a new one
        mainDisplay.add(DisplayEntry(
          uid: index,
          display: slicedList,
        ));
      }

      for (var i = 0; i < filteredList2.length; i++) {
        bool check2 = indexes2.where((entry) => entry.uid == index).isNotEmpty;

        if (check2 &&
            !(indexes2
                .firstWhere((entry) => entry.uid == index)
                .filters
                .contains(productData[index]['category']
                    .indexOf(filteredList2[i])))) {
          indexes2
              .firstWhere((entry) => entry.uid == index)
              .filters
              .add(productData[index]['category'].indexOf(filteredList2[i]));
        } else if (!check2) {
          indexes2.add(DisplayEntry2(uid: index, filters: [
            productData[index]['category'].indexOf(filteredList2[i])
          ]));
        }
      }

      return {
        'dot': filteredList2,
        // 'display': slicedList,
      };
    } else {
      return {
        'dot': [],
        'display': [],
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isHorizontal = screenWidth > screenHeight;

    double childAspectRatio = isHorizontal ? 1.3 : 0.5;
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Color(0xFF3A3A3A99),
            selectedItemColor: Color(0xFF3A3A3A99),
            showUnselectedLabels: true,

            // iconSize: 24.0,
            unselectedLabelStyle: TextStyle(
              color: Color(0xFF3A3A3A99),
              fontWeight: FontWeight.w500,
              height: 0.4,
            ),
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              height: 0.4,
              // fontSize: 8,
              color: Color(0xFF3A3A3A99),
            ),
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            currentIndex: _selectedIndex,
            items: [
              BottomNavigationBarItem(
                icon: Transform.translate(
                  offset: Offset(0.0, _selectedIndex == 0 ? -12.0 : -8.0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                          _selectedIndex == 0 ? const Color(0xFF010CA6) : null,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SvgPicture.asset(
                      'lib/assets/Home Icon.svg',
                      color: _selectedIndex == 0 ? Colors.white : null,
                      // width: 18,
                      // height: 18,
                    ),
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Transform.translate(
                    offset: Offset(0.0, _selectedIndex == 1 ? -12.0 : -8.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: _selectedIndex == 1 ? Color(0xFF010CA6) : null,
                          borderRadius: BorderRadius.circular(20)),
                      child: SvgPicture.asset(
                        'lib/assets/Group 18.svg',
                        color: _selectedIndex == 1 ? Colors.white : null,
                        // width: 18,
                        // height: 18,
                      ),
                    ),
                  ),
                  label: 'Products'),
              BottomNavigationBarItem(
                  icon: Transform.translate(
                    offset: Offset(0.0, _selectedIndex == 2 ? -12.0 : -8.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: _selectedIndex == 2 ? Color(0xFF010CA6) : null,
                          borderRadius: BorderRadius.circular(20)),
                      child: SvgPicture.asset(
                        'lib/assets/Group 19.svg',
                        color: _selectedIndex == 2 ? Colors.white : null,
                        // width: 18,
                        // height: 18,
                      ),
                    ),
                  ),
                  label: 'Orders'),
              BottomNavigationBarItem(
                  icon: Transform.translate(
                    offset: Offset(0.0, _selectedIndex == 3 ? -12.0 : -8.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: _selectedIndex == 3 ? Color(0xFF010CA6) : null,
                          borderRadius: BorderRadius.circular(20)),
                      child: SvgPicture.asset(
                        'lib/assets/Group 16.svg',
                        color: _selectedIndex == 3 ? Colors.white : null,
                        // width: 18,
                        // height: 18,
                      ),
                    ),
                  ),
                  label: 'Messaging'),
              BottomNavigationBarItem(
                  icon: Transform.translate(
                    offset: Offset(0.0, _selectedIndex == 4 ? -12.0 : -8.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: _selectedIndex == 4 ? Color(0xFF010CA6) : null,
                          borderRadius: BorderRadius.circular(20)),
                      child: SvgPicture.asset(
                        'lib/assets/Group.svg',
                        color: _selectedIndex == 4 ? Colors.white : null,
                        // width: 18,
                        // height: 18,
                      ),
                    ),
                  ),
                  label: 'Profile'),
            ]),
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
                    margin: const EdgeInsets.symmetric(vertical: 90),
                    child: Center(
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              'Current lisitings',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          productData.isEmpty
                              ? Container(
                                  child: const Column(
                                  children: [
                                    SizedBox(
                                      height: 25,
                                    ),
                                    CircularProgressIndicator(),
                                  ],
                                ))
                              : SingleChildScrollView(
                                  child: Container(
                                    height: screenHeight *
                                        ((productData.length) /
                                            1.5), // Adjust the height as needed
                                    child: ListView.builder(
                                      itemCount: productData.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 0),
                                                child: Container(
                                                  width: screenWidth,
                                                  height: 500,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0), // Adjust the border radius as needed
                                                    gradient:
                                                        const LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                      colors: [
                                                        Color(0xFF010CA6),
                                                        Color(0xFFFFDB00),
                                                      ],
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Center(
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                            color:
                                                                Colors.white),
                                                        width: screenWidth,
                                                        child: Column(
                                                          children: [
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text(
                                                              '${(() {
                                                                var foundEntry =
                                                                    mainDisplay
                                                                        .firstWhere(
                                                                  (entry) =>
                                                                      entry
                                                                          .uid ==
                                                                      index,
                                                                  orElse: () =>
                                                                      null, // Return null if no matching entry is found
                                                                );

                                                                if (foundEntry !=
                                                                        null &&
                                                                    foundEntry
                                                                        .display
                                                                        .isNotEmpty) {
                                                                  return foundEntry
                                                                          .display
                                                                          .first[
                                                                      'category'];
                                                                } else {
                                                                  return 'Product';
                                                                }
                                                              })()}',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Container(
                                                              height: 405,
                                                              child:
                                                                  CarouselSlider(
                                                                options:
                                                                    CarouselOptions(
                                                                  height: 405.0,
                                                                  enlargeCenterPage:
                                                                      true,
                                                                  autoPlay:
                                                                      productData[index]['category'].length <=
                                                                              6
                                                                          ? false
                                                                          : true,
                                                                  aspectRatio:
                                                                      16 / 9,
                                                                  autoPlayCurve:
                                                                      Curves
                                                                          .fastOutSlowIn,
                                                                  enableInfiniteScroll:
                                                                      productData[index]['category'].length <=
                                                                              6
                                                                          ? false
                                                                          : true,
                                                                  autoPlayAnimationDuration:
                                                                      Duration(
                                                                          milliseconds:
                                                                              800),
                                                                  viewportFraction:
                                                                      1,
                                                                  autoPlayInterval:
                                                                      Duration(
                                                                          seconds:
                                                                              10),
                                                                  pauseAutoPlayOnTouch:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  onPageChanged:
                                                                      (indexD,
                                                                          reason) {
                                                                    setState(
                                                                        () {
                                                                      bool check = currentIndex
                                                                          .where((entry) =>
                                                                              entry.uid ==
                                                                              index)
                                                                          .isNotEmpty;

                                                                      if (check) {
                                                                        setState(
                                                                            () {
                                                                          currentIndex
                                                                              .firstWhere((entry) => entry.uid == index)
                                                                              .current = indexD;
                                                                        });
                                                                      } else {
                                                                        setState(
                                                                            () {
                                                                          currentIndex
                                                                              .add(DisplayEntry3(
                                                                            uid:
                                                                                index,
                                                                            current:
                                                                                indexD,
                                                                          ));
                                                                        });
                                                                      }
                                                                      // print(
                                                                      //     'john ${indexD}');

                                                                      if (indexes2.firstWhere((entry) => entry.uid == index).filters[
                                                                              indexD] ==
                                                                          -1) {
                                                                        List filteredList2 = productData[index]['category']
                                                                            .asMap()
                                                                            .entries
                                                                            .where((entry) =>
                                                                                (entry.key + 1) % 6 ==
                                                                                0)
                                                                            .map((entry) =>
                                                                                entry.value)
                                                                            .toList();

                                                                        List<dynamic>
                                                                            slicedList =
                                                                            productData[index]['category'].sublist(filteredList2.length * 6,
                                                                                productData[index]['category'].length);

                                                                        mainDisplay
                                                                            .firstWhere((entry) =>
                                                                                entry.uid ==
                                                                                index)
                                                                            .display = slicedList;
                                                                      } else if (indexD ==
                                                                              0 &&
                                                                          indexes2.firstWhere((entry) => entry.uid == index).filters[indexD] !=
                                                                              -1) {
                                                                        List<dynamic>
                                                                            slicedList =
                                                                            productData[index]['category'].sublist(0,
                                                                                indexes2.firstWhere((entry) => entry.uid == index).filters[0] + 1);

                                                                        mainDisplay
                                                                            .firstWhere((entry) =>
                                                                                entry.uid ==
                                                                                index)
                                                                            .display = slicedList;

                                                                        // print(
                                                                        //     slicedList);
                                                                      } else {
                                                                        List<dynamic>
                                                                            slicedList =
                                                                            productData[index]['category'].sublist(indexes2.firstWhere((entry) => entry.uid == index).filters[indexD - 1] + 1,
                                                                                indexes2.firstWhere((entry) => entry.uid == index).filters[indexD] + 1);

                                                                        mainDisplay
                                                                            .firstWhere((entry) =>
                                                                                entry.uid ==
                                                                                index)
                                                                            .display = slicedList;
                                                                      }
                                                                    });

                                                                    // You can use the onPageChanged callback to update the current page index
                                                                  },

                                                                  //  dotColor: Colors.blue,
                                                                ),
                                                                items: filteredList2
                                                                    .map<Widget>(
                                                                        (item) {
                                                                  return Builder(
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        margin: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                6.0),
                                                                        decoration: BoxDecoration(
                                                                            // color: Colors.amber,
                                                                            ),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              screenWidth,
                                                                          // height: 405,

                                                                          child:
                                                                              GridView.builder(
                                                                            shrinkWrap:
                                                                                true,
                                                                            gridDelegate:
                                                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                                              crossAxisCount: 3,
                                                                              crossAxisSpacing: 20.0, // Horizontal spacing between itemsDot
                                                                              mainAxisSpacing: 20.0,
                                                                              childAspectRatio: childAspectRatio,
                                                                              // // Set the number of columns in the grid
                                                                            ),
                                                                            itemCount:
                                                                                mainDisplay.firstWhere((entry) => entry.uid == index).display.length,
                                                                            itemBuilder:
                                                                                (context, indexM) {
                                                                              return Container(
                                                                                  child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Container(
                                                                                      height: 91,
                                                                                      // width: 200,
                                                                                      decoration: BoxDecoration(color: Color(0xFFD9D9D9), borderRadius: BorderRadius.circular(10), border: Border.all(width: 1.5, color: Color(0xFF010CA6))),
                                                                                      child: Column(
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Container(
                                                                                              child: Image.asset(
                                                                                                'lib/assets/test.png',
                                                                                                // height: 28,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        '${mainDisplay.firstWhere((entry) => entry.uid == index).display[indexM]['product'][0]['product_name']}',
                                                                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  const Row(
                                                                                    children: [
                                                                                      const Text(
                                                                                        'Sleeveless Shirt ',
                                                                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 6,
                                                                                  ),
                                                                                  Row(
                                                                                    children: [
                                                                                      Container(
                                                                                        color: Color(0xFFFED800),
                                                                                        child: Center(
                                                                                          child: Text(
                                                                                            '₦2,500',
                                                                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              ));
                                                                            },
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                }).toList(),
                                                                carouselController:
                                                                    _controller,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 12,
                                                            ),
                                                            productData[index][
                                                                            'category']
                                                                        .length <=
                                                                    6
                                                                ? Text('')
                                                                : Center(
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          20,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            SingleChildScrollView(
                                                                          scrollDirection:
                                                                              Axis.horizontal,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children:
                                                                                List<Widget>.generate(
                                                                              filteredList2.length,
                                                                              (dotIndex) {
                                                                                bool isCurrent = currentIndex.firstWhere((entry) => entry.uid == index).current == dotIndex;

                                                                                return Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                                                  child: GestureDetector(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        currentIndex.firstWhere((entry) => entry.uid == index).current = dotIndex;
                                                                                      });
                                                                                        _controller.animateToPage(currentIndex.firstWhere((entry) => entry.uid == index).current);
                                                                                    },
                                                                                    child: Container(
                                                                                      width: isCurrent ? 15 : 10,
                                                                                      height: 10,
                                                                                      decoration: BoxDecoration(
                                                                                        // shape: BoxShape.circle,
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                        color: isCurrent ? Colors.blue : Colors.grey,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      // ... your builder code
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Fixed Container at the top
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 40.0,
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'lib/assets/davkart Logo short 1.png',
                          height: 28,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            child: TextField(
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                              fillColor: Color(0xFFFFFFFF),
                              filled: true,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10.0),
                              prefixIcon: Icon(Icons.search),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20)),
                              hintText:
                                  'Search Orders, Products, or Customers...'),
                        )),
                        SizedBox(
                          width: 12,
                        ),
                        Image.asset(
                          'lib/assets/Notification.png',
                          height: 28,
                          // height: 300,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
