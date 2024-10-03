import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const double _radius = 7.0;
  static const double _appBarPaddingLeft = 15.0;
  static const _appBarHint = 'Search Amazon.in';

  static const _borderSideWidth = 1.5;

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: _appBarPaddingLeft),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(_radius),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: _appBarHint,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 17,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.only(top: 10),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black54,
                        width: _borderSideWidth,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black54,
                        width: _borderSideWidth,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black54,
                        width: _borderSideWidth,
                      ),
                    ),
                    prefixIcon: InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(Icons.search),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
