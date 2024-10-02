import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/account/widgets/below_app_bar_w.dart';
import 'package:flutter_amazon_clone/features/account/widgets/top_buttons_w.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  static const pageName = 'account/screen';

  static const _amazonImgAsset = 'assets/imgs/amazon_in.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  _amazonImgAsset,
                  width: 125,
                  height: 50,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(Icons.search),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: const Column(
        children: [
          BelowAppBarW(),
          SizedBox(
            height: 10,
          ),
          TopButtonsW(),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
