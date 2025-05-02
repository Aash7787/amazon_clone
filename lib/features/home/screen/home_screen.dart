import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/loader.dart';
import 'package:flutter_amazon_clone/features/admin/model/product.dart';
import 'package:flutter_amazon_clone/features/home/service/home_services.dart';
import 'package:flutter_amazon_clone/features/home/widgets/address_box_w.dart';
import 'package:flutter_amazon_clone/features/home/widgets/carousel_slider_image_w.dart';
import 'package:flutter_amazon_clone/features/home/widgets/custom_app_bar.dart';
import 'package:flutter_amazon_clone/features/home/widgets/deal_of_the_day_w.dart';
import 'package:flutter_amazon_clone/features/home/widgets/product_tile.dart';
import 'package:flutter_amazon_clone/features/home/widgets/top_categories_w.dart';
import 'package:flutter_amazon_clone/features/product_detail/screens/product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: HomeScreenBody(),
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        AddressBoxW(),
        SizedBox(height: 10),
        TopCategoriesW(),
        SizedBox(height: 10),
        CarouselSliderImageW(),
        DealOfTheDayW(),
        ShowAllProducts(),
      ],
    );
  }
}

class ShowAllProducts extends StatefulWidget {
  const ShowAllProducts({super.key});

  @override
  State<ShowAllProducts> createState() => _ShowAllProductsState();
}

class _ShowAllProductsState extends State<ShowAllProducts> {
  final homeService = HomeServices();

  @override
  void initState() {
    super.initState();
    loadAllProducts();
  }

  List<Product>? products;

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : ListView.builder(
            physics:
                const NeverScrollableScrollPhysics(), // prevent internal scrolling
            shrinkWrap: true, // take only needed space
            itemCount: products!.length,
            itemBuilder: (context, index) => ProductTile(
              product: products![index],
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailScreen(product: products![index]),
                    ));
              },
            ),
          );
  }

  void loadAllProducts() async {
    products = await homeService.fetchAllProducts(context);
    setState(() {});
    log(products!.length.toString());
  }
}
