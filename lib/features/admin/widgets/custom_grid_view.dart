import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/cached_network_image_w.dart';
import 'package:flutter_amazon_clone/common/widgets/select_text_w.dart';
import 'package:flutter_amazon_clone/features/admin/model/product.dart';
import 'package:flutter_amazon_clone/features/admin/service/admin_service.dart';

class CustomGridView extends StatefulWidget {
  const CustomGridView({super.key, required this.productList});

  final List<Product> productList;

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
  void _deleteProduct(Product product, int index) {
    AdminService().deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        setState(() {
          widget.productList.removeAt(index);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    log('${widget.productList} is the list');

    return GridView.builder(
      itemCount: widget.productList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 350,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // if nested
      itemBuilder: (context, index) {
        final product = widget.productList[index];
        return GridViewItemBuilder(
          product: product,
          onPressed: () => _deleteProduct(product, index),
        );
      },
    );
  }
}

class GridViewItemBuilder extends StatelessWidget {
  const GridViewItemBuilder({
    super.key,
    required this.product,
    this.onPressed,
  });

  final Product product;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Expanded(
              child: CachedNetworkImageW(
                width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: product.images[0],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SelectTextW(
                    product.name,
                    maxLines: 2,
                  ),
                ),
                IconButton(
                  onPressed: onPressed,
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
