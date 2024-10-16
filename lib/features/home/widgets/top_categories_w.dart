import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/home/screen/category_deals_screen.dart';

class TopCategoriesW extends StatelessWidget {
  const TopCategoriesW({super.key});

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.of(context)
        .pushNamed(CategoryDealsScreen.pageName, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ListView.builder(
        itemExtent: 85,
        itemCount: GlobalVariables.carouselImages.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(
            left: 15,
          ),
          child: InkWell(
            onTap: () => navigateToCategoryPage(
                context, GlobalVariables.categoryImages[index]['title']!),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(
                    GlobalVariables.categoryImages[index]['image']!,
                  ),
                ),
                Text(
                  GlobalVariables.categoryImages[index]['title']!,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        ),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
