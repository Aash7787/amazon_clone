import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/search/screen/search_screen.dart';

String globalInitialValue = '';

class AppBarCart extends StatefulWidget implements PreferredSizeWidget {
  static const double _radius = 7.0;
  static const double _appBarPaddingLeft = 15.0;
  static const _appBarHint = 'Search Amazon.in';

  static const _borderSideWidth = 1.5;

  const AppBarCart({super.key});

  @override
  State<AppBarCart> createState() => _AppBarCartState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _AppBarCartState extends State<AppBarCart> {
  void navigateToSearchScreen(String query) {
    // Navigate to SearchScreen
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
    globalInitialValue = query;
  }

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
              padding:
                  const EdgeInsets.only(left: AppBarCart._appBarPaddingLeft),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppBarCart._radius),
                child: TextFormField(
                  onFieldSubmitted: navigateToSearchScreen,
                  decoration: InputDecoration(
                    hintText: AppBarCart._appBarHint,
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
                        width: AppBarCart._borderSideWidth,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black54,
                        width: AppBarCart._borderSideWidth,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black54,
                        width: AppBarCart._borderSideWidth,
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
                  child: Icon(Icons.mic),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
