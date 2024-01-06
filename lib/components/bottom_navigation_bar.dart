// bottom_navigation_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  MyBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        unselectedItemColor: Color(0xFF3A3A3A99),
        selectedItemColor: Color(0xFF3A3A3A99),
        showUnselectedLabels: true,
        unselectedFontSize: 12,
        selectedFontSize: 12,

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
        // onTap: (index) {
        //   // setState(() {
        //     currentIndex = index;
        //   // });
        // },
        currentIndex: currentIndex,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: Transform.translate(
              offset: Offset(0.0, currentIndex == 0 ? -12.0 : -8.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: currentIndex == 0 ? const Color(0xFF010CA6) : null,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SvgPicture.asset(
                  'lib/assets/Home Icon.svg',
                  color: currentIndex == 0 ? Colors.white : null,
                  // width: 18,
                  // height: 18,
                ),
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Transform.translate(
                offset: Offset(0.0, currentIndex == 1 ? -12.0 : -8.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: currentIndex == 1 ? Color(0xFF010CA6) : null,
                      borderRadius: BorderRadius.circular(20)),
                  child: SvgPicture.asset(
                    'lib/assets/Group 18.svg',
                    color: currentIndex == 1 ? Colors.white : null,
                    // width: 18,
                    // height: 18,
                  ),
                ),
              ),
              label: 'Products'),
          BottomNavigationBarItem(
              icon: Transform.translate(
                offset: Offset(0.0, currentIndex == 2 ? -12.0 : -8.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: currentIndex == 2 ? Color(0xFF010CA6) : null,
                      borderRadius: BorderRadius.circular(20)),
                  child: SvgPicture.asset(
                    'lib/assets/Group 19.svg',
                    color: currentIndex == 2 ? Colors.white : null,
                    // width: 18,
                    // height: 18,
                  ),
                ),
              ),
              label: 'Orders'),
          BottomNavigationBarItem(
              icon: Transform.translate(
                offset: Offset(0.0, currentIndex == 3 ? -12.0 : -8.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: currentIndex == 3 ? Color(0xFF010CA6) : null,
                      borderRadius: BorderRadius.circular(20)),
                  child: SvgPicture.asset(
                    'lib/assets/Group 16.svg',
                    color: currentIndex == 3 ? Colors.white : null,
                    // width: 18,
                    // height: 18,
                  ),
                ),
              ),
              label: 'Messaging'),
          BottomNavigationBarItem(
              icon: Transform.translate(
                offset: Offset(0.0, currentIndex == 4 ? -12.0 : -8.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: currentIndex == 4 ? Color(0xFF010CA6) : null,
                      borderRadius: BorderRadius.circular(20)),
                  child: SvgPicture.asset(
                    'lib/assets/Group.svg',
                    color: currentIndex == 4 ? Colors.white : null,
                    // width: 18,
                    // height: 18,
                  ),
                ),
              ),
              label: 'Profile'),
        ]);
  }
}
