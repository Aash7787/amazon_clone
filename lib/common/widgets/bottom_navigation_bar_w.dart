import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/account/screens/account_screen.dart';
import 'package:flutter_amazon_clone/features/auth/providers/user_auth_provider.dart';
import 'package:flutter_amazon_clone/features/cart/screen/cart_screen.dart';
import 'package:flutter_amazon_clone/features/home/screen/home_screen.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarW extends StatefulWidget {
  const BottomNavigationBarW({super.key});

  static const pageName = 'bottom/bar';

  @override
  State<BottomNavigationBarW> createState() => _BottomNavigationBarWState();
}

class _BottomNavigationBarWState extends State<BottomNavigationBarW> {
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
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserAuthProvider>().user.cart.length;
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
              child: const Icon(Icons.home_outlined),
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
              child: const Icon(Icons.person_2_outlined),
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
              child: Badge(
                backgroundColor: Colors.white,
                label: Text(
                  userCartLen.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
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
