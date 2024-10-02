import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/account/screens/account_screen.dart';
import 'package:flutter_amazon_clone/features/home/screen/home_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  static const pageName = 'bottom/bar';

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;

  static const _iconSize = 28.0;
  static const _width = 42.0;
  static const _borderSideWidth = 5.0;

  static const _labelHome = 'Home';
  static const _labelPerson = 'Home';
  static const _labelCart = 'Home';

  var pages = [
    const HomeScreen(),
    const AccountScreen(),
    const Center(child: Text('Cart page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _updatePage,
        items: [
          BottomNavigationBarItem(
            //  Home Bar
            label: _labelHome,
            icon: Container(
              width: _width,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _currentIndex == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: _borderSideWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.home),
            ),
          ),
          BottomNavigationBarItem(
            //  Person Bar

            label: _labelPerson,
            icon: Container(
              width: _width,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _currentIndex == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: _borderSideWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.person),
            ),
          ),
          BottomNavigationBarItem(
            //  Cart

            label: _labelCart,
            icon: Container(
              width: _width,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _currentIndex == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: _borderSideWidth,
                  ),
                ),
              ),
              child: const Badge(
                backgroundColor: Colors.white,
                label: Text(
                  '2',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: Icon(
                  Icons.shopping_cart_rounded,
                ),
              ),
            ),
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: _iconSize,
      ),
    );
  }

  void _updatePage(int value) {
    setState(() {
      _currentIndex = value;
    });
  }
}
