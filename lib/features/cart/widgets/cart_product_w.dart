import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/admin/model/product.dart';
import 'package:flutter_amazon_clone/features/product_detail/screens/product_detail_screen.dart';
import 'package:flutter_amazon_clone/features/product_detail/service/product_detail_service.dart';

class CartProductW extends StatefulWidget {
  const CartProductW(
      {super.key, required this.product, required this.quantity});

  final Product product;

  static const topPadding = 6.0;

  final num quantity;

  @override
  State<CartProductW> createState() => _CartProductWState();
}

class _CartProductWState extends State<CartProductW> {
  final productDetailService = ProductDetailService();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailScreen.routeName,
            arguments: widget.product);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CachedNetworkImage(
                  imageUrl: widget.product.images[0], // URL of the image
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
                    padding:
                        const EdgeInsets.only(top: CartProductW.topPadding),
                    child: Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(top: CartProductW.topPadding),
                    child: Text(
                      '\$ ${widget.product.price}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: CartProductW.topPadding - 3),
                    child: Text('Eligible for free Shipping'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        top: CartProductW.topPadding - 3, bottom: 10),
                    child: Text(
                      'In Stock',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              )
            ],
          ),
          Container(
            // width: 60,
            margin: const EdgeInsets.all(
              10,
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: _decreaseQuantity,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.remove,
                      size: 18,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                      width: 1.5,
                    ),
                    color: Colors.white,
                  ),
                  width: 35,
                  height: 35,
                  child: Center(
                    child: Text('${widget.quantity}'),
                  ),
                ),
                InkWell(
                  onTap: _incrementQuantity,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      color: Colors.black12,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _incrementQuantity() {
    productDetailService.addToCart(
      context: context,
      product: widget.product,
    );
  }

  void _decreaseQuantity() {
    productDetailService.removeToCart(
      context: context,
      product: widget.product,
    );
  }
}
