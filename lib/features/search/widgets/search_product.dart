import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/star_rating_bar_w.dart';
import 'package:flutter_amazon_clone/features/admin/model/product.dart';
import 'package:flutter_amazon_clone/features/product_detail/screens/product_detail_screen.dart';

class SearchProduct extends StatelessWidget {
  const SearchProduct({super.key, required this.product});

  final Product product;

  static const topPadding = 6.0;

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    for (var i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }
    double avgRating = 0;
    if (product.rating!.isNotEmpty) {
      avgRating = totalRating / product.rating!.length;
    }

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailScreen.pageName,
            arguments: product);
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CachedNetworkImage(
              imageUrl: product.images[0], // URL of the image
              fit: BoxFit.fitHeight,
              height: 135,
              width: 135,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.no_photography_outlined),
            ),
          ),
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
              Padding(
                padding: const EdgeInsets.only(top: topPadding),
                child: StarRatingBarW(rating: avgRating),
              ),
              Container(
                padding: const EdgeInsets.only(top: topPadding),
                child: Text(
                  '\$ ${product.price}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
