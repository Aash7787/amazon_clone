import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/star_rating_bar_w.dart';
import 'package:flutter_amazon_clone/features/admin/model/product.dart';

class SearchProduct extends StatelessWidget {
  const SearchProduct({super.key, required this.product});

  final Product product;

  static const topPadding = 6.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Image.network(
              product.images[0], // URL of the image
              fit: BoxFit.fitHeight,
              height: 135,
              width: 135,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  // Image has finished loading
                  return child;
                }
                // Show progress indicator while the image loads
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null, // Progress bar value
                  ),
                );
              },
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: topPadding),
              child: Text(
                product.name,
                style: const TextStyle(
                  fontSize: 16,
                ),
                maxLines: 2,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: topPadding),
              child: StarRatingBarW(rating: 4.3),
            ),
            Container(
              padding: const EdgeInsets.only(top: topPadding),
              child: Text(
                '\$${product.price}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: topPadding - 3),
              child: Text('Eligible for free Shipping'),
            ),
            const Padding(
              padding: EdgeInsets.only(top: topPadding - 3, bottom: 10),
              child: Text(
                'In Stock',
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ],
        )
      ],
    );
  }
}
