import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/select_text_w.dart';
import 'package:flutter_amazon_clone/features/account/widgets/product_tile_w.dart';
import 'package:flutter_amazon_clone/features/admin/model/product.dart';
import 'package:flutter_amazon_clone/features/admin/service/admin_service.dart';

class CustomGridView extends StatefulWidget {
  const CustomGridView({super.key, required this.productList});

  final List<Product> productList;

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
  @override
  Widget build(BuildContext context) {
    void deleteProduct(Product product, int index) {
      AdminService().deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          widget.productList.removeAt(index);
          setState(() {});
        },
      );
    }

    log('${widget.productList} is the list ');

    return GridView.builder(
      itemCount: widget.productList.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) => GirdViewItemBuilder(
        onPressed: () => deleteProduct(widget.productList[index], index),
        product: widget.productList[index],
      ),
    );
  }
}

class GirdViewItemBuilder extends StatelessWidget {
  const GirdViewItemBuilder({super.key, required this.product, this.onPressed});

  final Product product;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ProductTileW(
            image: product.images[0],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 0),
          child: Row(
            children: [
              Expanded(
                child: SelectTextW(product.name),
              ),
              IconButton(
                onPressed: onPressed,
                icon: const Icon(Icons.delete),
              )
            ],
          ),
        )
      ],
    );
  }
}
