import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';

class TopCategoriesW extends StatelessWidget {
  const TopCategoriesW({super.key});

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
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
