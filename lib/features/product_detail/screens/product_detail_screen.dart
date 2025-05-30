import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/btn_w.dart';
import 'package:flutter_amazon_clone/common/widgets/select_text_w.dart';
import 'package:flutter_amazon_clone/common/widgets/star_rating_bar_w.dart';
import 'package:flutter_amazon_clone/features/admin/model/product.dart';
import 'package:flutter_amazon_clone/features/admin/model/rating.dart';
import 'package:flutter_amazon_clone/features/ai_product_detail/screen/ai_product_detail_screen.dart';
import 'package:flutter_amazon_clone/features/ai_product_detail/service/bloc/ai_product_detail_bloc.dart';
import 'package:flutter_amazon_clone/features/auth/providers/user_auth_provider.dart';
import 'package:flutter_amazon_clone/features/cart/screen/cart_screen.dart';
import 'package:flutter_amazon_clone/features/home/widgets/custom_app_bar.dart';
import 'package:flutter_amazon_clone/features/product_detail/service/product_detail_service.dart';
import 'package:flutter_amazon_clone/features/product_detail/widgets/carousel_slider_detail_w.dart';
import 'package:flutter_amazon_clone/features/product_detail/widgets/rating_bar_builder_w.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

double myRating = 0;

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  static const routeName = 'product/detail/screen';

  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  static const _buyNowT = 'Buy now';
  static const _addToCartT = 'Add to Cart';
  static const _askAiAboutItT = 'Ask Ai';

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

  void _addToCart(BuildContext context) {
    _productDetailService.addToCart(context: context, product: widget.product);
    Navigator.pop(context);
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
      appBar: const CustomAppBar(),
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
              BtnW(
                btnText: _buyNowT,
                vertical: 10,
                onTap: () async {
                  _addToCart(context);
                  await Future.delayed(Durations.medium1);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
              ),
              BtnW(
                onTap: _askAiAboutIt,
                btnText: _askAiAboutItT,
                textColor: Colors.white,
                btnColor: Colors.blue,
                vertical: 10,
              ),
              BtnW(
                onTap: () => _addToCart(context),
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

  void _askAiAboutIt() {
    final generatePrompt = generateProductPrompt(
      name: widget.product.name,
      description: widget.product.description,
      price: widget.product.price,
      quantity: widget.product.quantity,
      category: widget.product.category,
      images: widget.product.images,
      averageRating: calculateAverageRating(widget.product.rating), // Optional
    );
    Navigator.pushNamed(context, AiProductDetailScreen.route,
        arguments: (promptMessage: generatePrompt));

    context.read<AiProductDetailBloc>().add(
          AiProductSendResponse(generatePrompt),
        );
  }

  String generateProductPrompt({
    required String name,
    required String description,
    required double price,
    required int quantity,
    required String category,
    required List<String> images,
    double? averageRating,
  }) {
    return '''
Hi, I found a product called "$name" in the $category category.

Here’s what I know about it:
- Description: $description
- Price: \$${price.toStringAsFixed(2)}
- Available Quantity: $quantity
${averageRating != null ? "- Average Rating: $averageRating\n" : ""}
- It has ${images.length} images available.

Can you please tell me:
- Is this product worth the price?
- Do you think the price is expensive or fair?
- How good is the rating compared to similar products?
- Based on the description, do you recommend it?

Answer in a friendly, helpful way as if you're guiding me before a purchase.
''';
  }

  double? calculateAverageRating(List<Rating>? ratings) {
    if (ratings == null || ratings.isEmpty) return null;

    double sum = 0;
    for (var rating in ratings) {
      sum += rating.rating;
    }
    return sum / ratings.length;
  }
}
