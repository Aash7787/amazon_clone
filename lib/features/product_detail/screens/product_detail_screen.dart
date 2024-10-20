import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/btn_w.dart';
import 'package:flutter_amazon_clone/common/widgets/select_text_w.dart';
import 'package:flutter_amazon_clone/common/widgets/star_rating_bar_w.dart';
import 'package:flutter_amazon_clone/features/admin/model/product.dart';
import 'package:flutter_amazon_clone/features/auth/providers/user_auth_provider.dart';
import 'package:flutter_amazon_clone/features/product_detail/service/product_detail_service.dart';
import 'package:flutter_amazon_clone/features/product_detail/widgets/carousel_slider_detail_w.dart';
import 'package:flutter_amazon_clone/features/product_detail/widgets/rating_bar_builder_w.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/product_detail_app_bar_w.dart';

double myRating = 0;

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  static const pageName = 'product/detail/screen';

  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  static const _buyNowT = 'Buy now';
  static const _addToCartT = 'Add to Cart';

  final ProductDetailService _productDetailService = ProductDetailService();

  double avgRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating;
    for (var i = 0; i < widget.product.rating!.length; i++) {
      totalRating = widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          context.read<UserAuthProvider>().user.id) {
        myRating = widget.product.rating![i].rating;
      }
      if (widget.product.rating!.isNotEmpty) {
        avgRating = totalRating / widget.product.rating!.length;
      }
    }
  }

  void _addToCart() {
    _productDetailService.addToCart(context: context, product: widget.product);
  }

  // @override
  // void didUpdateWidget(covariant ProductDetailScreen oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   double totalRating;
  //   for (var i = 0; i < widget.product.rating!.length; i++) {
  //     totalRating = widget.product.rating![i].rating;
  //     if (widget.product.rating![i].userId ==
  //         context.read<UserAuthProvider>().user.id) {
  //       myRating = widget.product.rating![i].rating;
  //     }
  //     if (widget.product.rating!.isNotEmpty) {
  //       avgRating = totalRating / widget.product.rating!.length;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProductDetailAppBarW(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 25,
                    child: FittedBox(
                      child: SelectTextW(widget.product.id ?? 'not found'),
                    ),
                  ),
                  const Spacer(
                    flex: 15,
                  ),
                  Expanded(
                    flex: 11,
                    child: StarRatingBarW(
                      rating: avgRating,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SelectTextW(widget.product.name),
              ),
              LayoutBuilder(
                builder: (context, constrains) {
                  return CarouselSliderDetailW(
                    images: widget.product.images,
                    width: constrains.maxWidth,
                  );
                },
              ),
              Container(
                height: 5,
                color: Colors.black38,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RichText(
                  text: TextSpan(
                    text: 'Deal Price : ',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: ' \$${widget.product.price}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SelectTextW(widget.product.description),
              Container(
                height: 5,
                color: Colors.black38,
              ),
              const BtnW(
                btnText: _buyNowT,
                vertical: 10,
              ),
              const SizedBox(
                height: 5,
              ),
              BtnW(
                onTap: _addToCart,
                btnText: _addToCartT,
                textColor: Colors.black,
                btnColor: Colors.yellow.shade600,
                vertical: 10,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 5,
                color: Colors.black38,
              ),
              const SelectTextW(
                'Rate the Product',
                fontWeight: FontWeight.bold,
              ),
              RatingBarBuilderW(
                initialRating: myRating,
                onRatingUpdate: (value) {
                  myRating = value;
                  _productDetailService.rateProduct(
                    context: context,
                    product: widget.product,
                    rating: value,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
