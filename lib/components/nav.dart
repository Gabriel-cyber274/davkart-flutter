import 'package:flutter/material.dart';

class MyNav extends StatefulWidget implements PreferredSizeWidget {
  const MyNav({super.key});

  @override
  State<MyNav> createState() => _MyNavState();

  @override
  Size get preferredSize => Size.fromHeight(100.0);
}

class _MyNavState extends State<MyNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
      child: AppBar(
        leading: Image.asset(
          'lib/assets/davkart Logo short 1.png',
          height: 28,
        ),
        backgroundColor:
            Colors.transparent, // Set background color to transparent
        elevation: 0.0,
        titleSpacing: 0.5,
        title: TextField(
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              fillColor: Color(0xFFFFFFFF),
              filled: true,
              contentPadding: EdgeInsets.zero,
              prefixIcon: Icon(Icons.search),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(30)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(30)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(30)),
              hintText: 'Search Orders, Products, or Customers...'),
        ),
        actions: [
          Image.asset(
            'lib/assets/Notification.png',
            height: 28,
            // height: 300,
          ),
        ],
      ),
    );
  }
}
