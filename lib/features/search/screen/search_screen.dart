import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/loader.dart';
import 'package:flutter_amazon_clone/features/admin/model/product.dart';
import 'package:flutter_amazon_clone/features/home/widgets/address_box_w.dart';
import 'package:flutter_amazon_clone/features/search/service/search_service.dart';
import 'package:flutter_amazon_clone/features/search/widgets/search_product.dart';
import 'package:flutter_amazon_clone/features/search/widgets/search_screen_app_bar_w.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.searchQuery});

  static const pageName = 'searchScreen';

  final String searchQuery;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;

  final SearchService searchService = SearchService();

  @override
  void initState() {
    super.initState();
    _fetchSearchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchScreenAppBarW(),
      body: products == null
          ? const Center(
              child: Loader(),
            )
          : Column(
              children: [
                const AddressBoxW(),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: products!.length,
                  itemBuilder: (context, index) => SearchProduct(
                    product: products![index],
                  ),
                ),)
              ],
            ),
    );
  }

  _fetchSearchProduct() async {
    products = await searchService.fetchSearchProduct(
        context: context, query: widget.searchQuery);
    setState(() {});
  }
}
