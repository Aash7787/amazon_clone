import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/loader.dart';
import 'package:flutter_amazon_clone/features/admin/model/product.dart';
import 'package:flutter_amazon_clone/features/admin/service/admin_service.dart';
import 'package:flutter_amazon_clone/features/admin/widgets/custom_grid_view.dart';
import 'package:flutter_amazon_clone/features/admin/widgets/floating_action_btn_w.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  static const routeName = 'postsScreen';

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> products = [];

  @override
  void didChangeDependencies() {
    fetchAllProduct();
    super.didChangeDependencies();
  }

  fetchAllProduct() async {
    products = await context.watch<AdminService>().fetchAllProducts(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: const FloatingActionBtnW(),
        body: products.isEmpty
            ? const Loader()
            : AllProductsGrid(products: products));
  }
}

class AllProductsGrid extends StatelessWidget {
  const AllProductsGrid({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminService>(
      builder: (context, value, child) => GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 350,
        ),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final product = products[index];
          return GridViewItemBuilder(
            product: product,
            onPressed: () => _deleteProduct(product, index, context),
          );
        },
      ),
    );
  }

  void _deleteProduct(Product product, int index, context) {
    AdminService().deleteProduct(
      context: context,
      product: product,
    );
  }
}
