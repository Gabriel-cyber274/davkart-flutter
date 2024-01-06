import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../components/bottom_navigation_bar.dart';
import 'profile_page.dart';
import '../../components/nav.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../../screens/new_product.dart';
import './index_page.dart';

class MyProducts extends StatefulWidget {
  final userInfo;
  final String token;

  const MyProducts({Key? key, required this.userInfo, required this.token})
      : super(key: key);

  @override
  State<MyProducts> createState() => _MyProductsState();
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

class DisplayEntry4 {
  int uid;
  List<dynamic> filt;

  DisplayEntry4({required this.uid, required this.filt});
  @override
  String toString() {
    return 'DisplayEntry(uid: $uid, display: $filt)';
  }
}

class _MyProductsState extends State<MyProducts> {
  int _currentIndex = 1;
  List<String> itemsDot = [];
  List currentIndex = [];
  bool loading = false;
  final String url = 'http://10.0.2.2:8000/api';
  // final String url = 'https://a747-105-113-81-41.ngrok-free.app/api';
  // final String imgUrl = 'https://a747-105-113-81-41.ngrok-free.app/api/imgs';
  final String imgUrl = 'http://10.0.2.2:8000/api/imgs';
  @override
  void initState() {
    super.initState();
    // arrangeData();
    setState(() {
      _currentIndex = 1;
    });
    getProductsHome();
  }

  List indexes2 = [];
  List mainDisplay = [];
  List productData = [];

  List filteredList2 = [];

  void getProductsHome() async {
    // final String tokenU = ;
    // print(widget.token);

    try {
      setState(() {
        loading = true;
      });
      final response = await http.get(
        Uri.parse('$url/getAllUserProduct'),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
          'Content-Type': 'application/json',
        },
      );

      setState(() {
        loading = false;
      });
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
        mainArrangement();
      } else {
        print('Failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error during navigation: $e');
      setState(() {
        loading = false;
      });
    }
  }

