import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/btn_w.dart';
import 'package:flutter_amazon_clone/features/address/screen/address_screen.dart';
import 'package:flutter_amazon_clone/features/admin/model/product.dart';
import 'package:flutter_amazon_clone/features/auth/providers/user_auth_provider.dart';
import 'package:flutter_amazon_clone/features/cart/widgets/app_bar_cart.dart';
import 'package:flutter_amazon_clone/features/cart/widgets/cart_product_w.dart';
import 'package:flutter_amazon_clone/features/cart/widgets/cart_subtotal.dart';
import 'package:flutter_amazon_clone/features/home/widgets/address_box_w.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const routeName = 'cart/screen';

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserAuthProvider>().user;

    return Scaffold(
      appBar: const AppBarCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBoxW(),
            const CartSubtotal(),
            BtnW(
              btnText: 'Proceed to Buy (${user.cart.length} items)',
              btnColor: Colors.yellow.shade600,
              textColor: Colors.black,
              onTap: () {
                Navigator.pushNamed(context, AddressScreen.routeName);
              },
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.black12,
              height: 2,
            ),
            // const SizedBox(height: 10),
            ListView.builder(
              itemCount: user.cart.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CartProductW(
                  quantity: user.cart[index]['quantity'],
                  product: Product.fromMap(
                    user.cart[index]['product'],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
