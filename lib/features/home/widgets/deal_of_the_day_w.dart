import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/cached_network_image_w.dart';
import 'package:flutter_amazon_clone/common/widgets/loader.dart';
import 'package:flutter_amazon_clone/features/admin/model/product.dart';
import 'package:flutter_amazon_clone/features/home/service/home_services.dart';
import 'package:flutter_amazon_clone/features/product_detail/screens/product_detail_screen.dart';

class DealOfTheDayW extends StatefulWidget {
  const DealOfTheDayW({super.key});

  static const _padding = EdgeInsets.only(left: 10, top: 15);

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
            : InkWell(
                onTap: _navigateToDetailScreen,
                child: Column(
                  children: [
                    Container(
                      padding: DealOfTheDayW._padding,
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Deal of the day',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 300,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: product!.images
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: CachedNetworkImageW(
                                    imageUrl: e,
                                    fit: BoxFit.fill,
                                    width: 200,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        '${product!.price}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        product!.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ).copyWith(left: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'See all ',
                        style: TextStyle(color: Colors.cyan.shade800),
                      ),
                    )
                  ],
                ),
              );
  }

  void _dealOfDay() async {
    product = await homeService.fetchDealOfDay(context: context);
    setState(() {});
  }

  void _navigateToDetailScreen() {
    Navigator.pushNamed(context, ProductDetailScreen.pageName,
        arguments: product);
  }
}
