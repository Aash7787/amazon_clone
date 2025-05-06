import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/account_btn_w.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';

class TopButtonsW extends StatelessWidget {
  const TopButtonsW({super.key});

  static const _yourOrder = 'Your Order';
  static const _turnSeller = 'Turn Seller';
  static const _logOut = 'Log Out';
  static const _yourWishList = 'Your Wish List';

  static const height = 15.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: AccountBtnW(
              text: _yourOrder,
              onPressed: () {},
            )),
            Expanded(
                child: AccountBtnW(
              text: _turnSeller,
              longPressed: _turnToSeller,
              onPressed: () {
                showSnackBar(context, 'You need special permission for that !');
              },
            )),
          ],
        ),
        const SizedBox(
          height: height,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AccountBtnW(
                text: _logOut,
                onPressed: () => logOut(context),
              ),
            ),
            Expanded(
              child: AccountBtnW(
                text: _yourWishList,
                onPressed: () {
                  showSnackBar(context, 'No Wish found');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _turnToSeller() {
    
  }
}