  void mainArrangement() {
    for (var i = 0; i < productData.length; i++) {
      setState(() {
        bool check2 = filteredList2.where((entry) => entry.uid == i).isNotEmpty;

        if (check2) {
          setState(() {
            filteredList2.firstWhere((entry) => entry.uid == i).filt =
                productData[i]['category']
                    .asMap()
                    .entries
                    .where((entry) => (entry.key + 1) % 6 == 0)
                    .map((entry) => entry.value)
                    .toList();
          });
        } else {
          setState(() {
            filteredList2.add(DisplayEntry4(
              uid: i,
              filt: productData[i]['category']
                  .asMap()
                  .entries
                  .where((entry) => (entry.key + 1) % 6 == 0)
                  .map((entry) => entry.value)
                  .toList(),
            ));
          });
        }

        // filteredList2 = productData[i]['category']
        //     .asMap()
        //     .entries
        //     .where((entry) => (entry.key + 1) % 6 == 0)
        //     .map((entry) => entry.value)
        //     .toList();
      });

      print(productData[i]['category'].length);
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

        bool check2 = filteredList2.where((entry) => entry.uid == i).isNotEmpty;

        if (check2) {
          setState(() {
            filteredList2.firstWhere((entry) => entry.uid == i).filt = ['item'];
          });
        } else {
          setState(() {
            filteredList2.add(DisplayEntry4(
              uid: i,
              filt: ['item'],
            ));
          });
        }

        print('2');

        // return {
        //   'dot': ['item'],
        //   // 'display': productData[index].category,
        // };
      } else if (productData[i]['category'].length > 6 &&
          ((filteredList2.length * 6) != productData[i]['category'].length)) {
        // List dotList = filteredList2;

        bool check2P =
            filteredList2.where((entry) => entry.uid == i).isNotEmpty;

        if (check2P) {
          setState(() {
            filteredList2
                .firstWhere((entry) => entry.uid == i)
                .filt
                .add('item');
          });
        } else {
          setState(() {
            filteredList2.add(DisplayEntry4(
              uid: i,
              filt: ['item', 'item2'],
            ));
          });
        }

        // setState(() {
        //   filteredList2.add('item');
        // });

        print('1');
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

        for (var j = 0;
            j < filteredList2.firstWhere((entry) => entry.uid == i).filt.length;
            j++) {
          bool check2 = indexes2.where((entry) => entry.uid == i).isNotEmpty;

          if (check2 &&
              !(indexes2.firstWhere((entry) => entry.uid == i).filters.contains(
                  productData[i]['category'].indexOf(filteredList2
                      .firstWhere((entry) => entry.uid == i)
                      .filt[j])))) {
            setState(() {
              indexes2.firstWhere((entry) => entry.uid == i).filters.add(
                  productData[i]['category'].indexOf(filteredList2
                      .firstWhere((entry) => entry.uid == i)
                      .filt[j]));
            });
          } else if (!check2) {
            setState(() {
              indexes2.add(DisplayEntry2(uid: i, filters: [
                productData[i]['category'].indexOf(
                    filteredList2.firstWhere((entry) => entry.uid == i).filt[j])
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

        print('3');

        for (var j = 0;
            j < filteredList2.firstWhere((entry) => entry.uid == i).filt.length;
            j++) {
          bool check2 = indexes2.where((entry) => entry.uid == i).isNotEmpty;

          if (check2 &&
              !(indexes2.firstWhere((entry) => entry.uid == i).filters.contains(
                  productData[i]['category'].indexOf(filteredList2
                      .firstWhere((entry) => entry.uid == i)
                      .filt[j])))) {
            setState(() {
              indexes2.firstWhere((entry) => entry.uid == i).filters.add(
                  productData[i]['category'].indexOf(filteredList2
                      .firstWhere((entry) => entry.uid == i)
                      .filt[j]));
            });
          } else if (!check2) {
            setState(() {
              indexes2.add(DisplayEntry2(uid: i, filters: [
                productData[i]['category'].indexOf(
                    filteredList2.firstWhere((entry) => entry.uid == i).filt[j])
              ]));
            });
          }
        }

        // return {
        //   'dot': filteredList2,
        //   // 'display': slicedList,
        // };
      }

      print('list2 ${filteredList2}');
    }
  }

  Future<List<Image>> loadImages(imageUrls) async {
    // Load images asynchronously
    List<Image> images = [];
    for (String url in imageUrls) {
      final image = await loadImage(url);
      images.add(image);
    }
    return images;
  }

  Future<Image> loadImage(String url) async {
    // Simulate image loading delay
    await Future.delayed(Duration(seconds: 2));
    return Image.network(url, width: 70, height: 63);
  }

  Future<void> _refreshData() async {
    // Add your refresh logic here
    // For example, you can fetch new data from the server

    // Simulate a delay (replace this with your actual data fetching logic)
    await Future.delayed(Duration(seconds: 2));
    getProductsHome();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isHorizontal = screenWidth > screenHeight;
    final List<List<CarouselController>> _controller = [];

    print('list ${filteredList2.length}');

    for (var i = 0; i < productData.length; i++) {
      final List<CarouselController> _controllers = List.generate(
        productData[i]['category'].length,
        (index) => CarouselController(),
      );
      _controller.add(_controllers);
    }

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
            // print('index: $index');

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
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Container(
                // color: Colors.blueGrey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyProductCreate(
                                        token: widget.token,
                                        userInfo: widget.userInfo,
                                      )),
                            );
                          },
                          child: Container(
                            width: screenWidth,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: Color(0xFF010CA6),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Add new product(s)',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    '+',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: productData.isNotEmpty
                              ? Text(
                                  'Product listings',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              : SizedBox(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        loading
                            ? Container(
                                child: const Column(
                                children: [
                                  SizedBox(
                                    height: 25,
                                  ),
                                  CircularProgressIndicator(),
                                ],
                              ))
                            : productData.isEmpty
                                ? Container(
                                    height: screenHeight,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Image.asset(
                                            'lib/assets/Character2.png',
                                            // height: 28,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'Begin your sales journey by adding products.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF3A3A3A)),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : SingleChildScrollView(
                                    child: Container(
                                      height: screenHeight *
                                          ((productData.length) /
                                              1.2), // Adjust the height as needed
                                      child: ListView.builder(
                                        itemCount: productData.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 0),
                                                  child: Container(
                                                    width: screenWidth,
                                                    height: 550,
                                                    decoration: BoxDecoration(
                                                      borderRadius: productData
                                                                  .length ==
                                                              1
                                                          ? BorderRadiusDirectional
                                                              .only(
                                                              bottomStart:
                                                                  Radius
                                                                      .circular(
                                                                          20.0),
                                                              topStart: Radius
                                                                  .circular(
                                                                      20.0),
                                                              bottomEnd: Radius
                                                                  .circular(
                                                                      20.0),
                                                              topEnd: Radius
                                                                  .circular(
                                                                      20.0),
                                                            )
                                                          : index ==
                                                                  productData
                                                                          .length -
                                                                      1
                                                              ? BorderRadiusDirectional
                                                                  .only(
                                                                  bottomStart: Radius
                                                                      .circular(
                                                                          20.0),
                                                                  bottomEnd: Radius
                                                                      .circular(
                                                                          20.0),
                                                                )
                                                              : index == 0
                                                                  ? BorderRadiusDirectional
                                                                      .only(
                                                                      topStart:
                                                                          Radius.circular(
                                                                              20.0),
                                                                      topEnd: Radius
                                                                          .circular(
                                                                              20.0),
                                                                    )
                                                                  : BorderRadiusDirectional
                                                                      .all(Radius
                                                                          .circular(
                                                                              0)), // Adjust the border radius as needed
                                                      gradient:
                                                          const LinearGradient(
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                        colors: [
                                                          Color(0xFF010CA6),
                                                          Color(0xFFFFDB00),
                                                        ],
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: productData
                                                                  .length ==
                                                              1
                                                          ? const EdgeInsets
                                                              .all(2)
                                                          : index == 0
                                                              ? const EdgeInsets
                                                                  .fromLTRB(
                                                                  2, 2, 2, 0)
                                                              : index ==
                                                                      productData
                                                                              .length -
                                                                          1
                                                                  ? const EdgeInsets
                                                                      .fromLTRB(
                                                                      2,
                                                                      0,
                                                                      2,
                                                                      2)
                                                                  : const EdgeInsets
                                                                      .fromLTRB(
                                                                      2,
                                                                      0,
                                                                      2,
                                                                      0),
                                                      child: Center(
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          decoration: BoxDecoration(
                                                              borderRadius: productData.length == 1
                                                                  ? BorderRadiusDirectional.only(
                                                                      bottomStart:
                                                                          Radius.circular(
                                                                              20.0),
                                                                      topStart:
                                                                          Radius.circular(
                                                                              20.0),
                                                                      bottomEnd:
                                                                          Radius.circular(
                                                                              20.0),
                                                                      topEnd: Radius
                                                                          .circular(
                                                                              20.0),
                                                                    )
                                                                  : index == productData.length - 1
                                                                      ? BorderRadiusDirectional.only(
                                                                          bottomStart:
                                                                              Radius.circular(20.0),
                                                                          bottomEnd:
                                                                              Radius.circular(20.0),
                                                                        )
                                                                      : index == 0
                                                                          ? BorderRadiusDirectional.only(
                                                                              topStart: Radius.circular(20.0),
                                                                              topEnd: Radius.circular(20.0),
                                                                            )
                                                                          : BorderRadiusDirectional.all(Radius.circular(0)),
                                                              color: Colors.white),
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
                                                                        .first['category'];
                                                                  } else {
                                                                    return 'Product';
                                                                  }
                                                                })()}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
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
                                                                    height:
                                                                        405.0,
                                                                    enlargeCenterPage:
                                                                        true,
                                                                    autoPlay: productData[index]['category'].length <=
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
                                                                        print(
                                                                            'hhh $indexes2');
                                                                        bool check = currentIndex
                                                                            .where((entry) =>
                                                                                entry.uid ==
                                                                                index)
                                                                            .isNotEmpty;

                                                                        if (check) {
                                                                          setState(
                                                                              () {
                                                                            currentIndex.firstWhere((entry) => entry.uid == index).current =
                                                                                indexD;
                                                                          });
                                                                        } else {
                                                                          setState(
                                                                              () {
                                                                            currentIndex.add(DisplayEntry3(
                                                                              uid: index,
                                                                              current: indexD,
                                                                            ));
                                                                          });
                                                                        }
                                                                        // print(
                                                                        //     'john ${indexD}');

                                                                        if (indexes2.firstWhere((entry) => entry.uid == index).filters[indexD] ==
                                                                            -1) {
                                                                          List filteredList2 = productData[index]['category']
                                                                              .asMap()
                                                                              .entries
                                                                              .where((entry) => (entry.key + 1) % 6 == 0)
                                                                              .map((entry) => entry.value)
                                                                              .toList();

                                                                          List<dynamic>
                                                                              slicedList =
                                                                              productData[index]['category'].sublist(filteredList2.length * 6, productData[index]['category'].length);

                                                                          mainDisplay
                                                                              .firstWhere((entry) => entry.uid == index)
                                                                              .display = slicedList;
                                                                        } else if (indexD ==
                                                                                0 &&
                                                                            indexes2.firstWhere((entry) => entry.uid == index).filters[indexD] !=
                                                                                -1) {
                                                                          List<dynamic>
                                                                              slicedList =
                                                                              productData[index]['category'].sublist(0, indexes2.firstWhere((entry) => entry.uid == index).filters[0] + 1);

                                                                          mainDisplay
                                                                              .firstWhere((entry) => entry.uid == index)
                                                                              .display = slicedList;

                                                                          // print(
                                                                          //     slicedList);
                                                                        } else {
                                                                          List<dynamic>
                                                                              slicedList =
                                                                              productData[index]['category'].sublist(indexes2.firstWhere((entry) => entry.uid == index).filters[indexD - 1] + 1, indexes2.firstWhere((entry) => entry.uid == index).filters[indexD] + 1);

                                                                          mainDisplay
                                                                              .firstWhere((entry) => entry.uid == index)
                                                                              .display = slicedList;
                                                                        }
                                                                      });

                                                                      // You can use the onPageChanged callback to update the current page index
                                                                    },

                                                                    //  dotColor: Colors.blue,
                                                                  ),
                                                                  items: filteredList2
                                                                      .firstWhere((entry) =>
                                                                          entry
                                                                              .uid ==
                                                                          index)
                                                                      .filt
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
                                                                          margin:
                                                                              EdgeInsets.symmetric(horizontal: 6.0),
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
                                                                              shrinkWrap: true,
                                                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                                crossAxisCount: 3,
                                                                                crossAxisSpacing: 20.0, // Horizontal spacing between itemsDot
                                                                                mainAxisSpacing: 20.0,
                                                                                childAspectRatio: childAspectRatio,
                                                                                // // Set the number of columns in the grid
                                                                              ),
                                                                              itemCount: mainDisplay.firstWhere((entry) => entry.uid == index).display.length,
                                                                              itemBuilder: (context, indexM) {
                                                                                return Container(
                                                                                    child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: Stack(children: [
                                                                                        Container(
                                                                                          height: 132,
                                                                                          width: 200,
                                                                                          decoration: BoxDecoration(color: Color(0xFFD9D9D9), borderRadius: BorderRadius.circular(10), border: Border.all(width: 1.5, color: Color(0xFF010CA6))),
                                                                                          child: Column(
                                                                                            children: [
                                                                                              Expanded(
                                                                                                child: Container(
                                                                                                  child: Image.network(
                                                                                                    '$imgUrl/${mainDisplay.firstWhere((entry) => entry.uid == index).display[indexM]['product'][0]['file_path'].substring(20)}',
                                                                                                    width: 70,
                                                                                                    height: 63,
                                                                                                    errorBuilder: (context, error, stackTrace) {
                                                                                                      print('Error loading image: $error');
                                                                                                      return Icon(
                                                                                                        Icons.error,
                                                                                                        size: 70, // Adjust the size based on your requirements
                                                                                                        color: Colors.red, // Customize the color
                                                                                                      );
                                                                                                    },
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        Positioned(
                                                                                            bottom: 0,
                                                                                            right: -2,
                                                                                            child: Container(
                                                                                                width: 23,
                                                                                                height: 23,
                                                                                                decoration: BoxDecoration(color: Color(0xFFFED800), borderRadius: BorderRadius.circular(100)),
                                                                                                child: Icon(
                                                                                                  Icons.edit,
                                                                                                  size: 13,
                                                                                                )))
                                                                                      ]),
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
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          '${mainDisplay.firstWhere((entry) => entry.uid == index).display[indexM]['product'][0]['description']}',
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
                                                                                              '₦${mainDisplay.firstWhere((entry) => entry.uid == index).display[indexM]['product'][0]['price']}',
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
                                                                      _controller[
                                                                          index][0],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 12,
                                                              ),
                                                              productData[index]
                                                                              [
                                                                              'category']
                                                                          .length <=
                                                                      6
                                                                  ? const Text(
                                                                      '')
                                                                  : Center(
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            20,
                                                                        width: MediaQuery.of(context)
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
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: List<Widget>.generate(
                                                                                filteredList2.firstWhere((entry) => entry.uid == index).filt.length,
                                                                                (dotIndex) {
                                                                                  bool isCurrent = currentIndex.firstWhere((entry) => entry.uid == index).current == dotIndex;

                                                                                  return Padding(
                                                                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                                                    child: GestureDetector(
                                                                                      onTap: () {
                                                                                        setState(() {
                                                                                          currentIndex.firstWhere((entry) => entry.uid == index).current = dotIndex;
                                                                                        });

                                                                                        print('testing ${currentIndex}');

                                                                                        if (indexes2.firstWhere((entry) => entry.uid == index).filters[dotIndex] == -1) {
                                                                                          List filteredList2 = productData[index]['category'].asMap().entries.where((entry) => (entry.key + 1) % 6 == 0).map((entry) => entry.value).toList();

                                                                                          List<dynamic> slicedList = productData[index]['category'].sublist(filteredList2.length * 6, productData[index]['category'].length);

                                                                                          mainDisplay.firstWhere((entry) => entry.uid == index).display = slicedList;
                                                                                        } else if (dotIndex == 0 && indexes2.firstWhere((entry) => entry.uid == index).filters[dotIndex] != -1) {
                                                                                          List<dynamic> slicedList = productData[index]['category'].sublist(0, indexes2.firstWhere((entry) => entry.uid == index).filters[0] + 1);

                                                                                          mainDisplay.firstWhere((entry) => entry.uid == index).display = slicedList;

                                                                                          // print(
                                                                                          //     slicedList);
                                                                                        } else {
                                                                                          List<dynamic> slicedList = productData[index]['category'].sublist(indexes2.firstWhere((entry) => entry.uid == index).filters[dotIndex - 1] + 1, indexes2.firstWhere((entry) => entry.uid == index).filters[dotIndex] + 1);

                                                                                          mainDisplay.firstWhere((entry) => entry.uid == index).display = slicedList;
                                                                                        }

                                                                                        _controller[index][0].animateToPage(currentIndex.firstWhere((entry) => entry.uid == index).current);

                                                                                        // _controller[index].animateToPage(currentIndex.firstWhere((entry) => entry.uid == index).current);
                                                                                      },
                                                                                      child: Container(
                                                                                        width: isCurrent ? 15 : 10,
                                                                                        height: 10,
                                                                                        decoration: BoxDecoration(
                                                                                          gradient: isCurrent
                                                                                              ? LinearGradient(
                                                                                                  begin: Alignment.topLeft,
                                                                                                  end: Alignment.bottomRight,
                                                                                                  colors: [
                                                                                                    Color(0xFF010CA6),
                                                                                                    Color(0xFFFFDB00),
                                                                                                  ],
                                                                                                )
                                                                                              : LinearGradient(
                                                                                                  begin: Alignment.topLeft,
                                                                                                  end: Alignment.bottomRight,
                                                                                                  colors: [
                                                                                                    Colors.grey,
                                                                                                    Colors.grey,
                                                                                                  ],
                                                                                                ),
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
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  print(
                                                                      'hello');
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 218,
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              7),
                                                                  decoration: BoxDecoration(
                                                                      color: Color(
                                                                          0xFF010CA6),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20)),
                                                                  child: Center(
                                                                    child:
                                                                        const Text(
                                                                      'View all',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
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
                        const SizedBox(
                          height: 25,
                        ),

                        // new levels
                        // Text('hello')
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
