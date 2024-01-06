// import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../components/bottom_navigation_bar.dart';
import 'profile_page.dart';
import '../../components/nav.dart';
import 'package:dots_indicator/dots_indicator.dart';
import './my_products.dart';

class IndexPage extends StatefulWidget {
  final userInfo;
  final String token;

  const IndexPage({Key? key, required this.userInfo, required this.token})
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
  int _currentIndex = 0;
  List<String> itemsDot = [];
  List currentIndex = [];
  bool loading = false;
  final String url = 'http://10.0.2.2:8000/api';
  // final String url = 'https://75f9-105-113-68-246.ngrok-free.app/api';
  // final String imgUrl = 'https://75f9-105-113-68-246.ngrok-free.app/api/imgs';
  final String imgUrl = 'http://10.0.2.2:8000/api/imgs';

  late CarouselController _carouselController;

  @override
  void initState() {
    super.initState();
    // arrangeData();
    getProductsHome();
    setState(() {
      _currentIndex = 0;
    });
    print(widget.userInfo['admin']);
    _carouselController = CarouselController();
  }

  int mainIndex = 0;

  List indexes2 = [];
  List mainDisplay = [];
  List productData = [];

  List filteredList2 = [];
  List pendingOrder = [];
  List completedOrder = [];

  void getProductsHome() async {
    // final String tokenU = ;
    // print(widget.token);

    try {
      setState(() {
        loading = true;
      });

      final response = await http.get(
        // Uri.parse('$url/getUserInterestProducts'),
        Uri.parse('$url/adminShowRoom'),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
          'Content-Type': 'application/json',
        },
      );

      final response2 = await http.get(
        Uri.parse('$url/getPendingOrder'),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
          'Content-Type': 'application/json',
        },
      );

