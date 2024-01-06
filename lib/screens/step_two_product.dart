import 'dart:ffi';

import 'package:flutter/material.dart';
import '../pages/mainPages/my_products.dart';
import './step_three_product.dart';

class StepTwoProduct extends StatefulWidget {
  final userInfo;
  final String token;
  final String name;
  final String description;
  final String category;
  final String price;

  const StepTwoProduct(
      {Key? key,
      required this.userInfo,
      required this.token,
      required this.price,
      required this.name,
      required this.description,
      required this.category})
      : super(key: key);

  @override
  State<StepTwoProduct> createState() => _StepTwoProductState();
}

class _StepTwoProductState extends State<StepTwoProduct> {
  List<dynamic> hashTags = [];
  bool featured = true;
  final tagsController = TextEditingController();
  final sizeController = TextEditingController();
  final colorController = TextEditingController();
  final piecesController = TextEditingController();
  final cartonController = TextEditingController();

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
            height: 18,
          ),
          const Center(
              child: Text(
            'Please Review details before submitting.',
            style: TextStyle(color: Color(0xFF3A3A3A99), fontSize: 17),
          )),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Step 2 of 3',
            style: TextStyle(
                color: Color(0xFF010CA6), fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: screenWidth,
                height: 750,
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
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Product Details',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: sizeController,
                                        decoration: const InputDecoration(
                                          hintText: 'Size/Weight',
                                          hintStyle: TextStyle(
                                              color: Color(0xFF3A3A3A99),
                                              fontSize: 14),
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                              borderSide: BorderSide(
                                                  color: Color(0xFF3A3A3A))),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: colorController,
                                        decoration: const InputDecoration(
                                          hintText: 'Color : Red, blue...',
                                          hintStyle: TextStyle(
                                              color: Color(0xFF3A3A3A99),
                                              fontSize: 14),
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                              borderSide: BorderSide(
                                                  color: Color(0xFF3A3A3A))),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Quantity',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: piecesController,
                                        decoration: const InputDecoration(
                                          hintText: 'Pieces',
                                          hintStyle: TextStyle(
                                              color: Color(0xFF3A3A3A99),
                                              fontSize: 14),
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                              borderSide: BorderSide(
                                                  color: Color(0xFF3A3A3A))),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: cartonController,
                                        decoration: InputDecoration(
                                          hintText: 'Carton',
                                          hintStyle: TextStyle(
                                              color: Color(0xFF3A3A3A99),
                                              fontSize: 14),
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                              borderSide: BorderSide(
                                                  color: Color(0xFF3A3A3A))),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Tags',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Add relevant tags for easy recognition',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF3A3A3A),
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Container(
                                    width: screenWidth,
                                    height: 170,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF5F5F5),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                        border: Border.all(
                                            width: 1.2,
                                            color: Color(0xFF3A3A3A))),
                                    child: SingleChildScrollView(
                                      child: Wrap(
                                        spacing: 8.0,
                                        runSpacing: 8.0,
                                        children: [
                                          for (var tag in hashTags)
                                            Container(
                                                padding: EdgeInsets.all(2),
                                                // height: 16,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(50),
                                                    ),
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
                                                    color: Colors.white),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      tag,
                                                      style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Color(
                                                              0xFF3A3A3A)),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        List<dynamic>
                                                            selectedItem =
                                                            hashTags
                                                                .where(
                                                                    (element) =>
                                                                        element !=
                                                                        tag)
                                                                .toList();
                                                        setState(() {
                                                          hashTags =
                                                              selectedItem;
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.cancel,
                                                        size: 30,
                                                        color:
                                                            Color(0xFF010CA6),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          hashTags.length != 6
                                              ? Container(
                                                  width: 50,
                                                  child: TextField(
                                                    controller: tagsController,
                                                    onEditingComplete: () {
                                                      if (hashTags.length < 6 &&
                                                          tagsController.text !=
                                                              '') {
                                                        setState(() {
                                                          hashTags.add('#' +
                                                              tagsController
                                                                  .text);
                                                          tagsController
                                                              .clear();
                                                        });
                                                      }
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText: 'Add',
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      hintStyle: TextStyle(
                                                        color:
                                                            Color(0xFF3A3A3A99),
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Set Product as featured',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          featured = !featured;
                                        });
                                      },
                                      child: Container(
                                        width: 63,
                                        height: 34,
                                        decoration: BoxDecoration(
                                            color: featured
                                                ? Color(0xFF34A853)
                                                : Color(0xFF3A3A3A),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: 8.5,
                                              left: featured ? 10 : 33,
                                              child: Text(
                                                featured ? 'Yes' : 'No',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            Positioned(
                                                right: featured ? 5 : 38,
                                                top: 7,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      featured = !featured;
                                                    });
                                                  },
                                                  child: Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50))),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 45.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    // if (nameController.text != '' &&
                                    //     descriptionController.text != '' &&
                                    //     priceController.text != '' &&
                                    //     selectedValue != 'Category') {
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => StepTwoProduct(
                                    //             token: widget.token,
                                    //             userInfo: widget.userInfo,
                                    //             name: nameController.text,
                                    //             description:
                                    //                 descriptionController.text,
                                    //             category: selectedValue,
                                    //             price: priceController.text)),
                                    //   );
                                    // } else if (nameController.text == '') {
                                    //   final banner = MaterialBanner(
                                    //     content: const Text(
                                    //       'Name field is required',
                                    //       style: TextStyle(
                                    //           color: Colors.white, fontSize: 16),
                                    //     ),
                                    //     padding: const EdgeInsets.only(
                                    //         top: 10,
                                    //         right: 3,
                                    //         bottom: 10,
                                    //         left: 10),
                                    //     leading: const Icon(
                                    //       Icons.error,
                                    //       color: Colors.white,
                                    //     ),
                                    //     elevation: 5,
                                    //     backgroundColor: Colors.red,
                                    //     actions: [
                                    //       TextButton(
                                    //         onPressed: () {
                                    //           // Do something when the action is pressed
                                    //           ScaffoldMessenger.of(context)
                                    //               .hideCurrentMaterialBanner();
                                    //         },
                                    //         child: const Icon(
                                    //           Icons.close,
                                    //           color: Colors.white,
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   );

                                    //   ScaffoldMessenger.of(context)
                                    //       .showMaterialBanner(banner);
                                    //   await Future.delayed(Duration(
                                    //       seconds:
                                    //           1)); // Adjust the delay as needed
                                    //   ScaffoldMessenger.of(context)
                                    //       .hideCurrentMaterialBanner();
                                    // } else if (descriptionController.text == '') {
                                    //   final banner = MaterialBanner(
                                    //     content: const Text(
                                    //       'Description field is required',
                                    //       style: TextStyle(
                                    //           color: Colors.white, fontSize: 16),
                                    //     ),
                                    //     padding: const EdgeInsets.only(
                                    //         top: 10,
                                    //         right: 3,
                                    //         bottom: 10,
                                    //         left: 10),
                                    //     leading: const Icon(
                                    //       Icons.error,
                                    //       color: Colors.white,
                                    //     ),
                                    //     elevation: 5,
                                    //     backgroundColor: Colors.red,
                                    //     actions: [
                                    //       TextButton(
                                    //         onPressed: () {
                                    //           // Do something when the action is pressed
                                    //           ScaffoldMessenger.of(context)
                                    //               .hideCurrentMaterialBanner();
                                    //         },
                                    //         child: const Icon(
                                    //           Icons.close,
                                    //           color: Colors.white,
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   );

                                    //   ScaffoldMessenger.of(context)
                                    //       .showMaterialBanner(banner);
                                    //   await Future.delayed(Duration(
                                    //       seconds:
                                    //           1)); // Adjust the delay as needed
                                    //   ScaffoldMessenger.of(context)
                                    //       .hideCurrentMaterialBanner();
                                    // }
                                    if (sizeController.text != '' &&
                                        colorController.text != '' &&
                                        piecesController.text != '' &&
                                        cartonController.text != '' &&
                                        hashTags.isNotEmpty) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StepThreeProduct(
                                                    token: widget.token,
                                                    size: sizeController.text,
                                                    color: colorController.text,
                                                    pieces:
                                                        piecesController.text,
                                                    carton:
                                                        cartonController.text,
                                                    hastags: hashTags,
                                                    userInfo: widget.userInfo,
                                                    name: widget.name,
                                                    featured: featured,
                                                    description:
                                                        widget.description,
                                                    category: widget.category,
                                                    price: widget.price)),
                                      );
                                    } else if (sizeController.text == '') {
                                      final banner = MaterialBanner(
                                        content: const Text(
                                          'size field is required',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            right: 3,
                                            bottom: 10,
                                            left: 10),
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
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentMaterialBanner();
                                            },
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showMaterialBanner(banner);
                                      await Future.delayed(Duration(
                                          seconds:
                                              1)); // Adjust the delay as needed
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentMaterialBanner();
                                    } else if (colorController.text == '') {
                                      final banner = MaterialBanner(
                                        content: const Text(
                                          'color field is required',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            right: 3,
                                            bottom: 10,
                                            left: 10),
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
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentMaterialBanner();
                                            },
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showMaterialBanner(banner);
                                      await Future.delayed(Duration(
                                          seconds:
                                              1)); // Adjust the delay as needed
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentMaterialBanner();
                                    } else if (piecesController.text == '') {
                                      final banner = MaterialBanner(
                                        content: const Text(
                                          'pieces field is required',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            right: 3,
                                            bottom: 10,
                                            left: 10),
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
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentMaterialBanner();
                                            },
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showMaterialBanner(banner);
                                      await Future.delayed(Duration(
                                          seconds:
                                              1)); // Adjust the delay as needed
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentMaterialBanner();
                                    } else if (cartonController.text == '') {
                                      final banner = MaterialBanner(
                                        content: const Text(
                                          'carton field is required',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            right: 3,
                                            bottom: 10,
                                            left: 10),
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
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentMaterialBanner();
                                            },
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showMaterialBanner(banner);
                                      await Future.delayed(Duration(
                                          seconds:
                                              1)); // Adjust the delay as needed
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentMaterialBanner();
                                    } else if (hashTags.isEmpty) {
                                      final banner = MaterialBanner(
                                        content: const Text(
                                          'Add product hashtags',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            right: 3,
                                            bottom: 10,
                                            left: 10),
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
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentMaterialBanner();
                                            },
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showMaterialBanner(banner);
                                      await Future.delayed(Duration(
                                          seconds:
                                              1)); // Adjust the delay as needed
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentMaterialBanner();
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 13,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF010CA6),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Proceed',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    )),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
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
                                            'Cancel',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF3A3A3A)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            left: 10,
                            top: 10,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                'lib/assets/Back.png',
                                height: 28,
                                // height: 300,
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
          ),
        ],
      ))),
    );
  }
}
