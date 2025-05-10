import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/cached_network_image_w.dart';
import 'package:flutter_amazon_clone/common/widgets/select_text_w.dart';
import 'package:flutter_amazon_clone/features/admin/model/product.dart';

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
      margin: const EdgeInsets.all(4),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Expanded(
              child: CachedNetworkImageW(
                width: double.infinity,
                fit: BoxFit.fill,
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
