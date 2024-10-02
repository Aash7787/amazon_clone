import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/auth/providers/user_auth_provider.dart';
import 'package:flutter_amazon_clone/features/home/widgets/app_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const pageName = 'home_screen';

  @override
  Widget build(BuildContext context) {
    final userAuthProvider = context.watch<UserAuthProvider>();

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectableText(
              userAuthProvider.user.toString(),
            ),
            const Text(pageName)
          ],
        ),
      ),
    );
  }
}
