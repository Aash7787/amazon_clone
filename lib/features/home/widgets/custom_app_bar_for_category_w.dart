import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';

class CustomAppBarForCategoryW extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarForCategoryW({super.key, required this.category});

  final String category;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables
                .appBarGradient, // Use the gradient from GlobalVariables
          ),
        ),
        title: Text(category));
  }
}
