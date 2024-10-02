import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/providers/user_auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const pageName = 'home_screen';

  @override
  Widget build(BuildContext context) {
    final userAuthProvider = context.watch<UserAuthProvider>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectableText(
              userAuthProvider.user.toString(),
            ),
          ],
        ),
      ),
    );
  }
}

class MyEleBtn extends StatelessWidget {
  const MyEleBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: const Text('Click me'),
    );
  }
}
