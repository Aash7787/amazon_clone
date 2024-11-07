import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/account_btn_w.dart';
import 'package:flutter_amazon_clone/common/widgets/btn_w.dart';
import 'package:flutter_amazon_clone/features/account/service/account_service.dart';

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
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: AccountBtnW(text: _yourOrder)),
            Expanded(child: AccountBtnW(text: _turnSeller)),
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
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Log Out'),
                        content: const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Do you want to log out?',
                            style: TextStyle(fontSize: 23),
                          ),
                        ),
                        actions: [
                          BtnW(
                            btnText: 'Yes',
                            borderRadius: 23,
                            onTap: () {
                              AccountService().logOut(context);
                              Navigator.pop(context); // Close dialog
                            },
                          ),
                          BtnW(
                            btnText: 'No',
                            borderRadius: 23,
                            onTap: () => Navigator.pop(context), // Close dialog
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            const Expanded(
              child: AccountBtnW(text: _yourWishList),
            ),
          ],
        ),
      ],
    );
  }
}