      final response3 = await http.get(
        Uri.parse('$url/getCompletedOrder'),
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
      if (response2.statusCode == 200) {
        // Successful request, handle the data here
        Map<String, dynamic> data = json.decode(response2.body);

        setState(() {
          pendingOrder = data['order'];
        });
      } else {
        print('Failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
      if (response3.statusCode == 200) {
        // Successful request, handle the data here
        Map<String, dynamic> data = json.decode(response3.body);

        setState(() {
          completedOrder = data['order'];
        });
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

  // void set2(index, dotI) {
  //   setState(() {
  //     currentIndex.add(index);
  //     currentIndex2 = dotI;
  //   });
  // }

  void mainArrangement() {
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
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                // color: Colors.blueGrey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: Column(
                      children: [
                        Center(
                          child: productData.isNotEmpty
                              ? const Text(
                                  'Current lisitings',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              : SizedBox(),
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
                                    height: screenHeight / 1.5,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // SizedBox(
                                          //   height: 30,
                                          // ),
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
                                : Container(
                                    // height: screenHeight /
                                    //     1.5, // Adjust the height as needed
                                    child: Container(
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0),
                                            child: Container(
                                              width: screenWidth,
                                              height: 500,
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
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Center(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        color: Colors.white),
                                                    width: screenWidth,
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        CarouselSlider(
                                                          options:
                                                              CarouselOptions(
                                                            height: 445.0,
                                                            enlargeCenterPage:
                                                                true,
                                                            autoPlay: productData
                                                                        .length <=
                                                                    1
                                                                ? false
                                                                : true,
                                                            aspectRatio: 16 / 9,
                                                            autoPlayCurve: Curves
                                                                .fastOutSlowIn,
                                                            enableInfiniteScroll:
                                                                productData.length <=
                                                                        1
                                                                    ? false
                                                                    : true,
                                                            autoPlayAnimationDuration:
                                                                Duration(
                                                                    milliseconds:
                                                                        800),
                                                            viewportFraction: 1,
                                                            autoPlayInterval:
                                                                Duration(
                                                                    seconds:
                                                                        10),
                                                            pauseAutoPlayOnTouch:
                                                                true,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            onPageChanged:
                                                                (index,
                                                                    reason) {
                                                              setState(() {
                                                                mainIndex =
                                                                    index;
                                                              });
                                                              // Handle page change
                                                            },
                                                          ),
                                                          carouselController:
                                                              _carouselController,
                                                          items: productData
                                                              .map<Widget>(
                                                                  (item) {
                                                            return Builder(
                                                                builder: (
                                                              BuildContext
                                                                  context,
                                                            ) {
                                                              return Container(
                                                                // color: Colors
                                                                //     .green,
                                                                child: Center(
                                                                  child: Column(
                                                                    children: [
                                                                      Text(
                                                                        '${item['category'][0]['category']} ',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Container(
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          margin:
                                                                              EdgeInsets.symmetric(horizontal: 6.0),
                                                                          child:
                                                                              SingleChildScrollView(
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
                                                                              itemCount: item['category'].length,
                                                                              itemBuilder: (context, indexM) {
                                                                                return Container(
                                                                                    child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                                  children: [
                                                                                    Expanded(
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
                                                                                          height: 91,
                                                                                          // width: 200,
                                                                                          decoration: BoxDecoration(color: Color(0xFFD9D9D9), borderRadius: BorderRadius.circular(10), border: Border.all(width: 1.5, color: Color(0xFF010CA6))),
                                                                                          child: Column(
                                                                                            children: [
                                                                                              Expanded(
                                                                                                child: Container(
                                                                                                  child: Image.network(
                                                                                                    '$imgUrl/${item['category'][indexM]['product'][0]['file_path'].substring(20)}',
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
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                        Text(
                                                                                          '${item['category'][indexM]['product'][0]['product_name']}',
                                                                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          '${item['category'][indexM]['product'][0]['description']}',
                                                                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 6,
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Container(
                                                                                          color: Color(0xFFFED800),
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              '₦${item['category'][indexM]['product'][0]['price']}',
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
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                          }).toList(),
                                                        ),
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: List<
                                                                Widget>.generate(
                                                              productData
                                                                  .length,
                                                              (dotIndex) {
                                                                bool isCurrent =
                                                                    mainIndex ==
                                                                        dotIndex;
                                                                return Container(
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              10),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            4.0),
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          mainIndex =
                                                                              dotIndex;
                                                                          // currentIndex.firstWhere((entry) => entry.uid == index).current = dotIndex;
                                                                        });

                                                                        _carouselController
                                                                            .animateToPage(dotIndex);

                                                                        print(
                                                                            'testing ${currentIndex}');

                                                                        // _controller[index].animateToPage(currentIndex.firstWhere((entry) => entry.uid == index).current);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width: isCurrent
                                                                            ? 15
                                                                            : 10,
                                                                        height:
                                                                            10,
                                                                        decoration:
                                                                            BoxDecoration(
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
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          color: isCurrent
                                                                              ? Colors.blue
                                                                              : Colors.grey,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
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

                                      // ... your builder code
                                    ),
                                  ),
                        const SizedBox(
                          height: 35,
                        ),
                        widget.userInfo['admin'] && !loading
                            ? Column(
                                children: [
                                  const Text(
                                    'Order statuses',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: screenWidth,
                                    // height: 550,
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
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              color: Colors.white),
                                          width: screenWidth,
                                          child: Column(
                                            children: [
                                              const Text(
                                                'Monitor Order Progress',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              const SizedBox(
                                                height: 26,
                                              ),
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    15, 10, 15, 10),
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFFED800),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(
                                                                0.5), // Shadow color
                                                        spreadRadius:
                                                            5, // Spread radius
                                                        blurRadius:
                                                            7, // Blur radius
                                                        offset: Offset(0,
                                                            3), // Offset in the x, y direction
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Pending Orders (${pendingOrder.length})',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Image.asset(
                                                        'lib/assets/ARROW LEFT.png')
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    15, 10, 15, 10),
                                                decoration: BoxDecoration(
                                                    color: Color(0xFF34A853),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(
                                                                0.5), // Shadow color
                                                        spreadRadius:
                                                            5, // Spread radius
                                                        blurRadius:
                                                            7, // Blur radius
                                                        offset: Offset(0,
                                                            3), // Offset in the x, y direction
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      'Completed orders',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Image.asset(
                                                        'lib/assets/ARROW LEFT.png')
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
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
