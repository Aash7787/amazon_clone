import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/auth/providers/user_auth_provider.dart';
import 'package:provider/provider.dart';

class BelowAppBarW extends StatelessWidget {
  const BelowAppBarW({super.key});

  static const _edgeInsets = 10.0;

  static const _fontSize = 25.0;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserAuthProvider>().user;
    return Container(
      decoration: const BoxDecoration(gradient: GlobalVariables.appBarGradient),
      padding: const EdgeInsets.only(
          left: _edgeInsets, right: _edgeInsets, bottom: _edgeInsets - 5),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: 'Hello, ',
              style: const TextStyle(
                fontSize: _fontSize,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: user.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: _fontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
