import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/admin/screen/add_product_screen.dart';

class FloatingActionBtnW extends StatelessWidget {
  const FloatingActionBtnW({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: const Color.fromARGB(255, 29, 201, 192),
      onPressed: () {
        Navigator.of(context).pushNamed(AddProductScreen.routeName);
      },
      tooltip: 'Add a product',
      child: const Icon(Icons.add),
    );
  }
}
