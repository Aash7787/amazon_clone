import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/admin/screen/posts_screen.dart';

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
  static const _labelAnalytics = 'Analytics';
  static const _labelInbox = 'Inbox';

  var pages = <Widget>[
    const PostsScreen(),
    const Center(child: Text('Analytics page')),
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
              child: const Icon(Icons.home_outlined),
            ),
          ),
          BottomNavigationBarItem(
            //  Analytics bar

            label: _labelAnalytics,
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
              child: const Icon(Icons.analytics_outlined),
            ),
          ),
          BottomNavigationBarItem(
            //  Orders
            label: _labelInbox,
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
              child: const Icon(Icons.all_inbox_outlined),
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
