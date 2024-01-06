import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../pages/mainPages/my_products.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
// // import 'package:permission_handler/permission_handler.dart';
// import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:file_picker/file_picker.dart';
import './product_success.dart';

class StepThreeProduct extends StatefulWidget {
  final userInfo;
  final String token;
  final String name;
  final String description;
  final String category;
  final String price;
  final String size;
  final String color;
  final String pieces;
  final String carton;
  final bool featured;
  final List<dynamic> hastags;

  const StepThreeProduct(
      {Key? key,
      required this.userInfo,
      required this.token,
      required this.price,
      required this.size,
      required this.carton,
      required this.hastags,
      required this.color,
      required this.pieces,
      required this.name,
      required this.featured,
      required this.description,
      required this.category})
      : super(key: key);

  @override
  State<StepThreeProduct> createState() => _StepThreeProductState();
}

class _StepThreeProductState extends State<StepThreeProduct> {
  final String url = 'http://10.0.2.2:8000/api';
  // final String url = 'https://75f9-105-113-68-246.ngrok-free.app/api';
  // final String imgUrl = 'https://75f9-105-113-68-246.ngrok-free.app/api/imgs';
  final String imgUrl = 'http://10.0.2.2:8000/api/imgs';
  late ImagePicker _imagePicker;
  bool loading = false;
  File? _selectedImage;
  PickedFile? _pickedFile;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      _pickedFile = await _imagePicker.getImage(source: source);

      if (_pickedFile != null) {
        // Do something with the picked image file
        print("Image path: ${_pickedFile!.path}");
        setState(() {
          _selectedImage = File(_pickedFile!.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future addImage() async {
    String addimageUrl = '$url/createProduct';
    setState(() {
      loading = true;
    });

    try {
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer ${widget.token}',
        'accept': 'application/json'
      };

      Map<String, String> body = {
        'price': widget.price,
        'product_name': widget.name,
        'description': widget.description,
        'size': widget.size,
        'color': widget.color,
        'carton': widget.carton,
        'featured': widget.featured ? '1' : '0',
        'pieces': widget.pieces,
        'instock': 1.toString(),
      };

      var request = http.MultipartRequest('POST', Uri.parse(addimageUrl))
        ..fields.addAll(body.cast<String, String>())
        ..headers.addAll(headers)
        ..files.add(
            await http.MultipartFile.fromPath('file', _selectedImage!.path));
      var response = await request.send();
      setState(() {
        loading = false;
      });
      print(response.statusCode);
      if (response.statusCode == 201) {
        String result = await response.stream.bytesToString();

        Map<String, dynamic> resultMap = json.decode(result);

        addCategory(resultMap['id']);
      } else {
        setState(() {
          _selectedImage = null;
          loading = false;
        });
        String result = await response.stream.bytesToString();

        Map<String, dynamic> resultMap = json.decode(result);

        print(result);
        print(resultMap['id']);
      }
    } catch (e) {
      setState(() {
        _selectedImage = null;
        loading = false;
      });
    }
  }

  Future addCategory(id) async {
    try {
      final response = await http.post(
        Uri.parse('$url/productCategory'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.token}',
        },
        body: jsonEncode(<String, dynamic>{
          'category': widget.category,
          'product_id': id,
        }),
      );

      Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        addTags(id);
      } else {
        print(data);
      }
    } catch (e) {
      setState(() {
        loading = false;
        _selectedImage = null;
      });
    }
  }

  Future addTags(id) async {
    try {
      for (var i = 0; i < widget.hastags.length; i++) {
        final response = await http.post(
          Uri.parse('$url/addProductTags'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${widget.token}',
          },
          body: jsonEncode(<String, dynamic>{
            'tags': widget.hastags[i],
            'product_id': id,
          }),
        );

        Map<String, dynamic> data = jsonDecode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          setState(() {
            loading = false;
            _selectedImage = null;
          });

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyProductSuccess(
                      token: widget.token,
                      userInfo: widget.userInfo,
                    )),
          );
          print(data);
        } else {
          print(data);
        }
      }
    } catch (e) {
      setState(() {
        loading = false;
        _selectedImage = null;
      });
    }
  }

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
              child: Stack(children: [
        Column(
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
              'Step 3 of 3',
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
                        child: Stack(children: [
                          Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Product Media',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  width: screenWidth,
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(
                                          color: Color(0xFF3A3A3A),
                                          width: 1.2)),
                                  child: Column(
                                    children: [
                                      Text('Click here to add product Image'),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Image.asset(
                                        'lib/assets/upload.png',
                                        height: 58,
                                        // height: 300,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                          textAlign: TextAlign.center,
                                          'Add multiple for better representation (optional)')
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    _pickImage(ImageSource.gallery);

                                    // pickImage();
                                    // File? pickedImage = await pickImage();
                                    // if (pickedImage != null) {
                                    //   setState(() {
                                    //     _image = pickedImage;
                                    //   });
                                    //   await uploadImage(pickedImage);
                                    // }
                                  },
                                  child: Container(
                                    width: screenWidth,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                            color: Color(0xFF3A3A3A),
                                            width: 1.2)),
                                    child: Column(
                                      children: [
                                        const Text(
                                            'Click here to add Highlight Image'),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        _selectedImage != null
                                            ? Image.file(
                                                _selectedImage!,
                                                height: 58,
                                                width: 58,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                'lib/assets/upload.png',
                                                height: 58,
                                                // height: 300,
                                              ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Text(
                                            textAlign: TextAlign.center,
                                            'This would be the first photo customers would see')
                                      ],
                                    ),
                                  ),
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
                                    !loading
                                        // ? createProduct(_pickedFile)
                                        ? addImage()
                                        : print('heloo');
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 13,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF010CA6),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    child: const Center(
                                        child: Text(
                                      'Publish',
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
                            top: 15,
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
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        loading
            ? Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: 0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator()),
                    ]))
            : Container(),
      ]))),
    );
  }
}
