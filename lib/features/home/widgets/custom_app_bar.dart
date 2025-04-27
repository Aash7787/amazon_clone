import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/admin/model/product.dart';
import 'package:flutter_amazon_clone/features/search/screen/search_screen.dart';
import 'package:flutter_amazon_clone/features/search/service/search_service.dart';

String globalInitialValue = '';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  static const double _appBarPaddingLeft = 5.0;
  static const double _appBarPaddingBottom = 5.0;
  static const String _appBarHint = 'Search Amazon.in';

  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final SearchService searchService = SearchService();
  late final SearchController _searchController;
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _searchController = SearchController();
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
    globalInitialValue = query;
    _searchController.text = query;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: GlobalVariables.appBarGradient,
        ),
      ),
      title: Container(
        padding: const EdgeInsets.only(
            left: CustomAppBar._appBarPaddingLeft,
            bottom: CustomAppBar._appBarPaddingBottom),
        child: SearchAnchor.bar(
          viewBackgroundColor: Colors.white,
          searchController: _searchController,
          barLeading: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(Icons.search),
          ),
          barTrailing: const [
            Padding(
              padding: EdgeInsets.only(
                right: 8.0,
              ),
              child: Icon(Icons.mic),
            ),
          ],
          barHintText: CustomAppBar._appBarHint,
          onSubmitted: navigateToSearchScreen,
          onChanged: (value) {
            _fetchSearchProduct(value);
          },
          suggestionsBuilder: (context, controller) {
            return products
                .map(
                  (e) => ListTile(
                    title: Text(e.name),
                    onTap: () => navigateToSearchScreen(e.name),
                  ),
                )
                .toList();
          },
        ),
      ),
    );
  }

  _fetchSearchProduct(String searchQuery) async {
    products = await searchService.fetchSearchProduct(
        context: context, query: searchQuery);
    setState(() {});
  }
}
