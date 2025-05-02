import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/loader.dart';
import 'package:flutter_amazon_clone/features/admin/model/product.dart';
import 'package:flutter_amazon_clone/features/admin/service/admin_service.dart';
import 'package:flutter_amazon_clone/features/admin/widgets/custom_grid_view.dart';
import 'package:flutter_amazon_clone/features/admin/widgets/floating_action_btn_w.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  static const routeName = 'postsScreen';

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final admin = AdminService();

  List<Product>? _products;

  @override
  void initState() {
    fetchAllProduct();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    fetchAllProduct();
    super.didChangeDependencies();
  }

  fetchAllProduct() async {
    log('$_products before');

    _products = await admin.fetchAllProducts(context);
    setState(() {});
    log('$_products');
  }

  @override
  Widget build(BuildContext context) {
    return _products == null
        ? const Loader()
        : Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: const FloatingActionBtnW(),
            body: CustomGridView(
              productList: _products!,
            ),
          );
  }
}
