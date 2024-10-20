import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/auth/providers/user_auth_provider.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserAuthProvider>().user;
    num sum = 0;
    user.cart
        .map(
          (e) => sum += e['quantity'] * e['product']['price'] as num,
        )
        .toList();
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Text(
            'Subtotal ',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            '\$ $sum',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
