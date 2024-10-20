import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/home/widgets/address_box_w.dart';
import 'package:flutter_amazon_clone/features/home/widgets/custom_app_bar.dart';
import 'package:flutter_amazon_clone/features/home/widgets/carousel_slider_image_w.dart';
import 'package:flutter_amazon_clone/features/home/widgets/deal_of_the_day_w.dart';
import 'package:flutter_amazon_clone/features/home/widgets/top_categories_w.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressBoxW(),
            SizedBox(
              height: 10,
            ),
            TopCategoriesW(),
            SizedBox(
              height: 10,
            ),
            CarouselSliderImageW(),
            DealOfTheDayW()
          ],
        ),
      ),
    );
  }
}
