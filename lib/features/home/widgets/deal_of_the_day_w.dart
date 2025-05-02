import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/loader.dart';
import 'package:flutter_amazon_clone/features/admin/model/product.dart';
import 'package:flutter_amazon_clone/features/admin/model/rating.dart';
import 'package:flutter_amazon_clone/features/home/service/home_services.dart';
import 'package:flutter_amazon_clone/features/product_detail/screens/product_detail_screen.dart';

class DealOfTheDayW extends StatefulWidget {
  const DealOfTheDayW({super.key});

  @override
  State<DealOfTheDayW> createState() => _DealOfTheDayWState();
}

class _DealOfTheDayWState extends State<DealOfTheDayW> {
  Product? product;
  final homeService = HomeServices();

  @override
  void initState() {
    super.initState();
    _dealOfDay();
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: _navigateToDetailScreen,
                child: Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Text(
                          'Deal of the day',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),

                      // Image Carousel
                      SizedBox(
                        height: 220,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: product!.images.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 8),
                            itemBuilder: (context, index) => ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: CachedNetworkImage(
                                  imageUrl: product!.images[index],
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: Colors.grey[200],
                                    child: const Center(child: Loader()),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Product Info
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Name
                            Text(
                              product!.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),

                            const SizedBox(height: 8),

                            // Price and Rating
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Price
                                Text(
                                  '\$${product!.price.toStringAsFixed(2)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),

                                // Rating (if available)
                                if (product!.rating != null &&
                                    product!.rating!.isNotEmpty)
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        _calculateAverageRating(
                                                product!.rating!)
                                            .toStringAsFixed(1),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // See All Button
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 16),
                        child: Text(
                          'See all deals',
                          style: TextStyle(
                            color: Colors.cyan.shade800,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }

  double _calculateAverageRating(List<Rating> ratings) {
    if (ratings.isEmpty) return 0;
    final sum = ratings.fold(0.0, (total, current) => total + current.rating);
    return sum / ratings.length;
  }

  void _dealOfDay() async {
    product = await homeService.fetchDealOfDay(context: context);
    setState(() {});
  }

  void _navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }
}
