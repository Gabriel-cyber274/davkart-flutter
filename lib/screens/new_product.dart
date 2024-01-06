import 'package:flutter/material.dart';
import '../pages/mainPages/my_products.dart';
import './step_two_product.dart';

class MyProductCreate extends StatefulWidget {
  final userInfo;
  final String token;

  const MyProductCreate({Key? key, required this.userInfo, required this.token})
      : super(key: key);

  @override
  State<MyProductCreate> createState() => _MyProductCreateState();
}

class _MyProductCreateState extends State<MyProductCreate> {
  String selectedValue = 'Category';

  final nameController = TextEditingController();

  final descriptionController = TextEditingController();

  final priceController = TextEditingController();

  final items = [
    'Electronics',
    'Clothing and Fashion',
    'Home and Furniture',
    'Beauty and Personal Care',
    'Sports and Outdoors',
    'Books and Stationery',
    'Toys and Games',
    'Jewelry and Watches',
    'Pet Supplies',
    'Baby and Kids',
    'Appliances',
    'Grocery and Gourmet',
  ];

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
            'Step 1 of 3',
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
                height: 650,
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
                            height: 20,
                          ),
                          const Text(
                            'Product Information',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Name'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextField(
                                    controller: nameController,
                                    decoration: const InputDecoration(
                                      hintText: 'Product Name',
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
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                    ),
                                  )
                                
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Description'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextField(
                                    maxLines: 5,
                                    controller: descriptionController,
                                    decoration: const InputDecoration(
                                      hintText:
                                          'Description : Red sleeveless shirt',
                                      hintStyle: TextStyle(
                                          color: Color(0xFF3A3A3A99),
                                          fontSize: 14),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 7, 10, 7),
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
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text('Product Details'),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Category'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: DropdownButton<String>(
                                      value: selectedValue,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedValue = newValue!;
                                        });
                                      },
                                      isExpanded: true,
                                      underline: Container(),
                                      items: [
                                        DropdownMenuItem<String>(
                                          value: 'Category',
                                          child: Text(
                                            'Category',
                                            style: TextStyle(
                                              color: Color(0xFF3A3A3A99),
                                            ),
                                          ),
                                        ),
                                        for (var item in items)
                                          DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Price'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextField(
                                    controller: priceController,
                                    decoration: const InputDecoration(
                                      hintText: 'Price (₦) ',
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
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 45.0),
                            child: GestureDetector(
                              onTap: () async {
                                if (nameController.text != '' &&
                                    descriptionController.text != '' &&
                                    priceController.text != '' &&
                                    selectedValue != 'Category') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StepTwoProduct(
                                            token: widget.token,
                                            userInfo: widget.userInfo,
                                            name: nameController.text,
                                            description:
                                                descriptionController.text,
                                            category: selectedValue,
                                            price: priceController.text)),
                                  );
                                } else if (nameController.text == '') {
                                  final banner = MaterialBanner(
                                    content: const Text(
                                      'Name field is required',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
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
                                } else if (descriptionController.text == '') {
                                  final banner = MaterialBanner(
                                    content: const Text(
                                      'Description field is required',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
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
                                } else if (priceController.text == '') {
                                  final banner = MaterialBanner(
                                    content: const Text(
                                      'Price field is required',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
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
                                } else if (selectedValue == 'Category') {
                                  final banner = MaterialBanner(
                                    content: const Text(
                                      'category field is required',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              width: screenWidth,
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
                                      borderRadius: BorderRadius.circular(20.0),
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
