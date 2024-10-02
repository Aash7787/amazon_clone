import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/account/widgets/app_bar.dart';
import 'package:flutter_amazon_clone/features/account/widgets/below_app_bar_w.dart';
import 'package:flutter_amazon_clone/features/account/widgets/orders.dart';
import 'package:flutter_amazon_clone/features/account/widgets/top_buttons_w.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  static const pageName = 'account/screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          BelowAppBarW(),
          SizedBox(
            height: 10,
          ),
          TopButtonsW(),
          SizedBox(
            height: 10,
          ),
          Orders()
        ],
      ),
    );
  }
}
