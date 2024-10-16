import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/account/widgets/product_tile_w.dart';
import 'package:flutter_amazon_clone/features/admin/model/product.dart';
import 'package:flutter_amazon_clone/features/home/service/home_services.dart';
import 'package:flutter_amazon_clone/features/home/widgets/custom_app_bar_for_category_w.dart';

class CategoryDealsScreen extends StatefulWidget {
  const CategoryDealsScreen({super.key, required this.category});

  static const pageName = 'category-page';

  final String category;

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;

  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    _fetchCategoryProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarForCategoryW(
        category: widget.category,
      ),
      body: productList == null
          ? const CircularProgressIndicator()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep shopping for ${widget.category}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                    itemCount: productList!.length,
                    padding: const EdgeInsets.only(left: 10),
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.4,
                            mainAxisSpacing: 5,
                            crossAxisCount: 1),
                    itemBuilder: (context, index) => Column(
                      children: [
                        Expanded(
                          child: ProductTileW(
                            image: productList![index].images[0],
                          ),
                        ),
                        Text(productList![index].name)
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }

  void _fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProduct(
        context: context, category: widget.category);
    setState(() {});
  }
}
