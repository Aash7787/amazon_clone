import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const String _amazonImgAsset =
      'assets/imgs/insta_buy_logo.png'; // Amazon logo asset

  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: GlobalVariables
              .appBarGradient, // Use the gradient from GlobalVariables
        ),
      ),
      title: Row(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Image.asset(
              _amazonImgAsset, // Use the predefined static asset
              width: 125,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 25),
                child: Icon(Icons.notifications_outlined),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(Icons.search),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
