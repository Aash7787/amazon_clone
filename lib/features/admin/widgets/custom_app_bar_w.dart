import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';

class CustomAppBarW extends StatelessWidget implements PreferredSizeWidget {
  static const String _amazonImgAsset =
      'assets/imgs/amazon_in.png'; // Amazon logo asset

  const CustomAppBarW({super.key});

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
          const Text(
            'Admin',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
